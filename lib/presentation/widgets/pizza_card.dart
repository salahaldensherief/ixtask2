import 'package:flutter/material.dart';

import '../../data/models/pizza_item_model.dart';

class PizzaCard extends StatefulWidget {
  final PizzaItemModel? pizzas;
  PizzaCard({super.key, this.pizzas});

  @override
  State<PizzaCard> createState() => _PizzaCardState();
}

class _PizzaCardState extends State<PizzaCard> {
bool isFav = false;

  void initState() {
    super.initState();
    isFav = false;
  }
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
                child: Text(widget.pizzas!.icon!, style: TextStyle(fontSize: 64)),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.pizzas!.name,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              widget.pizzas!.description,
              style: TextStyle(fontSize: 12, color: Colors.grey),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            Row(
              children: [
                Text(
                  '\$${widget.pizzas!.basePrice}',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepOrange,
                  ),
                ),
                TextButton(onPressed:(){
                  setState(() {
                    isFav = !isFav;
                  });
                } , child: Icon(isFav ? Icons.favorite: Icons.favorite_border))
              ],
            ),
          ],
        ),
      ),
    );
  }
}