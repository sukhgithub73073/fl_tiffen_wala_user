part of 'property_detail_bloc.dart';

sealed class PropertyDetailEvent extends Equatable {
  const PropertyDetailEvent();
}

class GetPropertyDetailEvent extends PropertyDetailEvent {
  final Map<String, dynamic> map;

  GetPropertyDetailEvent({required this.map});

  @override
  List<Object?> get props => [map];
}
