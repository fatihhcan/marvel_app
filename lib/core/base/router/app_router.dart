import 'package:flutter/material.dart';
import 'package:marvel_app/view/home/home_view.dart';
import 'package:marvel_app/view/launch/view/splash_view.dart';

import '../../../view/detail_view/detail_view.dart';
import '../../../view/detail_view/screen_args.dart';
import '../../constant/router_constant.dart';


class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case RouteConstant.SPLASH_VIEW:
        return MaterialPageRoute(builder: (_) => SplashView());
      case RouteConstant.HOME_VIEW:
        return MaterialPageRoute(builder: (_) => HomeView());
      case RouteConstant.DETAIL_VIEW:
        final ScreenArgumentsDetail args = routeSettings.arguments as ScreenArgumentsDetail;

        return MaterialPageRoute(
          builder: (_) => DetailView(
            charactersModel: args.charactersModel,
            comicsModel: args.comicsModel,
          ),
        );
     
      default:
        return null;
    }
  }
}
