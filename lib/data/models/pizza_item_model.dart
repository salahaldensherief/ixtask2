import 'package:flutter/material.dart';

class PizzaItemModel {
  final String? id;

  final String cartItemId;

  final String name;
  final String description;
  final double basePrice;
  final String? icon;

  final List<PizzaItemModel> options;

  final List<PizzaItemModel> selectOptions;

  int quantity;

  PizzaItemModel({
    this.id,
    String? cartItemId,
    this.name = '',
    this.description = '',
    this.basePrice = 0.0,
    this.icon,
    this.options = const [],
    List<PizzaItemModel>? selectOptions,
    this.quantity = 1,
  }) : selectOptions = selectOptions ?? [],
       cartItemId = cartItemId ?? UniqueKey().toString();

  PizzaItemModel cloneForCart() {
    return PizzaItemModel(
      id: id,
      name: name,
      description: description,
      basePrice: basePrice,
      icon: icon,
      options: options,
      selectOptions: [],
      quantity: 1,
    );
  }

  factory PizzaItemModel.fromJson(Map<String, dynamic> json) {
    return PizzaItemModel(
      id: json["id"],
      name: json["name"] ?? "",
      description: json["description"] ?? "",
      basePrice: (json["basePrice"] ?? 0).toDouble(),
      icon: json["icon"],
      quantity: json["quantity"] ?? 1,
      options:
          (json["options"] as List<dynamic>?)
              ?.map((e) => PizzaItemModel.fromJson(e))
              .toList() ??
          [],
      selectOptions:
          (json["selectOptions"] as List<dynamic>?)
              ?.map((e) => PizzaItemModel.fromJson(e))
              .toList() ??
          [],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "description": description,
      "basePrice": basePrice,
      "icon": icon,
      "quantity": quantity,
      "options": options.map((e) => e.toJson()).toList(),
      "selectOptions": selectOptions.map((e) => e.toJson()).toList(),
    };
  }

  double get getBasePrice => basePrice;

  double get calcItemPrice {
    final optionsPrice = selectOptions.fold(0.0, (sum, e) => sum + e.basePrice);

    return (basePrice + optionsPrice) * quantity;
  }

  void toggleOption(PizzaItemModel option) {
    if (selectOptions.any((e) => e.id == option.id)) {
      selectOptions.removeWhere((e) => e.id == option.id);
    } else {
      selectOptions.add(option);
    }
  }

  void increaseQty() => quantity++;

  void decreaseQty() {
    if (quantity > 1) quantity--;
  }
}
