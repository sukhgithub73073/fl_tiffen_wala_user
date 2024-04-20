part of 'restaurant_detail_bloc.dart';

sealed class RestaurantDetailState extends Equatable {
  const RestaurantDetailState();
}

final class RestaurantDetailInitial extends RestaurantDetailState {
  @override
  List<Object> get props => [];
}

final class RestaurantDetailLoading extends RestaurantDetailState {
  @override
  List<Object> get props => [];
}

final class RestaurantDetailSuccess extends RestaurantDetailState {
  final RestaurantModel restaurantModel;

  RestaurantDetailSuccess({required this.restaurantModel});

  @override
  List<Object> get props => [restaurantModel];
}

final class RestaurantDetailError extends RestaurantDetailState {
  final String error;

  RestaurantDetailError({required this.error});

  @override
  List<Object> get props => [error];
}
