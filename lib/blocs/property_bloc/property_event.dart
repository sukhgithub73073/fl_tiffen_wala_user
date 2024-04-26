part of 'property_bloc.dart';

sealed class PropertyEvent extends Equatable {
  const PropertyEvent();
}

class GetPropertyListEvent extends PropertyEvent {
  final Map<String, dynamic> map;

  GetPropertyListEvent({required this.map});

  @override
  List<Object?> get props => [map];
}
class AddPropertyEvent extends PropertyEvent {
  final Map<String, dynamic> map;

  AddPropertyEvent({required this.map});

  @override
  List<Object?> get props => [map];
}