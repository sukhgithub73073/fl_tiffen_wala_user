import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:tiffen_wala_user/common/models/restaurant_model.dart';
import 'package:tiffen_wala_user/repositiries/restaurant_repo.dart';

part 'restaurant_event.dart';

part 'restaurant_state.dart';

class RestaurantBloc extends Bloc<RestaurantEvent, RestaurantState> {
  var restaurantRepository = GetIt.I<RestaurantRepository>();

  RestaurantBloc() : super(RestaurantInitial()) {
    on<GetRestaurantListEvent>(_getRestaurantList);
  }

  Future<FutureOr<void>> _getRestaurantList(
      GetRestaurantListEvent event, Emitter<RestaurantState> emit) async {
    try {
      emit(RestaurantLoading());
      var list = await restaurantRepository.getRestaurantApi(event.map);
      print("_getRestaurantList>>>>>>>>>>>${list.length}") ;
      emit(RestaurantSuccess(restaurantList: list));
    } catch (e) {
      emit(RestaurantError(error: e.toString()));
      print("_getRestaurantList>>>>>>>>>>>EXCEPTION${e}") ;

    }
  }
}
