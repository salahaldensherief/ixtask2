import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/models/error_model.dart';
import '../../../data/models/pizza_item_model.dart';
import '../../../data/repos/pizza_repo.dart';

part 'pizza_layout_state.dart';

class PizzaLayoutCubit extends Cubit<PizzaLayoutState> {
  PizzaLayoutCubit(this.pizzaRepo) : super(PizzaInitial());
  final PizzaRepo pizzaRepo;
  List<PizzaItemModel> items=[];
  void loadPizza()async{
    emit(PizzaLoading());
    try{
      List<PizzaItemModel> pizza = await pizzaRepo.pizzaDataSource.getPizza();
      emit(PizzaSuccess(pizza));

    } on Exception catch(e){
      emit(PizzaFailure(ErrorMessage(message: e.toString()).message));
    }
  }
}
