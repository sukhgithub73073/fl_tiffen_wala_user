import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:tiffen_wala_user/common/models/restaurant_model.dart';
import 'package:tiffen_wala_user/repositiries/restaurant_repo.dart';

part 'restaurant_detail_event.dart';

part 'restaurant_detail_state.dart';

class RestaurantDetailBloc
    extends Bloc<RestaurantDetailEvent, RestaurantDetailState> {
  var restaurantRepository = GetIt.I<RestaurantRepository>();

  RestaurantDetailBloc() : super(RestaurantDetailInitial()) {
    on<GetRestaurantDetailEvent>(_getRestaurantDetail);
  }

  Future<FutureOr<void>> _getRestaurantDetail(GetRestaurantDetailEvent event,
      Emitter<RestaurantDetailState> emit) async {
    try {
      emit(RestaurantDetailLoading());
      var restaurant =
          await restaurantRepository.getRestaurantDetailApi(event.map);
      print("_getRestaurantDetail>>>>>>>>>>>restaurant${restaurant.toJson()}");

      emit(RestaurantDetailSuccess(restaurantModel: restaurant));
    } catch (e) {
      emit(RestaurantDetailError(error: e.toString()));
      print("_getRestaurantDetail>>>>>>>>>>>EXCEPTION${e}");
    }
  }
}
