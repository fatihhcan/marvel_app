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

### Infinite Scroll and Pagination

```dart
  List<CharactersModel> marvelCharacters = [];
  int limit = 30;
  int maxLength = 100;
  late ScrollController scrollController;
  bool isLoading = false;
  bool hasMore = true;

  getPagination() async {
    setState(() {
      isLoading = true;
    });
    final response = await http.get(
      Uri.parse("$urlCharacters&limit=$limit"),
    );

    final jsonBody = jsonDecode(response.body);

    print("MARVEL BODY: ${jsonBody}");
    if (response.statusCode == 200) {
      List<CharactersModel> characterssList = List<CharactersModel>.from(
          jsonBody["data"]["results"]
              .map((model) => CharactersModel.fromJson(model)));
      marvelCharacters = characterssList;
      marvelCharacters;
    } else {
      [];
    }

    setState(() {
      isLoading = false;
      limit = limit + 30;
      hasMore = marvelCharacters.length < maxLength;
    });
  }

    @override
    void initState() {
    super.initState();
    getPagination();
    scrollController = ScrollController();
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
              scrollController.position.maxScrollExtent * 0.95 &&
          !isLoading) {
        if (hasMore) {
          getPagination();
        }
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
```
```dart
ListView.separated(
      separatorBuilder: ((context, index) => const SizedBox(
        height: 10,
      )),
      itemCount: marvelCharacters.length + (hasMore ? 1 : 0),
      controller: scrollController,
      itemBuilder: (context, index) {
    if (index == marvelCharacters.length) {
      return limit > 100
          ? Text(
              TextConstants.youSeenThemAll,
              textAlign: TextAlign.center,
            )
          : Center(
              child: const CircularProgressIndicator(),
            );
    } else {
      return GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, RouteConstant.DETAIL_VIEW,
              arguments: ScreenArgumentsDetail(
                charactersModel: marvelCharacters[index],
                comicsModel: marvelCharacters[index].comics!.items
              ));
        },
        child: Container(
          height: 400.h,
          alignment: Alignment.center,
          child: Column(
            children: [
              Image.network(
                "${marvelCharacters[index].thumbnail!.path}"
                ".${marvelCharacters[index].thumbnail!.extension}",
                height: 350.h,
              ),
              SizedBox(height: 10.h),
              Text(
                "${marvelCharacters[index].name}",
                style:
                    TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              )
            ],
          ),
          decoration: BoxDecoration(
              color: Colors.tealAccent,
              borderRadius: context.bordernormalRadius),
        ),
      );
    }
      },
    )
```

## Flutter Packages Available in the Project:

**flutter_screenutil:** A flutter plugin for adapting screen and font size.Guaranteed to look good on different models.

**flutter_bloc:** Flutter Widgets that make it easy to implement the BLoC (Business Logic Component) design pattern. Built to be used with the bloc state management package.

**lottie:** Render After Effects animations natively on Flutter. This package is a pure Dart implementation of a Lottie player.

**http:** A composable, multi-platform, Future-based API for HTTP requests.

**get_it:** Simple direct Service Locator that allows to decouple the interface from a concrete implementation and to access the concrete implementation from everywhere in your App.
