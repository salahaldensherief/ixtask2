import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task2ix/presentation/widgets/pizza_select_card.dart';

import '../../data/models/pizza_item_model.dart';
import '../cubits/layout/pizza_layout_cubit.dart';

class RecommendedPizzaWidget extends StatelessWidget {
  const RecommendedPizzaWidget({super.key, required this.onAdd});
  final Function(PizzaItemModel)? onAdd;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Recommended Pizza :',style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
        SizedBox(height: 20,),
        BlocBuilder<PizzaLayoutCubit, PizzaLayoutState>(
          builder: (context, state) {
            if (state is PizzaSuccess) {
              final pizzas = state.pizza;
              return SizedBox(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: pizzas.length,
                  itemBuilder: (context, index) {
                    final pizza = pizzas[index];
                    return PizzaSelectCard(
                      pizza: pizza,
                      onAdd: () {
                        if (onAdd != null) onAdd!(pizza);
                      },
                    );
                  },
                ),
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ],
    );
  }
}
