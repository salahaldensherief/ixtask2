import 'pizza_item_model.dart';

enum DiscountType { percent, fixed ,none }

class CartModel {
  final List<PizzaItemModel> items;

  int deliveryFee;
  double taxPercent;

  DiscountType discountType = DiscountType.none;
  double discountInput = 0;
  CartModel({
    required this.items,
    this.deliveryFee = 5,
    this.taxPercent = 0.14,
  });


  double get subTotalPrice =>
      items.fold(0.0, (sum, item) => sum + item.calcItemPrice);

  double get taxAmount => subTotalPrice * taxPercent;

  void setDiscount(String value) {
    discountInput = double.tryParse(value) ?? 0;
  }

  void toggleDiscountType() {
    discountType = discountType == DiscountType.fixed
        ? DiscountType.percent
        : DiscountType.fixed;
  }
  void setDiscountType(DiscountType type) {
    discountType = type;

    if (type == DiscountType.none) {
      discountInput = 0;
    }
  }

  double get discountAmount {
    double discount;

    switch (discountType) {
      case DiscountType.percent:
        discount = subTotalPrice * (discountInput / 100);
        break;

      case DiscountType.fixed:
        discount = discountInput;
        break;

      case DiscountType.none:
        discount = 0;
        break;
    }

    if (discount > subTotalPrice) {
      return subTotalPrice;
    } else {
      return discount;
    }

  }


  double get totalPrice =>
      subTotalPrice + deliveryFee + taxAmount - discountAmount;

  void setDeliveryFee(int price) {
    deliveryFee = price;
  }

  void setTaxPercent(double percent) {
    taxPercent = percent;
  }

  void addItem(PizzaItemModel pizza) {
    items.add(pizza.cloneForCart());
  }

  void removeItem(String cartItemId) {
    items.removeWhere((item) => item.cartItemId == cartItemId);
  }

  void clearCart() {
    items.clear();
    discountInput = 0;
  }
}
