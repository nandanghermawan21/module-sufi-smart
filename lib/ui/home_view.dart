import 'package:card_swiper/card_swiper.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sufismart/model/image_news_model.dart';
import 'package:sufismart/recource/color_ui.dart';
import 'package:sufismart/recource/strings.dart';
import 'package:sufismart/view_model/home_view_model.dart';

class HomeView extends StatefulWidget {
  final VoidCallback? gotoSignup;
  final VoidCallback? gotoForgotPassword;
  final VoidCallback? gotoPromo;
  final VoidCallback? gotoProduct;
  final VoidCallback? gotoBranch;
  final VoidCallback? gotoCredit;
  final VoidCallback? gotoInstallment;
  final VoidCallback? gotoPayment;
  final VoidCallback? gotoShowAll;

  const HomeView({
    Key? key,
    this.gotoSignup,
    this.gotoForgotPassword,
    this.gotoPromo,
    this.gotoProduct,
    this.gotoBranch,
    this.gotoCredit,
    this.gotoInstallment,
    this.gotoPayment,
    this.gotoShowAll,
  }) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
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
            body: vm.selectedIndex == 0
                ? homePage()
                : vm.selectedIndex == 1
                    ? pageAbout()
                    : vm.selectedIndex == 2
                        ? pageContact()
                        : pageLogin(),
            bottomNavigationBar: bottomNavigationBar(vm),
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

  Widget bottomNavigationBar(HomeViewModel vm) {
    return FancyBottomNavigation(
      barBackgroundColor: ColorUi.mainColor,
      activeIconColor: ColorUi.mainColor,
      circleColor: ColorUi.background,
      inactiveIconColor: ColorUi.background,
      textColor: ColorUi.background,
      tabs: [
        TabData(
          iconData: Icons.home,
          title: Strings.home,
        ),
        TabData(
          iconData: Icons.phone_iphone,
          title: Strings.about,
        ),
        TabData(
          iconData: Icons.email,
          title: Strings.contact,
        ),
        TabData(
          iconData: Icons.person_pin,
          title: Strings.account,
        ),
      ],
      initialSelection: vm.selectedIndex,
      onTabChangedListener: vm.onItemTapped,
    );
  }

  Widget homePage() {
    return RefreshIndicator(
      triggerMode: RefreshIndicatorTriggerMode.anywhere,
      onRefresh: homeViewModel.onRefreshHomePage,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 200,
              margin: const EdgeInsets.only(bottom: 5, top: 5),
              width: double.infinity,
              child: Swiper(
                itemBuilder: (BuildContext context, int index) {
                  return Image.asset(
                    "${homeViewModel.listBanner[index].imagepath}",
                    fit: BoxFit.fill,
                  );
                },
                indicatorLayout: PageIndicatorLayout.COLOR,
                autoplay: true,
                itemCount: homeViewModel.listBanner.length,
                pagination: const SwiperPagination(
                  alignment: Alignment.bottomRight,
                  margin: EdgeInsets.only(right: 0, bottom: 10),
                ),
                // control: const SwiperControl(),
              ),
            ),
            process(),
          ],
        ),
      ),
    );
  }

  Widget process() {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(topRight: Radius.circular(50)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            child: const Text(
              Strings.features,
              style: TextStyle(
                  color: ColorUi.colorff0d306b,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 25, right: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                buttonFuture(
                  image: 'assets/ic_icon_promo.png',
                  ontap: () {
                    widget.gotoPromo!();
                  },
                  title: Strings.promo,
                ),
                buttonFuture(
                  image: 'assets/ic_icon_product.png',
                  ontap: () {
                    widget.gotoProduct!();
                  },
                  title: Strings.product,
                ),
                buttonFuture(
                  title: Strings.branch,
                  ontap: () {
                    widget.gotoBranch!();
                  },
                  image: 'assets/ic_icon_branch.png',
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 25, right: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                buttonFuture(
                  title: Strings.creditSimulation,
                  ontap: () {
                    widget.gotoCredit!();
                  },
                  image: 'assets/ic_icon_credit_simulation.png',
                ),
                buttonFuture(
                  title: Strings.installmentStatus,
                  ontap: () {
                    widget.gotoInstallment!();
                  },
                  image: 'assets/ic_icon_installment_status.png',
                ),
                buttonFuture(
                  ontap: () {
                    widget.gotoPayment!();
                  },
                  title: Strings.paymentOption,
                  image: 'assets/ic_icon_wop.png',
                ),
              ],
            ),
          ),
          const Divider(),
          Container(
            margin: const EdgeInsets.only(top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: const Text(
                    Strings.latestNews,
                    style: TextStyle(
                        color: ColorUi.colorff0d306b,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(right: 10),
                  child: InkWell(
                    onTap: () {
                      if (widget.gotoShowAll != null) {
                        widget.gotoShowAll!();
                      }
                    },
                    child: Container(
                      width: 80,
                      padding: const EdgeInsets.all(5),
                      decoration: const BoxDecoration(
                          color: ColorUi.colorff0d306b,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: const Text(
                        Strings.showAll,
                        style: TextStyle(color: Colors.white, fontSize: 12),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            height: MediaQuery.of(context).size.height * 0.33,
            color: Colors.transparent,
            child: Container(
              margin: const EdgeInsets.only(top: 5),
              height: 200,
              child: ListView.builder(
                itemCount: homeViewModel.listNews.length,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder: (ctx, i) {
                  return photos(homeViewModel.listNews[i]);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buttonFuture({
    required VoidCallback ontap,
    required String title,
    required String image,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        onTap: ontap,
        child: Center(
          child: Column(
            children: <Widget>[
              Image.asset(
                image,
                width: 60,
                height: 60,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 12,
                ),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget photos(ImgNewsModel pm) {
    double width = (MediaQuery.of(context).size.width - 50) > 370
        ? 370
        : MediaQuery.of(context).size.width - 50;
    return Container(
        margin: const EdgeInsets.all(5),
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

  Widget pageAbout() {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 50),
              child: Image.asset(
                'assets/logo_suzuki.png',
                height: 100.0,
                width: 100.0,
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(top: 20),
              child: Column(children: const <Widget>[
                Text(
                  Strings.appName,
                  style: TextStyle(
                    color: ColorUi.colorff0d306b,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  Strings.version,
                  style: TextStyle(
                    color: ColorUi.colorff0d306b,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                )
              ]),
            ),
            Container(
              margin: const EdgeInsets.only(top: 50),
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const <Widget>[
                        Text(
                          Strings.callCenter,
                          style: TextStyle(
                            color: ColorUi.colorff0d306b,
                            fontSize: 18,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          Strings.numberCallCenter,
                          style: TextStyle(
                            color: ColorUi.colorff0d306b,
                            fontSize: 18,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  const Divider(),
                  Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const <Widget>[
                        Text(
                          Strings.email,
                          style: TextStyle(
                            color: ColorUi.colorff0d306b,
                            fontSize: 18,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          Strings.emailCS,
                          style: TextStyle(
                            color: ColorUi.colorff0d306b,
                            fontSize: 18,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  const Divider(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget pageContact() {
    return SingleChildScrollView(
        child: Container(
      padding: const EdgeInsets.all(30),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 5),
            width: MediaQuery.of(context).size.width,
            child: const Text(
              Strings.contactUs,
              style: TextStyle(
                  color: ColorUi.colorff0d306b,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10),
            width: MediaQuery.of(context).size.width,
            child: const Text(
              Strings
                  .pleaseFillInTheInformationBelowForComplaintsAndOtherServices,
              style: TextStyle(
                color: ColorUi.colorff0d306b,
                fontSize: 14,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Form(
            key: homeViewModel.formKeyContact,
            autovalidateMode: AutovalidateMode.always,
            child: Container(
              margin: const EdgeInsets.only(top: 20),
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    autofocus: false,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp("[a-z A-Z]")),
                    ],
                    decoration: const InputDecoration(
                        labelText: Strings.fullname,
                        labelStyle: TextStyle(
                          color: Colors.grey,
                        ),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey))),
                    keyboardType: TextInputType.text,
                    cursorColor: Colors.grey,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return (Strings.fullname) +
                            (" " + Strings.canNotBeEmpty);
                      }
                      return null;
                    },
                    onSaved: (String? value) {
                      homeViewModel.setName = value!;
                    },
                  ),
                  TextFormField(
                    autofocus: false,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                    ],
                    decoration: const InputDecoration(
                        labelText: Strings.phoneNumber,
                        labelStyle: TextStyle(
                          color: Colors.grey,
                        ),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey))),
                    keyboardType: TextInputType.number,
                    cursorColor: Colors.grey,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return (Strings.phoneNumber) +
                            (" " + Strings.canNotBeEmpty);
                      } else if (value.length < 10) {
                        return Strings.phoneNumberAtLeast8Digits;
                      } else if (value.length > 15) {
                        return Strings.maximumPhoneNumber15Digits;
                      }
                      return null;
                    },
                    onSaved: (String? value) {
                      homeViewModel.setPhone = value!;
                    },
                  ),
                  TextFormField(
                    autofocus: false,
                    decoration: const InputDecoration(
                        labelText: Strings.email,
                        labelStyle: TextStyle(
                          color: Colors.grey,
                        ),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey))),
                    keyboardType: TextInputType.emailAddress,
                    cursorColor: Colors.grey,
                    validator: (String? value) {
                      RegExp regex = RegExp(
                          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
                      if (value!.isEmpty) {
                        return (Strings.email) + (" " + Strings.canNotBeEmpty);
                      } else if (!regex.hasMatch(value)) {
                        return Strings.enterAValidEmail;
                      }
                      return null;
                    },
                    onSaved: (String? value) {
                      homeViewModel.setEmail = value!;
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                        labelText: Strings.message,
                        labelStyle: TextStyle(
                          color: Colors.grey,
                        ),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey))),
                    keyboardType: TextInputType.text,
                    cursorColor: Colors.grey,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return (Strings.message) +
                            (" " + Strings.canNotBeEmpty);
                      }
                      return null;
                    },
                    onSaved: (String? value) {
                      homeViewModel.setMessage = value!;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      if (homeViewModel.formKeyContact.currentState!
                          .validate()) {
                        debugPrint(
                            "homeViewModel.formKeyContact.currentState ${homeViewModel.formKeyContact.currentState}");
                      }
                    },
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                          color: ColorUi.colorff0d306b,
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: const Center(
                        child: Text(
                          Strings.send,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }

  Widget pageLogin() {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 5),
              width: MediaQuery.of(context).size.width,
              child: const Text(
                Strings.welcomeBack,
                style: TextStyle(
                    color: ColorUi.colorff0d306b,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              width: MediaQuery.of(context).size.width,
              child: const Text(
                Strings
                    .enterYourEmailAndPasswordRegisteredInTheSUFISMARTApplication,
                style: TextStyle(
                  color: ColorUi.colorff0d306b,
                  fontSize: 16,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            TextField(
              controller: homeViewModel.emailTextEditingController,
              decoration: InputDecoration(
                labelText: '${Strings.enterThe} ${Strings.email}',
                errorText: homeViewModel.emailValidation
                    ? '${Strings.email} ${Strings.cantBeEmpty}'
                    : null,
              ),
            ),
            TextField(
              controller: homeViewModel.passwordTextEditingController,
              obscureText: homeViewModel.showPassword,
              decoration: InputDecoration(
                labelText: '${Strings.enterThe} ${Strings.password}',
                errorText: homeViewModel.passwordValidation
                    ? '${Strings.password} ${Strings.cantBeEmpty}'
                    : null,
                suffixIcon: IconButton(
                  onPressed: () {
                    homeViewModel.setShowPassword = !homeViewModel.showPassword;
                  },
                  icon: Icon(
                    homeViewModel.showPassword
                        ? FontAwesomeIcons.eye
                        : FontAwesomeIcons.eyeSlash,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: homeViewModel.login,
              child: Container(
                height: 50,
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: 10, top: 30),
                decoration: const BoxDecoration(
                    color: ColorUi.colorff0d306b,
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                child: const Center(
                  child: Text(
                    Strings.login,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                widget.gotoSignup!();
              },
              child: Container(
                margin: const EdgeInsets.only(bottom: 5),
                height: 50,
                width: double.infinity,
                decoration: const BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                child: const Center(
                  child: Text(
                    Strings.signUp,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
