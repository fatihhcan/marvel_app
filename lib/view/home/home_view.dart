import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marvel_app/core/constant/router_constant.dart';
import 'package:marvel_app/core/constant/text_constant.dart';
import 'package:marvel_app/core/extensions/context_extension.dart';
import 'package:marvel_app/view/detail_view/screen_args.dart';

import '../../core/base/cubit/characters/characters_cubit.dart';
import '../../core/base/cubit/home/home_cubit.dart';
import '../../core/base/repository/characters_repository/characters_repository.dart';


import '../../core/utils/locator.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: MultiBlocProvider(
          providers: [
            BlocProvider.value(value: context.read<HomeCubit>()..init()),
          ],
          child: BlocBuilder<CharactersCubit, CharactersState>(
            builder: (context, state) {
              if (state is CharactersLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return buildBody();
              }
            },
          )),
    );
  }

  ListView buildBody() {
    return ListView.separated(
      separatorBuilder: ((context, index) => context.sizedBoxLowVertical),
      itemCount: sl<CharactersCubit>().marvelCharacters.length +
          (sl<HomeCubit>().hasMore ? 1 : 0),
      controller: sl<HomeCubit>().scrollController,
      itemBuilder: (context, index) {
        if (index == sl<CharactersCubit>().marvelCharacters.length) {
          return sl<SampleCharactersRepository>().limit > 100
              ? buildSeenThemAllText()
              : buildCircularProgressIndicator();
        } else {
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, RouteConstant.DETAIL_VIEW,
                  arguments: ScreenArgumentsDetail(
                      charactersModel:
                          sl<CharactersCubit>().marvelCharacters[index],
                      comicsModel: sl<CharactersCubit>()
                          .marvelCharacters[index]
                          .comics!
                          .items));
            },
            child: buildCard(index, context),
          );
        }
      },
    );
  }

  Center buildCircularProgressIndicator() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Text buildSeenThemAllText() {
    return const Text(
      TextConstants.youSeenThemAll,
      textAlign: TextAlign.center,
    );
  }

  Container buildCard(int index, BuildContext context) {
    return Container(
      height: 400.h,
      alignment: Alignment.center,
      child: Column(
        children: [
          buildImage(index),
          context.sizedBoxLowVertical,
          buildCharactersName(index)
        ],
      ),
      decoration: BoxDecoration(
          color: Colors.tealAccent, borderRadius: context.bordernormalRadius),
    );
  }

  Text buildCharactersName(int index) {
    return Text(
      "${sl<CharactersCubit>().marvelCharacters[index].name}",
      style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
    );
  }

  Image buildImage(int index) {
    return Image.network(
      "${sl<CharactersCubit>().marvelCharacters[index].thumbnail!.path}"
      ".${sl<CharactersCubit>().marvelCharacters[index].thumbnail!.extension}",
      height: 350.h,
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      title: const Text(TextConstants.appBarTitle),
    );
  }
}
