import 'package:flutter/material.dart';
import 'package:sufismart/model/banner_model.dart';
import 'package:sufismart/model/image_news_model.dart';

class HomeViewModel extends ChangeNotifier {
  int selectedIndex = 0;
  void onItemTapped(int index) {
    selectedIndex = index;
    commit();
  }

  void commit() {
    notifyListeners();
  }

  List<ImgNewsModel> _listNews = ImgNewsModel.dummy();
  List<ImgNewsModel> get listNews => _listNews;
  set setListNews(List<ImgNewsModel> listNews) {
    _listNews = listNews;
  }

  List<BannerModel> _listBanner = BannerModel.dummy();
  List<BannerModel> get listBanner => _listBanner;
  set listBanner(List<BannerModel> listBanner) {
    _listBanner = listBanner;
    commit();
  }

  Future<void> onRefreshHomePage() async {
    return Future.delayed(const Duration(seconds: 5));
  }

  String _name = "";
  String get name => _name;
  set setName(String name) {
    _name = name;
  }

  String _phone = "";
  String get phone => _phone;
  set setPhone(String phone) {
    _phone = phone;
  }

  String _email = "";
  String get email => _email;
  set setEmail(String email) {
    _email = email;
  }

  String _message = "";
  String get message => _message;
  set setMessage(String message) {
    _message = message;
  }

  final GlobalKey<FormState> formKeyContact = GlobalKey<FormState>();

}
