import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:skeleton_text/skeleton_text.dart';
import 'package:sufismart/model/news_model.dart';
import 'package:sufismart/util/system.dart';
import '../view_model/main_menu_view_model.dart';

class BasicComponent {
  static AppBar appBar({
    List<Widget>? actions,
  }) {
    return AppBar(
      backgroundColor: System.data.color!.mainColor,
      title: Image.asset(
        "assets/logo_sfi_white.png",
        fit: BoxFit.cover,
        height: 30,
      ),
      actions: actions,
    );
  }

  static Widget dropDownLang() {
    var mainMenuViewModel = MainMenuViewModel();
    return DropdownButton<String>(
        value: mainMenuViewModel.lang?.lang,
        items: List.generate(mainMenuViewModel.langs.length, (index) {
          return DropdownMenuItem<String>(
            value: mainMenuViewModel.langs[index].lang,
            child: Container(
              height: 35,
              color: Colors.transparent,
              child: Image.asset(
                mainMenuViewModel.langs[index].flag ?? "",
              ),
            ),
          );
        }),
        onChanged: (lang) {
          mainMenuViewModel.lang =
              mainMenuViewModel.langs.where((e) => e.lang == lang).first;
        });
  }

  static Widget newsImageContainer(NewsModel news) {
    return CachedNetworkImage(
      imageUrl: news.imagepath ?? "",
      imageBuilder: (context, imageProvider) => SizedBox(
        height: MediaQuery.of(context).size.height / 2,
        child: Card(
          margin: const EdgeInsets.only(bottom: 10.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              image: DecorationImage(image: imageProvider, fit: BoxFit.fill),
            ),
          ),
        ),
      ),
      placeholder: (context, url) => SkeletonAnimation(
          child: Container(
        height: MediaQuery.of(context).size.height / 2,
        decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: const BorderRadius.all(Radius.circular(5))),
      )),
      errorWidget: (context, url, error) => Container(
        height: MediaQuery.of(context).size.height / 2,
        decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: const BorderRadius.all(Radius.circular(5))),
        child: const Center(
          child: Icon(Icons.error),
        ),
      ),
    );
  }
}
