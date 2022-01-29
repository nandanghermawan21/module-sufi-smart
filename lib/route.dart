import 'package:flutter/material.dart';
import 'package:sufismart/view/all_news.dart';
import 'package:sufismart/view/home_view.dart';
import 'package:sufismart/view/background_service.dart';

String initialRouteName = RouteName.splashScreen;

class RouteName {
  static const String splashScreen = "splashScreen";
  static const String home = "home";
  static const String allNews = "allNews";
  static const String backgroundService = "backgroundService";
}

Map<String, WidgetBuilder> route = {
  RouteName.home: (BuildContext context) => HomeView(
        gotoShowAll: () {
          Navigator.pushNamed(context, RouteName.allNews);
        },
        gotoBranch: () {
          Navigator.pushNamed(context, RouteName.backgroundService);
        },
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
  RouteName.backgroundService: (BuildContext context) =>
      const BackgroundService(),
};
