
import '../models/pizza_item_model.dart';
import '../source/local/pizza_data_source.dart';

class PizzaRepo {
  final PizzaDataSource pizzaDataSource;

  PizzaRepo(this.pizzaDataSource);
   Future<List<PizzaItemModel>> fetchPizza()async{
     return await pizzaDataSource.getPizza();
   }
}