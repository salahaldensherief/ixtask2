import 'dart:convert';

import 'package:flutter/services.dart';

import '../../models/pizza_item_model.dart';

class PizzaDataSource {
  Future<List<PizzaItemModel>> getPizza() async {
    final response = await rootBundle.loadString('assets/pizza.json');
    final List<dynamic> pizzaList = jsonDecode(response);
    return pizzaList.map((e) => PizzaItemModel.fromJson(e)).toList();
  }
}