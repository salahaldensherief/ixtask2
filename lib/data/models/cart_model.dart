import 'pizza_item_model.dart';

class CartModel {
  final List<PizzaItemModel> items;
  int deliveryFee = 5;
  double taxPercent = 0.14;

  CartModel({
    required this.items,
    this.deliveryFee = 5,
    this.taxPercent = 0.14,
  });

  double get subTotalPrice {
    return items.fold(0.0, (sum, item) => sum + item.calcItemPrice);
  }

  double get totalPrice {
    return subTotalPrice + deliveryFee + taxPercent;
  }

  double get taxAmount => subTotalPrice * taxPercent;

  void setTaxPercent(double percent) => taxPercent = percent;

  void setDeliveryFee(int price) {
    deliveryFee = price;
  }

  void addItem(PizzaItemModel pizza) {
    items.add(pizza.cloneForCart());
  }

  void removeItem(String cartItemId) {
    items.removeWhere((item) => item.cartItemId == cartItemId);
  }
}
