part of 'property_detail_bloc.dart';

sealed class PropertyDetailState extends Equatable {
  const PropertyDetailState();
}

final class PropertyDetailInitial extends PropertyDetailState {
  @override
  List<Object> get props => [];
}
final class PropertyDetailLoading extends PropertyDetailState {
  @override
  List<Object> get props => [];
}

final class PropertyDetailSuccess extends PropertyDetailState {
  final PropertyModel propertyModel ;
  PropertyDetailSuccess({required this.propertyModel});
  @override
  List<Object> get props => [propertyModel];
}
final class PropertyDetailError extends PropertyDetailState {
  final String error ;

  PropertyDetailError({required this.error});
  @override
  List<Object> get props => [error];
}

