import 'package:flutter/material.dart';
import 'package:task2ix/data/models/cart_model.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key, required this.cart});
  final CartModel cart;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Order Summary',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  SummaryRow(title: 'Subtotal', value: '\$${cart.subTotalPrice}'),
                  SummaryRow(title: 'Delivery Fee', value: '\$${cart.deliveryFee}'),
                  SummaryRow(title: 'Tax', value: '\$${cart.taxPercent}'),
                  const Divider(height: 24),
                  SummaryRow(
                    title: 'Total',
                    value: '\$${cart.totalPrice.toStringAsFixed(2)}',
                    isTotal: true,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: const [
                  Icon(Icons.payment),
                  SizedBox(width: 12),
                  Text(
                    'Cash on Delivery',
                    style: TextStyle(fontSize: 16),
                  ),
                  Spacer(),
                  Icon(Icons.arrow_forward_ios, size: 16),
                ],
              ),
            ),

            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Confirm Order',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SummaryRow extends StatelessWidget {
  final String title;
  final String value;
  final bool isTotal;

  const SummaryRow({
    required this.title,
    required this.value,
    this.isTotal = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: isTotal ? 16 : 14,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: TextStyle(
              fontSize: isTotal ? 16 : 14,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
