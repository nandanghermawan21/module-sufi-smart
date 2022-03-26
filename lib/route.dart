import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sufismart/model/menu_model.dart';
import 'package:sufismart/util/enum.dart';
import 'package:sufismart/util/system.dart';
import 'package:sufismart/view/contact_view.dart';
import 'package:sufismart/view/empty_page_view.dart';
import 'package:sufismart/view/login_view.dart';
import 'package:sufismart/view/main_menu_view.dart';
import 'package:sufismart/view/background_service.dart';
import 'package:sufismart/view/about_view.dart';
import 'package:sufismart/view/home_view.dart';
import 'package:sufismart/view/all_news_view.dart';
import 'package:sufismart/view/news_detail_view.dart';
import 'package:sufismart/view/credit_simulation_view.dart';
import 'package:sufismart/view/signup_view.dart';
import 'package:sufismart/view/dashboard_view.dart';

String initialRouteName = RouteName.mainMenu;

class RouteName {
  static const String mainMenu = "mainMenu";
  static const String allNews = "allNews";
  static const String detailNews = "detailNews";
  static const String backgroundService = "backgroundService";
  static const String creditSimulation = "creditSimulation";
  static const String signUp = "signUp";
  static const String dashboard = "dashboard";
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
              return const AboutView();
            case 2:
              return const ContactView();
            case 3:
              if (System.data.global.customerModel != null) {
                return const DashboardView();
              }
              return LoginView(
                gotoSignup: () {
                  Navigator.of(context).pushNamed(RouteName.signUp);
                },
                onLoginSuccess: (customer) {
                  System.data.global.token = customer.token;
                  System.data.global.customerModel = customer;
                  System.data.session!.setString(
                      SessionKey.user, json.encode(customer.toJson()));
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      RouteName.mainMenu, (x) => x.settings.name == "");
                },
              );
            default:
              return const EmptyPageView();
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
    return const CreditSimulationView();
  },
  RouteName.signUp: (BuildContext context) {
    return SignupView(
      onRegisterSucces: (customer) {
        System.data.session!
            .setString(SessionKey.user, json.encode(customer.toJson()));
        System.data.global.token = customer.token;
        System.data.global.customerModel = customer;
        Navigator.of(context).pushNamedAndRemoveUntil(
            RouteName.mainMenu, (x) => x.settings.name == "");
      },
    );
  },
  RouteName.dashboard: (BuildContext context) {
    return const DashboardView();
  }
};
