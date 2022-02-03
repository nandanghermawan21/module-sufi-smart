import 'package:flutter/material.dart';
import 'package:sufismart/model/news_model.dart';

class AllNewsViewModel extends ChangeNotifier {
  Future<void> onRefreshHomePage() async {
    return Future.delayed(const Duration(seconds: 5));
  }

  List<NewsModel> _listNews = NewsModel.dummy();
  List<NewsModel> get listNews => _listNews;
  set setListNews(List<NewsModel> listNews) {
    _listNews = listNews;
  }
}
