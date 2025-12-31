import 'coupon_model.dart';
import 'pizza_item_model.dart';


const Map<String, CouponModel> coupons = {
  '50OFF': CouponModel(CouponType.fixed, 50),
  '10P': CouponModel(CouponType.percent, 10),
  '20P': CouponModel(CouponType.percent, 20),
};

class CartModel {
  final List<PizzaItemModel> items;

  int deliveryFee;
  double taxPercent;

  CouponModel appliedCoupon = const CouponModel(CouponType.none, 0);

  CartModel({
    required this.items,
    this.deliveryFee = 5,
    this.taxPercent = 0.14,
  });


  double get subTotalPrice =>
      items.fold(0.0, (sum, item) => sum + item.calcItemPrice);

  double get taxAmount => subTotalPrice * taxPercent;

  double get discountAmount {
    switch (appliedCoupon.type) {
      case CouponType.fixed:
        return appliedCoupon.value;
      case CouponType.percent:
        return subTotalPrice * (appliedCoupon.value / 100);
      case CouponType.none:
        return 0;
    }
  }

  double get totalPrice =>
      subTotalPrice + deliveryFee + taxAmount - discountAmount;


  bool applyCoupon(String code) {
    final coupon = coupons[code];

    if (coupon == null) {
      appliedCoupon = const CouponModel(CouponType.none, 0);
      return false;
    }

    appliedCoupon = coupon;
    return true;
  }

  void removeCoupon() {
    appliedCoupon = const CouponModel(CouponType.none, 0);
  }

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
    removeCoupon();
  }
}
