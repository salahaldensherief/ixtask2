import 'package:flutter/material.dart';

import '../../data/models/pizza_item_model.dart';

class PizzaSelectCard extends StatelessWidget {
  final PizzaItemModel pizza;
  final VoidCallback onAdd;
  const PizzaSelectCard({super.key, required this.pizza, required this.onAdd});
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Center(
                child: Text(pizza.icon!, style: const TextStyle(fontSize: 64)),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              pizza.name,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              pizza.description,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '\$${pizza.basePrice}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepOrange,
                  ),
                ),
                IconButton(
                  onPressed: onAdd,
                  icon: const Icon(Icons.add_circle, color: Colors.green),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
