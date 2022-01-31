import 'package:flutter/material.dart';
import 'package:sufismart/model/menu_model.dart';
import 'package:sufismart/util/system.dart';
import 'package:sufismart/view/all_news_view.dart';
import 'package:sufismart/view/contact_view.dart';
import 'package:sufismart/view/empty_page_view.dart';
import 'package:sufismart/view/login_view.dart';
import 'package:sufismart/view/main_menu_view.dart';
import 'package:sufismart/view/background_service.dart';
import 'package:sufismart/view/simulasi_menu_view.dart';
import 'package:sufismart/view/about_view.dart';
import 'package:sufismart/view/home_view.dart';

String initialRouteName = RouteName.splashScreen;

class RouteName {
  static const String splashScreen = "splashScreen";
  static const String home = "home";
  static const String allNews = "allNews";
  static const String backgroundService = "backgroundService";
  static const String simulationMenu = "simulationMenu";
}

Map<String, WidgetBuilder> route = {
  RouteName.home: (BuildContext context) => MainMenuView(
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
                gotoSimulation: () {
                  Navigator.of(context).pushNamed(RouteName.simulationMenu);
                },
              );
            case 1:
              return const AboutView();
            case 2:
              return const ContactView();
            case 3:
              return const LoginView();
            default:
              return const EmptyPageView();
          }
        },
      ),
  RouteName.allNews: (BuildContext context) => AllNewsView(
        gotoDetailNews: (e) {},
      ),
  RouteName.simulationMenu: (BuildContext context) {
    return const SimulationMenuView();
  },
  RouteName.backgroundService: (BuildContext context) =>
      const BackgroundService(),
};
