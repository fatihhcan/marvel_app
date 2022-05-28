import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marvel_app/core/constant/router_constant.dart';
import 'package:marvel_app/core/constant/text_constant.dart';
import 'package:marvel_app/core/extensions/context_extension.dart';
import 'package:marvel_app/view/detail_view/screen_args.dart';

import '../../core/base/model/characters_model.dart';
import '../../core/constant/url_constant.dart';
import 'package:http/http.dart' as http;

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final urlCharacters = "${UrlConstant.CHARACTERS_URL}";

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

    print("BODY: ${jsonBody}");
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: buildAppBar(),
      body: buildBody(),
    );
  }

  ListView buildBody() {
    return ListView.separated(
      separatorBuilder: ((context, index) => context.sizedBoxLowVertical),
      itemCount: marvelCharacters.length + (hasMore ? 1 : 0),
      controller: scrollController,
      itemBuilder: (context, index) {
    if (index == marvelCharacters.length) {
      return limit > 100
          ? buildSeenThemAllText()
          : buildCircularProgressIndicator();
    } else {
      return GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, RouteConstant.DETAIL_VIEW,
              arguments: ScreenArgumentsDetail(
                charactersModel: marvelCharacters[index],
                comicsModel: marvelCharacters[index].comics!.items
              ));
        },
        child: buildCard(index, context),
      );
    }
      },
    );
  }

  Center buildCircularProgressIndicator() {
    return Center(
            child: const CircularProgressIndicator(),
          );
  }

  Text buildSeenThemAllText() {
    return Text(
            TextConstants.youSeenThemAll,
            textAlign: TextAlign.center,
          );
  }

  Container buildCard(int index, BuildContext context) {
    return Container(
        height: 400.h,
        alignment: Alignment.center,
        child: Column(
          children: [
            buildImage(index),
            context.sizedBoxLowVertical,
            buildCharactersName(index)
          ],
        ),
        decoration: BoxDecoration(
            color: Colors.tealAccent,
            borderRadius: context.bordernormalRadius),
      );
  }

  Text buildCharactersName(int index) {
    return Text(
            "${marvelCharacters[index].name}",
            style:
                TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          );
  }

  Image buildImage(int index) {
    return Image.network(
            "${marvelCharacters[index].thumbnail!.path}"
            ".${marvelCharacters[index].thumbnail!.extension}",
            height: 350.h,
          );
  }

  AppBar buildAppBar() {
    return AppBar(
                automaticallyImplyLeading: false,
      title: Text(TextConstants.appBarTitle),
    );
  }
}
