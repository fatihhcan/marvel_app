import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constant/router_constant.dart';


part 'splash_state.dart';

class SplashCubit extends Cubit<SplashCubitState> {
  SplashCubit() : super(SplashCubitInitial());

  splashInit(BuildContext context) async {
    try {
      emit(SplashCubitLoading());
      await navigatorToScreen(context);
    } catch (e) {}
  }

  navigatorToScreen(BuildContext context) {
    Future.delayed(const Duration(seconds: 4), () {
      Navigator.pushNamed(context, RouteConstant.HOME_VIEW);
    });
  }
}
