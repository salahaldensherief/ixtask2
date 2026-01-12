import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task2ix/presentation/cubits/layout/pizza_layout_cubit.dart';
import 'package:task2ix/presentation/pizza_cart_screen.dart';
import 'package:task2ix/presentation/widgets/pizza_card.dart';

import '../data/models/pizza_item_model.dart';

class Layout extends StatefulWidget {
  const Layout({super.key});

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  @override
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<PizzaLayoutCubit>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pizza Menu'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () async {
              await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => PizzaCartScreen(items: cubit.items),
                ),
              );
              setState(() {});
            },
          ),
        ],
      ),
      body: BlocBuilder<PizzaLayoutCubit, PizzaLayoutState>(
        builder: (context, state) {
          if (state is PizzaLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is PizzaFailure) {
            return const Center(child: Text('There was an error'));
          }

          if (state is PizzaSuccess) {
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
                  final pizzaItem = pizzas[index];

                  final cartIndex = cubit.items.indexWhere(
                    (item) => item.id == pizzaItem.id,
                  );

                  final bool isAdded = cartIndex != -1;
                  final PizzaItemModel? cartItem =
                      isAdded ? cubit.items[cartIndex] : null;

                  return PizzaCard(
                    pizzas: pizzaItem,

                    icon:
                        isAdded
                            ? Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {});
                                    setState(() {
                                      if (cartItem!.quantity > 1) {
                                        cartItem.decreaseQty();
                                      } else {
                                        cubit.items.removeAt(cartIndex);
                                      }
                                    });
                                  },
                                  child: const Icon(Icons.remove, size: 18),
                                ),

                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 6,
                                  ),
                                  child: Text(
                                    cartItem!.quantity.toString(),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),

                                GestureDetector(
                                  onTap: () {
                                    setState(() {});
                                    setState(() {
                                      cartItem.increaseQty();
                                    });
                                  },
                                  child: const Icon(Icons.add, size: 18),
                                ),
                              ],
                            )
                            : const Icon(Icons.add, size: 18),

                    onPressed: () {
                      setState(() {});
                      setState(() {
                        if (!isAdded) {
                          cubit.items.add(pizzaItem.cloneForCart());
                        }
                      });
                    },
                  );
                },
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
