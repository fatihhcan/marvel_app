import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marvel_app/core/constant/router_constant.dart';
import 'package:marvel_app/core/extensions/context_extension.dart';

import '../../core/base/model/characters_model.dart';

class DetailView extends StatelessWidget {
  final CharactersModel? charactersModel;
  final List<ComicsItem>? comicsModel;
  const DetailView({Key? key, this.charactersModel, this.comicsModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: buildBody(context),
    );
  }

  Padding buildBody(BuildContext context) {
    return Padding(
      padding: context.paddingNormalHorizontal,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          buildImage(),
          context.sizedBoxLowVertical,
          buildCharactersName(),
          context.sizedBoxLowVertical,
          buildCharactersDescription(),
          context.sizedBoxLowVertical,
          buildCharactersComics(),
        ],
      ),
    );
  }

  SizedBox buildCharactersComics() {
    return SizedBox(
          height: 200.h,
          child: ListView.builder(
              itemCount:
                  comicsModel!.length < 10 ? comicsModel!.length : 10,
              itemBuilder: (context, index) {
          
                

               
                return Text("${comicsModel![index].name}",
                    style: TextStyle(
                        fontSize: 15, fontWeight: FontWeight.bold));
              }),
        );
  }

  Text buildCharactersDescription() {
    return Text(
          "${charactersModel!.description}",
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
        );
  }

  Text buildCharactersName() {
    return Text(
          "${charactersModel!.name}",
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        );
  }

  Image buildImage() {
    return Image.network(
          "${charactersModel!.thumbnail!.path}"
          ".${charactersModel!.thumbnail!.extension}",
          height: 350.h,
        );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
          onPressed: () {
            Navigator.pop(context, RouteConstant.HOME_VIEW);
          },
          icon: Icon(Icons.arrow_back)),
    );
  }
}
