part of 'characters_cubit.dart';

abstract class CharactersState {}

class CharactersInital extends CharactersState {}

class CharactersLoading extends CharactersState {}

class CharactersCompleted<T> extends CharactersState {
    final List<T> response;

  CharactersCompleted(this.response);

}

class CharactersError extends CharactersState {
  final String message;
  final String statusCode;

  CharactersError(this.message, this.statusCode);
}


