part of 'restaurant_bloc.dart';

sealed class RestaurantState extends Equatable {
  const RestaurantState();
}

final class RestaurantInitial extends RestaurantState {
  @override
  List<Object> get props => [];
}

final class RestaurantLoading extends RestaurantState {
  @override
  List<Object> get props => [];
}

final class RestaurantSuccess extends RestaurantState {
  final List<RestaurantModel> restaurantList;

  RestaurantSuccess({required this.restaurantList});

  @override
  List<Object> get props => [restaurantList];
}

final class RestaurantError extends RestaurantState {
  final String error;

  RestaurantError({required this.error});

  @override
  List<Object> get props => [error];
}
