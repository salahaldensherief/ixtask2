import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'package:task2ix/data/models/pizza_item_model.dart';

part 'fav_state.dart';

class FavCubit extends Cubit<FavState> {
  FavCubit() : super(FavInitial()) {
    loadFavs();
  }

  final String boxName = 'favBox';
  List<PizzaItemModel> favorites = [];

  Future<void> loadFavs() async {
    final box = await Hive.openBox<PizzaItemModel>(boxName);
    favorites = box.values.toList();
    emit(FavSuccess(List.from(favorites)));
  }

  Future<void> addToFav({required PizzaItemModel fav}) async {
    if (favorites.any((e) => e.id == fav.id)) return;

    final box = await Hive.openBox<PizzaItemModel>(boxName);
    await box.put(fav.id, fav);

    favorites.add(fav);
    emit(FavSuccess(List.from(favorites)));
  }

  Future<void> removeFromFav({required PizzaItemModel fav}) async {
    final box = await Hive.openBox<PizzaItemModel>(boxName);
    await box.delete(fav.id);

    favorites.removeWhere((e) => e.id == fav.id);
    emit(FavSuccess(List.from(favorites)));
  }
}
