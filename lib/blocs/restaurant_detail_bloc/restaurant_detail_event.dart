part of 'restaurant_detail_bloc.dart';

sealed class RestaurantDetailEvent extends Equatable {
  const RestaurantDetailEvent();
}

class GetRestaurantDetailEvent extends RestaurantDetailEvent {
  final Map<String, dynamic> map;

  const GetRestaurantDetailEvent({required this.map});

  @override
  List<Object?> get props => [map];
}
