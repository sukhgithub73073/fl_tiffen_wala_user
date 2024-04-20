part of 'location_bloc.dart';

class LocationState extends Equatable {
  const LocationState();

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class LocationInitial extends LocationState {
  @override
  List<Object> get props => [];
}

class LocationLoading extends LocationState {
  @override
  List<Object> get props => [];
}

class LocationError extends LocationState {
  final String error;

  LocationError({required this.error});

  @override
  List<Object> get props => [error];
}

class LocationGpsEnable extends LocationState {
  @override
  List<Object> get props => [];
}
class LocationGpsDisable extends LocationState {
  @override
  List<Object> get props => [];
}
class LocationPermisionNotGrant extends LocationState {
  @override
  List<Object> get props => [];
}
class LocationPermisionGrant extends LocationState {
  @override
  List<Object> get props => [];
}

class LocationFetch extends LocationState {
  final CurrentLocationModel currentLocationModel;

  LocationFetch({required this.currentLocationModel});

  @override
  List<Object> get props => [currentLocationModel];
}
