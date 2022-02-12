import 'package:flutter/material.dart';
import 'package:sufismart/model/menu_model.dart';
import 'package:sufismart/util/system.dart';
import 'package:sufismart/view/contact_view.dart';
import 'package:sufismart/view/empty_page_view.dart';
import 'package:sufismart/view/main_menu_view.dart';
import 'package:sufismart/view/background_service.dart';
import 'package:sufismart/view/about_view.dart';
import 'package:sufismart/view/home_view.dart';
import 'package:sufismart/view/all_news_view.dart';
import 'package:sufismart/view/news_detail_view.dart';
import 'package:sufismart/view/credit_simulation_view.dart';
import 'package:sufismart/view/login_view.dart';
import 'package:sufismart/view/signup_view.dart';
import 'package:sufismart/view/akun_view.dart';

String initialRouteName = RouteName.loginMenu;

class RouteName {
  static const String loginMenu = "loginMenu";
  static const String signupMenu = "signupMenu";
  static const String mainMenu = "mainMenu";
  static const String allNews = "allNews";
  static const String detailNews = "detailNews";
  static const String backgroundService = "backgroundService";
  static const String creditSimulation = "creditSimulation";
}

enum ParamName {
  newsModel,
}

Map<String, WidgetBuilder> route = {
  RouteName.mainMenu: (BuildContext context) => MainMenuView(
        menus: [
          MenuModel(
            iconData: Icons.home,
            title: System.data.strings!.home,
          ),
          MenuModel(
            iconData: Icons.phone_iphone,
            title: System.data.strings!.about,
          ),
          MenuModel(
            iconData: Icons.email,
            title: System.data.strings!.contact,
          ),
          MenuModel(
            iconData: Icons.person_pin,
            title: System.data.strings!.account,
          ),
        ],
        onCreateBody: (menu, index) {
          switch (index) {
            case 0:
              return HomeView(
                gotoShowAll: () {
                  Navigator.of(context).pushNamed(RouteName.allNews);
                },
                gotoDetailNews: (news) {
                  Navigator.of(context)
                      .pushNamed(RouteName.detailNews, arguments: {
                    ParamName.newsModel: news,
                  });
                },
                gotoSimulation: () {
                  Navigator.of(context).pushNamed(RouteName.creditSimulation);
                },
              );
            case 1:
              return AboutView(
                key: System.data.navigatorKey,
              );
            case 2:
              return ContactView(
                key: System.data.navigatorKey,
              );
            case 3:
              return AkunView(
                key: System.data.navigatorKey,
                logout: () {
                  Navigator.of(context).pushNamed(RouteName.loginMenu);
                },
              );
            default:
              return EmptyPageView(
                key: System.data.navigatorKey,
              );
          }
        },
      ),
  RouteName.allNews: (BuildContext context) => AllNewsView(
        gotoDetailNews: (news) {
          Navigator.of(context).pushNamed(RouteName.detailNews, arguments: {
            ParamName.newsModel: news,
          });
        },
      ),
  RouteName.detailNews: (BuildContext context) {
    Map<dynamic, dynamic> arg = (ModalRoute.of(context)?.settings.arguments ??
        {}) as Map<dynamic, dynamic>;
    return NewsDetailView(
      newsModel: arg[ParamName.newsModel],
    );
  },
  RouteName.backgroundService: (BuildContext context) =>
      const BackgroundService(),
  RouteName.creditSimulation: (BuildContext context) {
    return CreditSimulationView(
      key: System.data.navigatorKey,
    );
  },
  RouteName.loginMenu: (BuildContext context) {
    return LoginView(
      gotoSignup: () {
        Navigator.of(context).pushNamed(RouteName.signupMenu, arguments: {});
      },
      gotoMain: () {
        Navigator.of(context).pushNamed(RouteName.mainMenu, arguments: {});
      },
    );
  },
  RouteName.signupMenu: (BuildContext context) {
    return SignupView(
      key: System.data.navigatorKey,
    );
  },
};
