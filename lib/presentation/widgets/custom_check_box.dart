import 'package:flutter/material.dart';

class CustomCheckBox extends StatelessWidget {
   CustomCheckBox({super.key, required this.value ,required this.onChanged, required this.title});
  final bool value;
  final Widget title;
void Function(bool?)?  onChanged;
  @override
  Widget build(BuildContext context) {
    return  CheckboxListTile(
      materialTapTargetSize: MaterialTapTargetSize.padded,

      title: title,
      value: value,
      onChanged: onChanged,


    );
  }
}
