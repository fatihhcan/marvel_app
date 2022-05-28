import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../constant/url_constant.dart';
import '../../../utils/network_error.dart';
import '../../model/characters_model.dart';

abstract class CharactersRepository {
  Future<List<CharactersModel>> getMarvelCharacters(int limit);
}

class SampleCharactersRepository implements CharactersRepository {
  final urlCharacters = "${UrlConstant.CHARACTERS_URL}";

  List<CharactersModel> marvelCharacters = [];

  @override
  Future<List<CharactersModel>> getMarvelCharacters(int limit) async {
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
    } throw NetworkError(response.statusCode.toString(), response.body);
    
  }
  
}

