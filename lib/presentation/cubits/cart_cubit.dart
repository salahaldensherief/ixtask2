// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../data/models/pizza_item_model.dart';
// import '../../data/models/cart_model.dart';
// import 'cart_state.dart';
//
// class CartCubit extends Cubit<CartState> {
//   CartCubit() : super(CartState.initial());
//
//
//   void addItem(PizzaItemModel pizza) {
//     final exists = state.items.any((e) => e.id == pizza.id);
//     if (exists) return;
//
//     emit(
//       state.copyWith(
//         items: [...state.items, pizza.cloneForCart()],
//       ),
//     );
//   }
//
//   void removeItem(String cartItemId) {
//     emit(
//       state.copyWith(
//         items:
//         state.items
//             .where((item) => item.cartItemId != cartItemId)
//             .toList(),
//       ),
//     );
//   }
//
//   void increaseQty(String cartItemId) {
//     for (var item in state.items) {
//       if (item.cartItemId == cartItemId) {
//         item.increaseQty();
//         break;
//       }
//     }
//     emit(state.copyWith(items: [...state.items]));
//   }
//
//   void decreaseQty(String cartItemId) {
//     for (var item in state.items) {
//       if (item.cartItemId == cartItemId) {
//         item.decreaseQty();
//         break;
//       }
//     }
//     emit(state.copyWith(items: [...state.items]));
//   }
//
//
//   void setDiscountType(DiscountType type) {
//     emit(
//       state.copyWith(
//         discountType: type,
//         discountInput: type == DiscountType.none ? 0 : state.discountInput,
//       ),
//     );
//   }
//
//   void setDiscount(String value) {
//     final input = double.tryParse(value) ?? 0;
//     emit(state.copyWith(discountInput: input));
//   }
//
//
//   double get subTotal =>
//       state.items.fold(0.0, (sum, e) => sum + e.calcItemPrice);
//
//   double get taxAmount => subTotal * state.taxPercent;
//
//   double get discountAmount {
//     double discount = 0;
//
//     switch (state.discountType) {
//       case DiscountType.percent:
//         discount = subTotal * (state.discountInput / 100);
//         break;
//       case DiscountType.fixed:
//         discount = state.discountInput;
//         break;
//       case DiscountType.none:
//         discount = 0;
//         break;
//     }
//
//     return discount > subTotal ? subTotal : discount;
//   }
//
//   double get total =>
//       subTotal + state.deliveryFee + taxAmount - discountAmount;
//
//   void clearCart() {
//     emit(CartState.initial());
//   }
// }
