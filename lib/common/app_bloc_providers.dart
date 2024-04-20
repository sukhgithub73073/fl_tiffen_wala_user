import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tiffen_wala_user/blocs/location_bloc/location_bloc.dart';
import 'package:tiffen_wala_user/blocs/property_bloc/property_bloc.dart';
import 'package:tiffen_wala_user/blocs/restaurant_bloc/restaurant_bloc.dart';
import 'package:tiffen_wala_user/blocs/restaurant_detail_bloc/restaurant_detail_bloc.dart';

class AppBlocProvider extends StatelessWidget {
  final Widget child;
  final bool lazy;

  const AppBlocProvider({
    Key? key,
    required this.child,
    this.lazy = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
      providers: [
        BlocProvider(lazy: lazy, create: (_) => LocationBloc()..add(CheckGpsEvent())),
        BlocProvider(lazy: lazy, create: (_) => RestaurantBloc()),
        BlocProvider(lazy: lazy, create: (_) => RestaurantDetailBloc()),
        BlocProvider(lazy: lazy, create: (_) => PropertyBloc()),




      ],
      child: child,
    );
  }
}
