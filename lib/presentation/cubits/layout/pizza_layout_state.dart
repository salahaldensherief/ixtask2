part of 'pizza_layout_cubit.dart';
sealed class PizzaLayoutState {}

final class PizzaInitial extends PizzaLayoutState {}
final class PizzaLoading extends PizzaLayoutState {}
final class PizzaFailure extends PizzaLayoutState {
 final String errorMessage;

  PizzaFailure( this.errorMessage);
}
final class PizzaSuccess extends PizzaLayoutState {
 final List<PizzaItemModel> pizza;

  PizzaSuccess(this.pizza);

}
