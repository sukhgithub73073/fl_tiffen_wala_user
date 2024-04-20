part of 'restaurant_bloc.dart';

sealed class RestaurantEvent extends Equatable {
  const RestaurantEvent();
}

class GetRestaurantListEvent extends RestaurantEvent {
  final Map<String, dynamic> map;

  GetRestaurantListEvent({required this.map});

  @override
  List<Object?> get props => [map];
}
