import 'package:hive/hive.dart';
part 'pizza_item_model.g.dart';

@HiveType(typeId: 0)
class PizzaItemModel {
  @HiveField(0)
  final String? id;

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

  @HiveField(8)
  int quantity;

  PizzaItemModel({
    this.id,
    this.name = '',
    this.description = '',
    this.basePrice = 0.0,
    this.icon,
    this.options = const [],
    this.selectOptions = const [],
    this.fav = const [],
    this.quantity = 1,
  });

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

  PizzaItemModel copyWith({
    int? quantity,
    List<PizzaItemModel>? selectOptions,
  }) {
    return PizzaItemModel(
      id: id,
      name: name,
      description: description,
      basePrice: basePrice,
      icon: icon,
      options: options,
      fav: fav,
      quantity: quantity ?? this.quantity,
      selectOptions: selectOptions ?? this.selectOptions,
    );
  }

  double get getBasePrice => basePrice;

  double get calcItemPrice {
    double optionsPrice = 0.0;


    for (var element in selectOptions) {
      optionsPrice += element.getBasePrice;
    }

    return (getBasePrice + optionsPrice) * quantity;
  }

  double get itemAfterApplyDiscount {
    return calcItemPrice - 20;
  }

  bool addRemoveOption({required PizzaItemModel option}) {
    if (selectOptions.contains(option)) {
      selectOptions.remove(option);
      return true;
    } else {
      selectOptions.add(option);
      return false;
    }
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

  void increaseQty() => quantity++;
  void decreaseQty() {
    if (quantity > 1) quantity--;
  }
}
