import 'package:flutter/material.dart';
import 'package:task2ix/presentation/widgets/pizza_select_card.dart';

import '../../data/models/pizza_item_model.dart';

class RecommendedPizzaWidget extends StatelessWidget {
 const RecommendedPizzaWidget({super.key, required this.onAdd, });
 final Function(PizzaItemModel)? onAdd;

 @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        const Text(
          'Recommended Pizza :',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        // SizedBox(
        //   height: 200,
        //   child: ListView.builder(
        //
        //     shrinkWrap: true,
        //       itemCount: pizzas.length,
        //       scrollDirection: Axis.horizontal,
        //       itemBuilder: (context, index) {
        //         final pizza = pizzas[index];
        //         return PizzaSelectCard(, onAdd: (){
        //
        //           if (onAdd != null) onAdd!(pizza);
        //
        //         },);
        //       }
        //   ),
        // ),
      ],
    );
  }
}