import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:task2ix/data/models/pizza_item_model.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());

}
