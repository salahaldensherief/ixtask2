import 'package:flutter/material.dart';
import '../../data/models/pizza_item_model.dart';

class PizzaCard extends StatelessWidget {
  final PizzaItemModel pizzas;
  final Icon? icon;
  void Function()? onPressed;
  PizzaCard({super.key, required this.pizzas,  this.icon,required this.onPressed});


  @override
  Widget build(BuildContext context) {

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Center(
                child: Text(pizzas.icon!, style: TextStyle(fontSize: 64)),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              pizzas.name,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              pizzas.description,
              style: TextStyle(fontSize: 12, color: Colors.grey),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '\$${pizzas.basePrice}',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepOrange,
                  ),
                ),
                TextButton(onPressed:onPressed,
                child:   icon?? Icon(Icons.shopping_cart)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
