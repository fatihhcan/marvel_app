import 'package:get_it/get_it.dart';
import 'package:marvel_app/core/base/cubit/home/home_cubit.dart';
import 'package:marvel_app/core/base/repository/characters_repository/characters_repository.dart';

import '../base/cubit/characters/characters_cubit.dart';



GetIt getIt = GetIt.instance;

@pragma('vm:prefer-inline')
T sl<T extends Object>() => getIt.get<T>();

setUpLocator() async {
  //Repositories
  getIt.registerLazySingleton(() => SampleCharactersRepository());


  //Cubits
  getIt.registerLazySingleton(() => CharactersCubit(sl()));
  getIt.registerLazySingleton(() => HomeCubit());
 
}
