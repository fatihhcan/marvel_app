import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marvel_app/core/base/cubit/characters/characters_cubit.dart';
import 'package:marvel_app/core/base/cubit/home/home_cubit.dart';


import 'core/base/router/app_router.dart';
import 'core/utils/locator.dart';

Future<void> main() async {
  await setUpLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AppRouter _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CharactersCubit>(
            create: (context) => sl<CharactersCubit>()),
        BlocProvider<HomeCubit>(create: (context) => sl<HomeCubit>()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(428, 926),
        builder: (BuildContext context, child) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Marvel App',
          onGenerateRoute: _appRouter.onGenerateRoute,
        ),
      ),
    );
  }
}
