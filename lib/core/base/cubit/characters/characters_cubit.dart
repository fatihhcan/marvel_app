import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/network_error.dart';
import '../../model/characters_model.dart';
import '../../repository/characters_repository/characters_repository.dart';

part 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  final SampleCharactersRepository _sampleCharactersRepository;
  CharactersCubit(this._sampleCharactersRepository) : super(CharactersInital());

  List<CharactersModel> marvelCharacters = [];
  int maxLength = 100;

  Future getMarvelCharacters() async {
    try {
      final response =
          await _sampleCharactersRepository.getMarvelCharacters();
      marvelCharacters = response;

      emit(CharactersCompleted(response));
    } on NetworkError catch (e) {
      emit(CharactersError(e.message, e.statusCode));
    }
  }

  

}
