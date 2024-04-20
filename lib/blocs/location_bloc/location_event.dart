part of 'location_bloc.dart';
 class LocationEvent extends Equatable {
  const LocationEvent();
  @override
  List<Object?> get props => throw UnimplementedError();


}
class CheckGpsEvent extends LocationEvent {
   CheckGpsEvent();
  @override
  List<Object?> get props => [];
}
class CheckPermissionEvent extends LocationEvent {
  CheckPermissionEvent();
  @override
  List<Object?> get props => [];
}
class GetCurrentLocationEvent extends LocationEvent {
  GetCurrentLocationEvent();
  @override
  List<Object?> get props => [];
}