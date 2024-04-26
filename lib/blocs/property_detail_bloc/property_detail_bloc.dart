import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:tiffen_wala_user/common/models/property_model.dart';
import 'package:tiffen_wala_user/repositiries/property_repo.dart';

part 'property_detail_event.dart';
part 'property_detail_state.dart';

class PropertyDetailBloc extends Bloc<PropertyDetailEvent, PropertyDetailState> {
  var propertyRepository = GetIt.I<PropertyRepository>();

  PropertyDetailBloc() : super(PropertyDetailInitial()) {
    on<GetPropertyDetailEvent>(_getPropertyDetailApi);
  }

  Future<FutureOr<void>> _getPropertyDetailApi(GetPropertyDetailEvent event, Emitter<PropertyDetailState> emit) async {
    try {
      emit(PropertyDetailLoading());
      var property =
          await propertyRepository.getPropertyDetailApi(event.map);
      emit(PropertyDetailSuccess(propertyModel: property));
    } catch (e) {
      emit(PropertyDetailError(error: e.toString()));
      print("_getPropertyDetail>>>>>>>>>>>EXCEPTION${e}");
    }

  }
}
