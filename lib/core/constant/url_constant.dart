class UrlConstant {
  static const API_KEY = "b6e1a1dfa3d2ea9d4ef121fb63de3da9";
  static const HASH_KEY = "0f54f3d1c426ebf7502d773be2ab1f8b";
  static const TS_KEY = "1";
  static const BASE_URL = "http://gateway.marvel.com/v1/public";

  static const CHARACTERS_URL =
      "$BASE_URL/characters?apikey=$API_KEY&ts=$TS_KEY&hash=$HASH_KEY";
}
