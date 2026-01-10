import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task2ix/data/models/cart_model.dart';
import 'package:task2ix/presentation/cubits/layout/pizza_layout_cubit.dart';
import 'package:task2ix/presentation/pizza_cart_screen.dart';
import 'package:task2ix/presentation/widgets/pizza_card.dart';

import '../data/repos/pizza_repo.dart';
import '../data/source/local/pizza_data_source.dart';

class Layout extends StatefulWidget {
  Layout({super.key});

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  late CartModel cart;

  @override
  Widget build(BuildContext context) {
    PizzaLayoutCubit cubit = PizzaLayoutCubit(PizzaRepo(PizzaDataSource()));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pizza Menu'),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 5),
            child: IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => PizzaCartScreen(items: cubit.items),
                  ),
                );
              },
              icon: Icon(Icons.shopping_cart),
            ),
          ),
        ],
      ),
      body: BlocBuilder<PizzaLayoutCubit, PizzaLayoutState>(
        builder: (context, state) {
          if (state is PizzaLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PizzaSuccess) {
            final pizzas = state.pizza;
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
                  return PizzaCard(
                    pizzas: pizzas[index],
                    icon:  Icon(Icons.add),
                    onPressed: () {
                      final pizza = pizzas[index].cloneForCart();
                      cubit.items.add(pizza);
                    },
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
