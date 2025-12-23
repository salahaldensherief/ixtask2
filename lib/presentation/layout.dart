import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task2ix/presentation/cubits/fav/fav_cubit.dart';
import 'package:task2ix/presentation/cubits/layout/pizza_layout_cubit.dart';
import 'package:task2ix/presentation/fav_screen.dart';
import 'package:task2ix/presentation/pizza_checkout_screen.dart';
import 'package:task2ix/presentation/widgets/pizza_card.dart';

import '../data/repos/pizza_repo.dart';
import '../data/source/local/pizza_data_source.dart';

class Layout extends StatelessWidget {
  const Layout({super.key});

  @override
  Widget build(BuildContext context) {
    PizzaLayoutCubit cubit=PizzaLayoutCubit(PizzaRepo(PizzaDataSource()));
    return Scaffold(
      appBar: AppBar(title: const Text('Pizza Menu'),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
                  BlocProvider(
                    create: (context) => FavCubit(),
                    child: FavScreen(),
                  ),));
            },
          )),
      body: BlocBuilder<PizzaLayoutCubit, PizzaLayoutState>(
        builder: (context, state) {
          if (state is PizzaLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PizzaSuccess) {
            final pizzas = state.pizza;
            print(pizzas.length);
            return Padding(
              padding: const EdgeInsets.all(12),
              child: GridView.builder(
                itemCount: pizzas.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 0.75,
                ),
                itemBuilder: (context, index) {
              final pizza = pizzas[index];
                  return GestureDetector(
                    onTap: () {
                      cubit.items.add(pizza);
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              PizzaCheckoutScreen(pizzas: pizzas, items: cubit.items,),
                        ),
                      );
                    },
                    child: BlocProvider(
                      create: (context) => FavCubit(),
                      child: PizzaCard(pizzas: pizza),
                    ),
                  );
                },
              ),
            );
          } else if (state is PizzaFailure) {
            return Center(child: Text('there was an error'));
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
