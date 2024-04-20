import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:tiffen_wala_user/common/models/property_model.dart';

import '../../repositiries/property_repo.dart';

part 'property_event.dart';
part 'property_state.dart';

class PropertyBloc extends Bloc<PropertyEvent, PropertyState> {
  var propertyRepository = GetIt.I<PropertyRepository>();

  PropertyBloc() : super(PropertyInitial()) {
    on<GetPropertyListEvent>(_getPropertyList);
  }

  Future<FutureOr<void>> _getPropertyList(
      GetPropertyListEvent event, Emitter<PropertyState> emit) async {
    try {
      emit(PropertyLoading());
      var list = await propertyRepository.getPropertyApi(event.map);
      print("_getPropertyList>>>>>>>>>>>${list.length}") ;
      emit(PropertySuccess(propertyList: list));
    } catch (e) {
      emit(PropertyError(error: e.toString()));
      print("_getPropertyList>>>>>>>>>>>EXCEPTION${e}") ;

    }
  }
}
