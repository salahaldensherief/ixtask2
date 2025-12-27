import 'package:task2ix/data/models/pizza_item_model.dart';

class CartModel {
  final List<PizzaItemModel> items;
  int quantity;

  CartModel(
  {this.quantity = 1,required this.items});

  double get totalPrice{
    return items.fold(0.0, (sum , item)=> sum +item.calcItemPrice*quantity);
  }

  void removeItem(String itemId){
    items.removeWhere((items) => items.id == itemId);
  }
  void addItem(PizzaItemModel item) {
    items.add(item);
  }
}