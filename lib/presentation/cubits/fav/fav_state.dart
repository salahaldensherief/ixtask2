part of 'fav_cubit.dart';

@immutable
sealed class FavState {}

final class FavInitial extends FavState {}
final class FavFailure extends FavState {
  final String message;

  FavFailure({required this.message});
}
final class FavSuccess extends FavState {
 final List<PizzaItemModel> fav;

  FavSuccess(this.fav);
}
final class FavLoading extends FavState {}
