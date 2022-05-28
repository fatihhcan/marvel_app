
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import '../../../core/base/cubit/splash_cubit/splash_cubit.dart';
import '../../../core/constant/image_constant.dart';


class SplashView extends StatelessWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SplashCubit>(
        create: (context) => SplashCubit()..splashInit(context),
        child: BlocBuilder<SplashCubit, SplashCubitState>(
          builder: (context, state) {
            return Scaffold(
                backgroundColor: Colors.white,
                body: buildSplashAnimation());
          },
        ));
  }

  Center buildSplashAnimation() {
    return Center(
                child: SizedBox(
                  height: 250.h,
                  child: Lottie.asset(ImageConstants.splashJson)),
              );
  }
}
