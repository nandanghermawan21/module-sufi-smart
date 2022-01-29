import 'package:flutter/material.dart';
import 'package:sufismart/view/all_news.dart';
import 'package:sufismart/view/home_view.dart';

String initialRouteName = RouteName.splashScreen;

class RouteName {
  static const String splashScreen = "splashScreen";
  static const String home = "home";
  static const String allNews = "allNews";
}

Map<String, WidgetBuilder> route = {
  RouteName.home: (BuildContext context) => HomeView(
        gotoShowAll: () {
          Navigator.pushNamed(context, RouteName.allNews);
        },
        gotoBranch: () {},
        gotoCredit: () {},
        gotoDetailNews: (e) {},
        gotoForgotPassword: () {},
        gotoInstallment: () {},
        gotoPayment: () {},
        gotoProduct: () {},
        gotoPromo: () {},
        gotoSignup: () {},
      ),
  RouteName.allNews: (BuildContext context) => AllNews(
        gotoDetailNews: (e) {},
      ),
};
