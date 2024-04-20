part of 'property_bloc.dart';


sealed class PropertyState extends Equatable {
  const PropertyState();
}

final class PropertyInitial extends PropertyState {
  @override
  List<Object> get props => [];
}

final class PropertyLoading extends PropertyState {
  @override
  List<Object> get props => [];
}

final class PropertySuccess extends PropertyState {
  final List<PropertyModel> propertyList;
  PropertySuccess({required this.propertyList});
  @override
  List<Object> get props => [propertyList];
}

final class PropertyError extends PropertyState {
  final String error;

  PropertyError({required this.error});

  @override
  List<Object> get props => [error];
}
