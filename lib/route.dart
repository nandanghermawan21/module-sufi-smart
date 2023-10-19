import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sufismart/model/menu_model.dart';
import 'package:sufismart/util/enum.dart';
import 'package:sufismart/util/mode_util.dart';
import 'package:sufismart/util/system.dart';
import 'package:sufismart/view/alert_login_view.dart';
import 'package:sufismart/view/announcement_view.dart';
import 'package:sufismart/view/apply_user_view.dart';
import 'package:sufismart/view/branch_view.dart';
import 'package:sufismart/view/change_password_view.dart';
import 'package:sufismart/view/contact_view.dart';
import 'package:sufismart/view/empty_page_view.dart';
import 'package:sufismart/view/forgot_password_view.dart';
import 'package:sufismart/view/history_point_view.dart';
import 'package:sufismart/view/login_view.dart';
import 'package:sufismart/view/main_menu_view.dart';
import 'package:sufismart/view/background_service.dart';
import 'package:sufismart/view/about_view.dart';
import 'package:sufismart/view/home_view.dart';
import 'package:sufismart/view/all_news_view.dart';
import 'package:sufismart/view/merchant_detail_view.dart';
import 'package:sufismart/view/merchant_view.dart';
import 'package:sufismart/view/news_detail_view.dart';
import 'package:sufismart/view/credit_simulation_view.dart';
import 'package:sufismart/view/news_detail_view_deeplink.dart';
import 'package:sufismart/view/product_category_view.dart';
import 'package:sufismart/view/product_detail_view.dart';
import 'package:sufismart/view/product_type_view.dart';
import 'package:sufismart/view/profile_view.dart';
import 'package:sufismart/view/register_view.dart';
import 'package:sufismart/view/signup_view.dart';
import 'package:sufismart/view/dashboard_view.dart';
import 'package:sufismart/view/product_list_view.dart';
import 'package:sufismart/view/splashscreen_view.dart';
import 'package:sufismart/view/web_view.dart';

String initialRouteName = RouteName.splashScreen;

class RouteName {
  static const String mainMenu = "mainMenu";
  static const String allNews = "allNews";
  static const String detailNews = "detailNews";
  static const String backgroundService = "backgroundService";
  static const String creditSimulation = "creditSimulation";
  static const String signUp = "signUp";
  static const String dashboard = "dashboard";
  static const String productCategory = "productCategory";
  static const String productList = "productList";
  static const String productType = "productType";
  static const String productDetail = "productDetail";
  static const String branch = "Branch";
  static const String webView = "Webview";
  static const String alertNoLogin = "alertNoLogin";
  static const String forgotPassword = "forgotPassword";
  static const String changePassword = "changePassword";
  static const String changeProfile = "changeProfile";
  static const String splashScreen = "splashScreen";
  static const String register = "register";
  static const String applyUserview = "ApplyViewUser";
  static const String detailNewsDeepLink = "detailNewsDeepLink";
  static const String announcementView = "announcementView";
  static const String historyPointView = "historyPointView";
  static const String merchantPointView = "merchantPointView";
  static const String merchantDetailPointView = "merchantDetailPointView";
}

enum ParamName {
  newsModel,
  productCategory,
  productItem,
  productItemDetail,
  urlWebview,
  productSimulasi,
  newsdetailid,
  notifid,
  merchantid
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
              return HomeView(gotoShowAll: () {
                Navigator.of(context).pushNamed(RouteName.allNews);
              }, gotoDetailNews: (news) {
                Navigator.of(context)
                    .pushNamed(RouteName.detailNews, arguments: {
                  ParamName.newsModel: news,
                });
              }, gotoSimulation: () {
                String? userid = System.data.global.customerNewModel?.userid;
                Navigator.of(context).pushNamed(RouteName.webView, arguments: {
                  ParamName.urlWebview:
                      "https://sufismart.sfi.co.id/sufismart/api/simulasi_page_sufismart.php?userid=${userid ?? ""}",
                });
                //Navigator.of(context).pushNamed(RouteName.creditSimulation);
              }, gotoPromo: () {
                Navigator.of(context).pushNamed(RouteName.allNews);
              }, gotoProduct: () {
                Navigator.of(context).pushNamed(RouteName.productCategory);
              }, gotoBranch: () {
                Navigator.of(context).pushNamed(RouteName.branch);
              }, gotoPayment: () {
                Navigator.of(context).pushNamed(RouteName.webView, arguments: {
                  ParamName.urlWebview:
                      "https://sufismart.sfi.co.id/sufismart/api/layanan_2.php",
                });
              }, gotoInstallment: () {
                if (System.data.global.customerNewModel?.userid != null) {
                  String? email = System.data.global.customerNewModel?.email;
                  Navigator.of(context)
                      .pushNamed(RouteName.webView, arguments: {
                    ParamName.urlWebview:
                        "https://sufismart.sfi.co.id/sufismart/api/ic_product_sufismart.php?EMAIL=${email ?? ""}",
                  });
                } else {
                  return System.data.showmodal(
                      System.data.strings?.silahkanloginterlebihdulu,
                      "Announcement");
                  //Navigator.of(context).pushNamed(RouteName.alertNoLogin);
                }
                //Navigator.of(context).pushNamed(RouteName.alertNoLogin);
              }, gotoApply: () {
                String? userid = System.data.global.customerNewModel?.userid;
                Navigator.of(context).pushNamed(RouteName.webView, arguments: {
                  ParamName.urlWebview:
                      "https://sufismart.sfi.co.id/sufismart/api/credit_simulation_apply_all.php?userid=${userid ?? ""}",
                });
              }, goToRedeemPointHome: () {
                Navigator.of(context).pushNamed(
                  RouteName.merchantPointView,
                );
              }, goTolevel: () {
                System.data.showmodal("Coming Soon", "Announcement");
              }, onTapWebviewRedeemHome: (url) {
                Navigator.of(context).pushNamed(RouteName.webView, arguments: {
                  ParamName.urlWebview: url,
                });
                ModeUtil.debugPrint("Url Webview" + url);
              });
            case 1:
              return AboutView(onTapFaq: () {
                Navigator.of(context).pushNamed(RouteName.webView, arguments: {
                  ParamName.urlWebview:
                      "https://sufismart.sfi.co.id/sufismart/api/faq.php",
                });
              }, onTapWeb: () {
                Navigator.of(context).pushNamed(RouteName.webView, arguments: {
                  ParamName.urlWebview: "https://www.sfi.co.id",
                });
              }, onTapWebview: (url) {
                Navigator.of(context).pushNamed(RouteName.webView, arguments: {
                  ParamName.urlWebview: url,
                });
                ModeUtil.debugPrint("Url Webview" + url);
              });
            case 2:
              return const ContactView();
            case 3:
              if (System.data.global.customerNewModel?.userid != null) {
                return DashboardView(goToChangePass: () {
                  Navigator.of(context).pushNamed(RouteName.changePassword);
                }, goToChangeProfile: () {
                  Navigator.of(context).pushNamed(RouteName.changeProfile);
                }, goTologout: () {
                  System.data.global.customerNewModel = null;
                  System.data.global.token = '';
                  System.data.session!.setString(SessionKey.user, "");
                  ModeUtil.debugPrint(
                      "new customer ${System.data.global.customerNewModel?.toJson()}");
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      RouteName.mainMenu, (r) => r.settings.name == "");
                }, goToListApply: () {
                  Navigator.of(context).pushNamed(RouteName.applyUserview);
                }, goToListHistoryPoint: () {
                  Navigator.of(context).pushNamed(RouteName.historyPointView);
                }, goToRedeemPoint: () {
                  Navigator.of(context).pushNamed(RouteName.merchantPointView);
                }, goToLevelUser: () {
                  System.data.showmodal("Coming Soon", "Announcement");
                }, onTapWebviewRedeem: (url) {
                  Navigator.of(context)
                      .pushNamed(RouteName.webView, arguments: {
                    ParamName.urlWebview: url,
                  });
                  ModeUtil.debugPrint("Url Webview$url");
                });
              } else {
                return LoginView(
                  gotoSignup: () {
                    //Navigator.of(context).pushNamed(RouteName.signUp);
                    Navigator.of(context).pushNamed(RouteName.register);
                  },
                  gotoForgetPassword: () {
                    Navigator.of(context).pushNamed(RouteName.forgotPassword);
                    //Navigator.of(context).pushNamed(RouteName.register);
                  },
                  onLoginSuccess2: (customer) {
                    System.data.global.customerNewModel = customer;
                    System.data.global.token = customer.deviceid;
                    System.data.session!.setString(
                        SessionKey.user, json.encode(customer.toJson()));
                    ModeUtil.debugPrint(
                        "new customer ${System.data.global.customerNewModel?.toJson()}");
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        RouteName.mainMenu, (r) => r.settings.name == "");
                  },
                );
              }
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
  RouteName.branch: (BuildContext context) {
    return const BranchView();
  },
  RouteName.productCategory: (BuildContext context) {
    return ProductCategoryView(
      onTapCategoryitem: (categoryModel) {
        Navigator.of(context).pushNamed(RouteName.productList,
            arguments: {ParamName.productCategory: categoryModel});
      },
    );
  },
  RouteName.signUp: (BuildContext context) {
    return SignupView(
      onRegisterSucces: (customer) {
        System.data.global.customerModel = customer;
        System.data.global.token = customer.token;
        System.data.session!
            .setString(SessionKey.user, json.encode(customer.toJson()));
        Navigator.of(context).pushNamedAndRemoveUntil(
            RouteName.mainMenu, (r) => r.settings.name == "");
      },
    );
  },
  RouteName.dashboard: (BuildContext context) {
    return const DashboardView();
  },
  RouteName.alertNoLogin: (BuildContext context) {
    return const AlertLoginView();
  },
  RouteName.productList: (BuildContext context) {
    Map<dynamic, dynamic> arg = (ModalRoute.of(context)?.settings.arguments ??
        {}) as Map<dynamic, dynamic>;
    return ProductListView(
      onTapProductItems: (productid) {
        Navigator.of(context).pushNamed(RouteName.productType,
            arguments: {ParamName.productItem: productid});
      },
      productCategoryModel: arg[ParamName.productCategory],
    );
  },
  RouteName.productType: (BuildContext context) {
    Map<dynamic, dynamic> arg = (ModalRoute.of(context)?.settings.arguments ??
        {}) as Map<dynamic, dynamic>;
    return ProductTypeView(
      productListModel: arg[ParamName.productItem],
      onTapProductDetail: (productDetailitem) {
        Navigator.of(context).pushNamed(RouteName.productDetail,
            arguments: {ParamName.productItemDetail: productDetailitem});
      },
    );
  },
  RouteName.productDetail: (BuildContext context) {
    Map<dynamic, dynamic> arg = (ModalRoute.of(context)?.settings.arguments ??
        {}) as Map<dynamic, dynamic>;
    return ProductDetailView(
        productTypeModel: arg[ParamName.productItemDetail],
        ontapSimulatiCreditProduct: (url) {
          Navigator.of(context).pushNamed(RouteName.webView, arguments: {
            ParamName.urlWebview: url,
          });
          ModeUtil.debugPrint("Url Simulasi Product$url");
        });
  },
  RouteName.webView: (BuildContext context) {
    Map<dynamic, dynamic> arg = (ModalRoute.of(context)?.settings.arguments ??
        {}) as Map<dynamic, dynamic>;
    // String? strUrl;
    return WebViewSufi(
      urlweb: arg[ParamName.urlWebview],
    );
  },
  RouteName.forgotPassword: (BuildContext context) {
    return const ForgotPasswordView();
  },
  RouteName.changePassword: (BuildContext context) {
    return const ChangePasswordView();
  },
  RouteName.changeProfile: (BuildContext context) {
    return const ProfileView(
        // onUpdateSuccefuly: (value) {
        //   System.data.global.customerNewModel = null;
        //   System.data.global.customerNewModel = value;
        //   System.data.session!
        //       .setString(SessionKey.user, json.encode(value.toJson()));
        //   ModeUtil.debugPrint(
        //       "new customer ${System.data.global.customerNewModel?.toJson()}");
        //   Navigator.of(context).pop();
        // },
        );
  },
  RouteName.splashScreen: (BuildContext context) {
    return SplashScreenView(
      onFinish: () {
        Navigator.of(context).pushReplacementNamed(RouteName.mainMenu);
      },
    );
  },
  RouteName.register: (BuildContext context) {
    return RegisterView(
      onRegisterSucces: (customer) {
        System.data.global.customerNewModel = customer;
        System.data.global.token = customer.deviceid;
        System.data.session!
            .setString(SessionKey.user, json.encode(customer.toJson()));
        ModeUtil.debugPrint(
            "new customer ${System.data.global.customerNewModel?.toJson()}");
        Navigator.of(context).pushNamedAndRemoveUntil(
            RouteName.mainMenu, (r) => r.settings.name == "");
      },
    );
  },
  RouteName.applyUserview: (BuildContext context) {
    return ApplyViewUser(
      tapDetailApply: (str) {
        ModeUtil.debugPrint(str);
        Navigator.of(context).pushNamed(RouteName.webView, arguments: {
          ParamName.urlWebview: str,
        });
      },
    );
  },
  RouteName.detailNewsDeepLink: (BuildContext context) {
    Map<dynamic, dynamic> arg = (ModalRoute.of(context)?.settings.arguments ??
        {}) as Map<dynamic, dynamic>;
    return NewsDetailViewDeepLink(
      newsid: arg[ParamName.newsdetailid],
    );
  },
  RouteName.announcementView: (BuildContext context) {
    Map<dynamic, dynamic> arg = (ModalRoute.of(context)?.settings.arguments ??
        {}) as Map<dynamic, dynamic>;
    return AnnouncementView(
      id: arg[ParamName.notifid],
    );
  },
  RouteName.historyPointView: (BuildContext context) {
    return HistoryPointView(onTapWebviewRedeem: (url) {
      Navigator.of(context).pushNamed(RouteName.webView, arguments: {
        ParamName.urlWebview: url,
      });
      ModeUtil.debugPrint("Url Webview$url");
    });
  },
  RouteName.merchantPointView: (BuildContext context) {
    return MerchantView(
      onTapMerchantItems: (merchantmodel) {
        Navigator.of(context).pushNamed(RouteName.merchantDetailPointView,
            arguments: {ParamName.merchantid: merchantmodel});
      },
    );
  },
  RouteName.merchantDetailPointView: (BuildContext context) {
    Map<dynamic, dynamic> arg = (ModalRoute.of(context)?.settings.arguments ??
        {}) as Map<dynamic, dynamic>;
    return MerchantDetailView(
      merchantModel: arg[ParamName.merchantid],
    );
  }
};
