import 'package:bloc/bloc.dart';
import 'package:marvel_app/core/base/cubit/characters/characters_cubit.dart';

import '../../../utils/locator.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  init(int limit) async {
    emit(HomeLoading());
    await sl<CharactersCubit>().getMarvelCharacters(limit);


    emit(HomeCompleted());
  }
}
