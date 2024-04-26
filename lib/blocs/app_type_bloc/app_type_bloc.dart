import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tiffen_wala_user/common/enums/app_type_enum.dart';

part 'app_type_event.dart';

part 'app_type_state.dart';

class AppTypeBloc extends Bloc<AppTypeEvent, AppTypeState> {
  AppTypeBloc() : super(AppTypeInitial()) {
    on<ChangeAppTypeEvent>(_changeAppType);
  }

  FutureOr<void> _changeAppType(
      ChangeAppTypeEvent event, Emitter<AppTypeState> emit) {
    emit(AppTypeLoading());

    if (event.appTypeEnum == AppTypeEnum.foodUser || event.appTypeEnum == AppTypeEnum.foodVendor) {
      emit(AppTypeFood(appTypeEnum: event.appTypeEnum));
    }else{
      emit(AppTypeProperty(appTypeEnum: event.appTypeEnum));
    }


  }
}
