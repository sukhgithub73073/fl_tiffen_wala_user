part of 'app_type_bloc.dart';

sealed class AppTypeEvent extends Equatable {
  const AppTypeEvent();
}

class ChangeAppTypeEvent extends AppTypeEvent {
  final AppTypeEnum appTypeEnum;

  const ChangeAppTypeEvent({required this.appTypeEnum});

  @override
  List<Object?> get props => [appTypeEnum];
}
