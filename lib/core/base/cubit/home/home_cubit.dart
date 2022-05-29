import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:marvel_app/core/base/cubit/characters/characters_cubit.dart';

import '../../../utils/locator.dart';
import '../../repository/characters_repository/characters_repository.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  late ScrollController scrollController;
  bool isLoading = false;
  bool hasMore = true;

  init() async {
    emit(HomeLoading());
    scrollController = ScrollController();
    await sl<CharactersCubit>().getMarvelCharacters();

  
    scrollController.addListener(() async{
      if (scrollController.position.pixels >=
              scrollController.position.maxScrollExtent * 0.95 &&
          !isLoading) {
        if (hasMore) {
          await  sl<SampleCharactersRepository>().getPagination();
          await  sl<CharactersCubit>().getMarvelCharacters();
            
             

        }
      }
    });
    emit(HomeCompleted());
  }

  void dispose() {
    scrollController.dispose();
    super.close();
  }
}
