import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sufismart/model/image_news_model.dart';
import 'package:sufismart/recource/color_ui.dart';
import 'package:sufismart/view_model/home_view_model.dart';

class AllNews extends StatefulWidget {
  final VoidCallback? gotoSignup;
  final VoidCallback? gotoForgotPassword;
  final VoidCallback? gotoPromo;
  final VoidCallback? gotoProduct;
  final VoidCallback? gotoBranch;
  final VoidCallback? gotoCredit;
  final VoidCallback? gotoInstallment;
  final VoidCallback? gotoPayment;

  const AllNews({
    Key? key,
    this.gotoSignup,
    this.gotoForgotPassword,
    this.gotoPromo,
    this.gotoProduct,
    this.gotoBranch,
    this.gotoCredit,
    this.gotoInstallment,
    this.gotoPayment,
  }) : super(key: key);

  @override
  _AllNewsState createState() => _AllNewsState();
}

class _AllNewsState extends State<AllNews> {
  HomeViewModel homeViewModel = HomeViewModel();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: homeViewModel,
      child: Consumer<HomeViewModel>(
        builder: (BuildContext context, vm, Widget? child) {
          return Scaffold(
            appBar: appBar(vm),
            backgroundColor: ColorUi.background,
            body: homePage(),
          );
        },
      ),
    );
  }

  AppBar appBar(HomeViewModel vm) {
    return AppBar(
      backgroundColor: ColorUi.mainColor,
      title: Image.asset(
        "assets/logo_sfi_white.png",
        fit: BoxFit.cover,
        height: 30,
      ),
    );
  }

  Widget homePage() {
    return RefreshIndicator(
      triggerMode: RefreshIndicatorTriggerMode.anywhere,
      onRefresh: homeViewModel.onRefreshHomePage,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: List.generate(
            homeViewModel.listNews.length,
            (i) => photos(homeViewModel.listNews[i]),
          ),
        ),
      ),
    );
  }

  Widget photos(ImgNewsModel pm) {
    double width = (MediaQuery.of(context).size.width - 50) > 400
        ? 400
        : MediaQuery.of(context).size.width - 50;
    return Container(
        margin: const EdgeInsets.all(5),
        color: Colors.red,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.network(
            "${pm.imagepath}",
            width: width,
            errorBuilder: (c, w, _) {
              return Image.asset("assets/logo_suzuki.png");
            },
            fit: BoxFit.cover,
          ),
        ));
  }
}
