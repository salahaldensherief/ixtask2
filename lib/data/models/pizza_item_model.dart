import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
part 'pizza_item_model.g.dart';
@HiveType(typeId: 0)

class PizzaItemModel {
  @HiveField(0)
  final String ?id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String description;
  @HiveField(3)
  final double basePrice;
  @HiveField(4)
  final String? icon;
  @HiveField(5)
  List<PizzaItemModel> options;
  @HiveField(6)
  List<PizzaItemModel> selectOptions;
  @HiveField(7)
  List<PizzaItemModel> fav;

  PizzaItemModel({
    this.id,
    this.name = '',
    this.description = '',
    this.basePrice = 0.0,
    this.icon,
    this.options = const [],
    this.selectOptions = const [],
    this.fav = const []
  });

  factory PizzaItemModel.fromJson(Map<String, dynamic> json) {
    return PizzaItemModel(
      id: json["id"],
      name: json["name"] ?? "",
      description: json["description"] ?? "",
      basePrice: (json["basePrice"] ?? 0).toDouble(),
      icon: json["icon"],
      options: (json["options"] as List<dynamic>?)
          ?.map((e) => PizzaItemModel.fromJson(e))
          .toList() ??
          [],
      selectOptions: (json["selectOptions"] as List<dynamic>?)
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
      "options": options.map((e) => e.toJson()).toList(),
      "selectOptions": selectOptions.map((e) => e.toJson()).toList(),
    };
  }


  PizzaItemModel copyWith({

    List<PizzaItemModel>? selectOptions
  }) {
    return PizzaItemModel(
        id: id,
        description: description,
        name: name,
        options: options,
        basePrice: basePrice,
        icon: icon,
      selectOptions: selectOptions ?? this.selectOptions ,
    );
  }


  double get getBasePrice => basePrice;

  double get calcItemPrice {
    double _price = 0.0;

    for (var element in selectOptions) {
      _price += element.getBasePrice;
    }
    return getBasePrice + _price;
  }
  double get itemAfterApplyDiscount {
    return calcItemPrice -20 ;
  }

  void addRemoveOption({required PizzaItemModel option}) {
    if (selectOptions.any((element) => element.id == option.id,)) {
      selectOptions.remove(option);
    }
    selectOptions.add(option);
  }

  double getCouponDiscount(String coupon, double price) {
    double discount = 0.0;

    switch (coupon) {
      case '20':
        discount = 0.2 * price;
        break;
      case '10':
        discount = 0.1 * price;
        break;
      default:
        discount = 0.0;
    }

    return discount;
  }
  }

  void applyDiscount(){}
