part of 'app_type_bloc.dart';

sealed class AppTypeState extends Equatable {
  const AppTypeState();
}

final class AppTypeInitial extends AppTypeState {
  @override
  List<Object> get props => [];
}
final class AppTypeLoading extends AppTypeState {
  @override
  List<Object> get props => [];
}


final class AppTypeFood extends AppTypeState {
  final AppTypeEnum appTypeEnum ;
  AppTypeFood({required this.appTypeEnum});
  @override
  List<Object> get props => [appTypeEnum];
}

final class AppTypeProperty extends AppTypeState {
  final AppTypeEnum appTypeEnum ;
  AppTypeProperty({required this.appTypeEnum});
  @override
  List<Object> get props => [appTypeEnum];
}

