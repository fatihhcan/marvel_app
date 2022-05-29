# Marvel App

 **Project Summary:** Marvel used an open source API. Application of Marvel characters.

- [API Link](https://developer.marvel.com/)


https://user-images.githubusercontent.com/45641833/170819079-9a13fceb-1132-4691-8934-bbb8512f77d7.mp4


## Subject:

- **BLoC/Cubit** was used for State Management.

- **Get It** was used for dependencies injected.

- **HTTP** was used for API requests.

- **Screen Util** adapting screen and font size.

- For pagination and infinite Scroll, **Infinite Scroll Pagination** was used.

### BloC/Cubit
**Characters Cubit:**
```dart
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
```
**Characters Repository:**
```dart
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
  ```
  **Home Cubit:**
```dart
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
  ```
## Flutter Packages Available in the Project:

**flutter_screenutil:** A flutter plugin for adapting screen and font size.Guaranteed to look good on different models.

**flutter_bloc:** Flutter Widgets that make it easy to implement the BLoC (Business Logic Component) design pattern. Built to be used with the bloc state management package.

**lottie:** Render After Effects animations natively on Flutter. This package is a pure Dart implementation of a Lottie player.

**http:** A composable, multi-platform, Future-based API for HTTP requests.

**get_it:** Simple direct Service Locator that allows to decouple the interface from a concrete implementation and to access the concrete implementation from everywhere in your App.
