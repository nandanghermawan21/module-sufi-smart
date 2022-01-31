import 'package:flutter/material.dart';
import 'package:sufismart/model/image_news_model.dart';

class AllNewsViewModel extends ChangeNotifier {
  Future<void> onRefreshHomePage() async {
    return Future.delayed(const Duration(seconds: 5));
  }

  List<ImgNewsModel> _listNews = ImgNewsModel.dummy();
  List<ImgNewsModel> get listNews => _listNews;
  set setListNews(List<ImgNewsModel> listNews) {
    _listNews = listNews;
  }
}
