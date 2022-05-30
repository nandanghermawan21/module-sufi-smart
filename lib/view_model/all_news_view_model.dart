import 'package:flutter/material.dart';
import 'package:sufismart/model/news_model.dart';
import 'package:sufismart/model/news_model_new.dart';

class AllNewsViewModel extends ChangeNotifier {
  Future<List<NewsModelNew>> allListNews = NewsModelNew.getListNews();

  Future<void> onRefreshHomePage() async {
    return Future.delayed(const Duration(seconds: 5));
  }

  List<NewsModel> _listNews = NewsModel.dummy();
  List<NewsModel> get listNews => _listNews;
  set setListNews(List<NewsModel> listNews) {
    _listNews = listNews;
  }

  void commit() {
    notifyListeners();
  }
}
