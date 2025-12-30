import 'package:flutter/material.dart';

class PaymentSummaryWidget extends StatelessWidget {
  final String label;
  final String value;

  const PaymentSummaryWidget({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label),
        Text('${value}'),
      ],
    );
  }
}
