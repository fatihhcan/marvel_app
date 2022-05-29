import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:marvel_app/core/base/cubit/home/home_cubit.dart';

import '../../../constant/url_constant.dart';
import '../../../utils/locator.dart';
import '../../cubit/characters/characters_cubit.dart';
import '../../model/characters_model.dart';

abstract class CharactersRepository {
  Future<List<CharactersModel>> getMarvelCharacters();
}

class SampleCharactersRepository implements CharactersRepository {
  final urlCharacters = "${UrlConstant.CHARACTERS_URL}";

  List<CharactersModel> marvelCharacters = [];
  int limit = 30;
  @override
  Future<List<CharactersModel>> getMarvelCharacters() async {
    final response = await http.get(
      Uri.parse("$urlCharacters&limit=$limit"),
    );

    if (response.statusCode == 200) {
      final jsonBody = jsonDecode(response.body);
      List<CharactersModel> characterssList = List<CharactersModel>.from(
          jsonBody["data"]["results"]
              .map((model) => CharactersModel.fromJson(model)));
      marvelCharacters = characterssList;
      return characterssList;
    } else {
      return marvelCharacters;
    }
    
  }

  cubitSetStateLaunch() {
    sl<HomeCubit>().isLoading = true;
  }

  cubitSetStateEnd() {
    sl<HomeCubit>().isLoading = false;
    limit = limit + 30;
    sl<HomeCubit>().hasMore =
        marvelCharacters.length < sl<CharactersCubit>().maxLength;
  }

  getPagination() async {
    cubitSetStateLaunch();
    await getMarvelCharacters();
    cubitSetStateEnd();
  }
}
