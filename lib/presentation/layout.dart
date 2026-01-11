import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task2ix/data/models/cart_model.dart';
import 'package:task2ix/presentation/cubits/layout/pizza_layout_cubit.dart';
import 'package:task2ix/presentation/pizza_cart_screen.dart';
import 'package:task2ix/presentation/widgets/pizza_card.dart';

class Layout extends StatefulWidget {
  Layout({super.key});
  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  late CartModel cart;


  @override
  Widget build(BuildContext context) {
    final cubit = context.read<PizzaLayoutCubit>();
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
                final isAdded = cubit.items.any(
                    (item) => item.id == pizzas[index].id,
                  );
                  final pizza = pizzas[index].cloneForCart();
                  return PizzaCard(
                    pizzas: pizzas[index],
                    icon: isAdded ? Icon(Icons.check) : Icon(Icons.add),
                    onPressed: () {
                      if (!isAdded) {
                        cubit.items.add(pizza);
                      setState(() {});
                      }
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
