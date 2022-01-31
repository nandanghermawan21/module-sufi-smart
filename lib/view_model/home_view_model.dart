import 'package:flutter/material.dart';
import 'package:sufismart/model/banner_model.dart';
import 'package:sufismart/model/image_news_model.dart';

class HomeViewModel extends ChangeNotifier {
  List<BannerModel> _listBanner = BannerModel.dummy();
  List<BannerModel> get listBanner => _listBanner;
  set listBanner(List<BannerModel> listBanner) {
    _listBanner = listBanner;
    commit();
  }

  List<ImgNewsModel> _listNews = ImgNewsModel.dummy();
  List<ImgNewsModel> get listNews => _listNews;
  set setListNews(List<ImgNewsModel> listNews) {
    _listNews = listNews;
  }

  Future<void> onRefreshHomePage() async {
    return Future.delayed(const Duration(seconds: 5));
  }

  void commit() {
    notifyListeners();
  }
}
