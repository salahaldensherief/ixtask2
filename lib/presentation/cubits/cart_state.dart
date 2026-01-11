//
// import '../../data/models/cart_model.dart';
// import 'package:task2ix/data/models/pizza_item_model.dart';
//
// class CartState {
//   final List<PizzaItemModel> items;
//   final DiscountType discountType;
//   final double discountInput;
//   final int deliveryFee;
//   final double taxPercent;
//
//   CartState({required this.items, required this.discountType, required this.discountInput, required this.deliveryFee, required this.taxPercent});
//   factory CartState.initial() {
//     return  CartState(
//       items: [],
//       discountType: DiscountType.none,
//       discountInput: 0,
//       deliveryFee: 5,
//       taxPercent: 0.14,
//     );
//   }
//   CartState copyWith({
//     List<PizzaItemModel>? items,
//     DiscountType? discountType,
//     double? discountInput,
//     int? deliveryFee,
//     double? taxPercent,
//   }) {
//     return CartState(
//       items: items ?? this.items,
//       discountType: discountType ?? this.discountType,
//       discountInput: discountInput ?? this.discountInput,
//       deliveryFee: deliveryFee ?? this.deliveryFee,
//       taxPercent: taxPercent ?? this.taxPercent,
//     );
//   }}
//
