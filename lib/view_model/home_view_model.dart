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
    commit();
  }

  String _phone = "";
  String get phone => _phone;
  set setPhone(String phone) {
    _phone = phone;
    commit();
  }

  String _email = "";
  String get email => _email;
  set setEmail(String email) {
    _email = email;
    commit();
  }

  String _message = "";
  String get message => _message;
  set setMessage(String message) {
    _message = message;
    commit();
  }

  final GlobalKey<FormState> formKeyContact = GlobalKey<FormState>();

  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  bool _emailValidation = false;
  bool get emailValidation => _emailValidation;
  set setEmailValidation(bool emailValidation) {
    _emailValidation = emailValidation;
    commit();
  }

  bool _passwordValidation = false;
  bool get passwordValidation => _passwordValidation;
  set setPasswordValidation(bool passwordValidation) {
    _passwordValidation = passwordValidation;
    commit();
  }

  bool _showPassword = false;
  bool get showPassword => _showPassword;
  set setShowPassword(bool showPassword) {
    _showPassword = showPassword;
    commit();
  }

  String? validateText(String value) {
    if (!(value.length > 5) && value.isNotEmpty) {
      return "should contain more than 5 characters";
    }
    return null;
  }

  bool validLogin() {
    bool valid = false;
    valid = showPassword ? true : false;
    valid = passwordValidation ? true : false;
    return valid;
  }

  void login(){
     emailTextEditingController.text.isEmpty ? setEmailValidation = true : setEmailValidation = false;
     passwordTextEditingController.text.isEmpty ? setPasswordValidation = true : setPasswordValidation = false;
  }
}
