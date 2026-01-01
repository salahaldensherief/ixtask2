import 'package:flutter/material.dart';

class DiscountWidget extends StatelessWidget {
  final Icon icon;
  final void Function()? onTap;
  final Color color;

  const DiscountWidget({
    super.key, required this.icon, this.onTap, required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: color,

        ),
        child: icon,
      ),
    );
  }
}
