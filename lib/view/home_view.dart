import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:skeleton_text/skeleton_text.dart';
import 'package:sufismart/component/basic_component.dart';
import 'package:sufismart/model/banner_model.dart';
import 'package:sufismart/model/news_model_new.dart';
import 'package:sufismart/model/point_model.dart';
import 'package:sufismart/util/mode_util.dart';
import 'package:sufismart/util/system.dart';
import 'package:sufismart/view_model/dashboard_view_model.dart';
import 'package:sufismart/view_model/home_view_model.dart';

class HomeView extends StatefulWidget {
  final VoidCallback? gotoForgotPassword;
  final VoidCallback? gotoPromo;
  final VoidCallback? gotoProduct;
  final VoidCallback? gotoBranch;
  final VoidCallback? gotoSimulation;
  final VoidCallback? gotoInstallment;
  final VoidCallback? gotoPayment;
  final VoidCallback? gotoShowAll;
  final ValueChanged<NewsModelNew>? gotoDetailNews;
  final VoidCallback? gotoApply;
  final VoidCallback? goToRedeemPointHome;
  final VoidCallback? goTolevel;

  const HomeView({
    Key? key,
    this.gotoForgotPassword,
    this.gotoPromo,
    this.gotoProduct,
    this.gotoBranch,
    this.gotoSimulation,
    this.gotoInstallment,
    this.gotoPayment,
    this.gotoShowAll,
    this.gotoDetailNews,
    this.gotoApply,
    this.goToRedeemPointHome,
    this.goTolevel,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HomeViewState();
  }
}

class _HomeViewState extends State<HomeView> {
  HomeViewModel homeViewModel = HomeViewModel();
  DashboardViewModel dashboardViewModel = DashboardViewModel();
  String? strUserid = System.data.global.customerNewModel?.userid;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: homeViewModel,
      child: Scaffold(
        body: Consumer<HomeViewModel>(
          builder: (c, d, w) {
            return RefreshIndicator(
              triggerMode: RefreshIndicatorTriggerMode.anywhere,
              onRefresh: homeViewModel.onRefreshHomePage,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    swiperBanner(),
                    header(strUserid ?? ""),
                    featureList(),
                    buttonApply(),
                    latestNews(),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget header(String? userid) {
    ModeUtil.debugPrint('userid $userid');
    return userid != ""
        ? Container(
            //padding: const EdgeInsets.only(top: 15, left: 30, right: 30, bottom: 5),
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.all(10),
            //height: 100,
            decoration: const BoxDecoration(
              color: Colors.white,
              // gradient: LinearGradient(
              //     begin: Alignment.topCenter,
              //     end: Alignment.bottomCenter,
              //     colors: [
              //       Color(0xff0d306b),
              //       Color.fromARGB(255, 63, 81, 181),
              //     ]),
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(0),
              ),
            ),
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 5),
                Row(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        color: Colors.transparent,
                        margin: const EdgeInsets.only(left: 10),
                        child: Text(
                          "${System.data.strings!.welcomeUser}${System.data.global.customerNewModel?.name}",
                          style: TextStyle(
                              color: System.data.color?.primaryColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w900),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                    ),
                    // Expanded(
                    //   flex: 1,
                    //   child: Row(
                    //     // mainAxisAlignment: MainAxisAlignment.end,
                    //     // children: const [
                    //     //   Icon(
                    //     //     FontAwesomeIcons.userCircle,
                    //     //     color: Colors.white,
                    //     //   ),
                    //     //   SizedBox(
                    //     //     width: 10,
                    //     //   ),
                    //     //   Icon(
                    //     //     FontAwesomeIcons.bell,
                    //     //     color: Colors.white,
                    //     //   )
                    //     // ],
                    //   ),
                    // )
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                pointuser(strUserid),
                // Container(
                //   margin: const EdgeInsets.only(left: 10),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       Expanded(
                //         flex: 2,
                //         child: Container(
                //           color: Colors.transparent,
                //           child: Column(
                //             mainAxisAlignment: MainAxisAlignment.start,
                //             children: [
                //               Container(
                //                 padding: const EdgeInsets.only(bottom: 5),
                //                 color: Colors.transparent,
                //                 child: Row(
                //                   children: [
                //                     Container(
                //                         color: Colors.transparent,
                //                         padding: const EdgeInsets.only(
                //                             bottom: 5, right: 5),
                //                         child: const Icon(
                //                           FontAwesomeIcons.coins,
                //                           size: 25,
                //                           color: Colors.amber,
                //                         )),
                //                     Container(
                //                       color: Colors.transparent,
                //                       child: Column(
                //                         children: [
                //                           Text(
                //                             "Points",
                //                             style: TextStyle(
                //                               fontSize: 12,
                //                               fontWeight: FontWeight.bold,
                //                               color: System.data.color?.primaryColor,
                //                             ),
                //                           ),
                //                           Text(
                //                             "100",
                //                             style: TextStyle(
                //                               fontSize: 12,
                //                               fontWeight: FontWeight.bold,
                //                               color: System.data.color?.primaryColor,
                //                             ),
                //                           ),
                //                         ],
                //                       ),
                //                     ),
                //                   ],
                //                 ),
                //               ),
                //             ],
                //           ),
                //         ),
                //       ),
                //       Expanded(
                //         flex: 2,
                //         child: Container(
                //           color: Colors.transparent,
                //           child: Column(
                //             mainAxisAlignment: MainAxisAlignment.start,
                //             children: [
                //               Container(
                //                 padding: const EdgeInsets.only(bottom: 5),
                //                 color: Colors.transparent,
                //                 child: Row(
                //                   children: [
                //                     Container(
                //                         color: Colors.transparent,
                //                         padding: const EdgeInsets.only(
                //                             bottom: 5, right: 5),
                //                         child: Icon(
                //                           FontAwesomeIcons.solidArrowAltCircleUp,
                //                           size: 25,
                //                           color: System.data.color!.primaryColor,
                //                         )),
                //                     Container(
                //                       color: Colors.transparent,
                //                       child: Column(
                //                         children: [
                //                           Text(
                //                             "Level",
                //                             style: TextStyle(
                //                               fontSize: 12,
                //                               fontWeight: FontWeight.bold,
                //                               color: System.data.color?.primaryColor,
                //                             ),
                //                           ),
                //                           Text(
                //                             "Diamond",
                //                             style: TextStyle(
                //                               fontSize: 12,
                //                               fontWeight: FontWeight.bold,
                //                               color: System.data.color?.primaryColor,
                //                             ),
                //                           ),
                //                         ],
                //                       ),
                //                     ),
                //                   ],
                //                 ),
                //               ),
                //             ],
                //           ),
                //         ),
                //       )
                //     ],
                //   ),
                // ),
                // // Text(
                // //   "Hi,${System.data.global.customerNewModel?.name}",
                //   style: const TextStyle(
                //       color: Colors.white, fontSize: 20, fontWeight: FontWeight.w900),
                //   overflow: TextOverflow.ellipsis,
                //   maxLines: 1,
                // ),
                // const SizedBox(
                //   height: 5,
                // ),
                // const Text(
                //   "Choose Suzuki Finance Indonesia \nfor your Suzuki credit",
                //   //"Pilih Suzuki Finance Indonesia \nUntuk kenyamanan kredit Suzuki anda",
                //   style: TextStyle(color: Colors.white, fontSize: 12),
                // ),
              ],
            ),
          )
        : Container();
  }

  Widget swiperBanner() {
    return Container(
      height: 230,
      //height: MediaQuery.of(context).size.height / 3.3,
      margin: const EdgeInsets.all(0),
      width: double.infinity,
      child: FutureBuilder<List<BannerModel>>(
        future: homeViewModel.listBannerSufi,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return
                // Swiper(
                //   itemBuilder: (BuildContext context, int index) {
                //     return Image.network(
                //       "${snapshot.data?[index].imagepath}",
                //       fit: BoxFit.fill,
                //     );
                //   },
                //   indicatorLayout: PageIndicatorLayout.COLOR,
                //   autoplay: true,
                //   itemCount: snapshot.data?.length ?? 0,
                //   pagination: const SwiperPagination(
                //     alignment: Alignment.bottomRight,
                //     margin: EdgeInsets.only(right: 0, bottom: 10),
                //   ),
                //   // control: const SwiperControl(),
                // );
                Swiper(
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  decoration: const BoxDecoration(
                      // border: Border.all(
                      //     color: Color(0xffeeeeee), width: 1.0),
                      //borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                  child: snapshot.data?[index].imagepath == null
                      ? Container(
                          height: MediaQuery.of(context).size.height / 3,
                          //height: 230,
                          decoration: const BoxDecoration(
                            // borderRadius: BorderRadius.all(
                            //     Radius.circular(10)),
                            image: DecorationImage(
                                image: AssetImage("assets/logo_sfi_white.png"),
                                fit: BoxFit.fill),
                          ),
                        )
                      : CachedNetworkImage(
                          imageUrl: snapshot.data?[index].imagepath ?? "",
                          imageBuilder: (context, imageProvider) => Container(
                            //height: MediaQuery.of(context).size.height / 3,
                            height: 230,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                  // bottomLeft: Radius.circular(15),
                                  // bottomRight: Radius.circular(15),
                                  ),
                              // borderRadius: BorderRadius.all(
                              //     Radius.circular(15)),
                              image: DecorationImage(
                                  image: imageProvider, fit: BoxFit.fill),
                            ),
                          ),
                          placeholder: (context, url) => SkeletonAnimation(
                              child: Container(
                            //height: MediaQuery.of(context).size.height / 3,
                            height: 230,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              // borderRadius: const BorderRadius.only(
                              //     bottomLeft: Radius.circular(15),
                              //     bottomRight: Radius.circular(15)),
                            ),
                          )),
                          errorWidget: (context, url, error) => Container(
                            //height: MediaQuery.of(context).size.height / 3,
                            height: 230,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              // borderRadius: const BorderRadius.only(
                              //     bottomLeft: Radius.circular(15),
                              //     bottomRight: Radius.circular(15))
                              // // borderRadius: BorderRadius.all(
                              // //     Radius.circular(10))
                              // ,
                            ),
                            child: const Center(
                              child: Icon(Icons.error),
                            ),
                          ),
                        ),
                );
              },
              itemCount: snapshot.data?.length ?? 0,
              pagination: const SwiperPagination(
                alignment: Alignment.bottomRight,
                margin: EdgeInsets.only(right: 0, bottom: 10),
              ),
              //control: new SwiperControl(),
              autoplay: true,
              duration: 3,
              containerHeight: 180,
            );
          } else {
            return SkeletonAnimation(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: const BorderRadius.all(
                    Radius.circular(5),
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Widget featureList() {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(topRight: Radius.circular(50)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(bottom: 10, left: 10),
            child: Text(
              System.data.strings!.features,
              style: TextStyle(
                  color: System.data.color!.primaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            //margin: const EdgeInsets.only(left: 25, right: 25),
            color: Colors.transparent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: buttonFeature(
                    image:
                        "https://www.sfi.co.id/assets/images/menu/Icon-Promo.png",
                    ontap: () {
                      widget.gotoPromo!();
                    },
                    title: System.data.strings!.promo,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: buttonFeature(
                    image:
                        "https://www.sfi.co.id/assets/images/menu/ic_menu/product.png",
                    ontap: () {
                      widget.gotoProduct!();
                    },
                    title: System.data.strings!.product,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: buttonFeature(
                    title: System.data.strings!.creditSimulation,
                    ontap: () {
                      //print("fire me");
                      widget.gotoSimulation!();
                    },
                    image:
                        "https://www.sfi.co.id/assets/images/menu/creditsimulation.png",
                  ),
                ),
              ],
            ),
          ),
          Container(
            //margin: const EdgeInsets.only(left: 5, right: 5),
            color: Colors.transparent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: buttonFeature(
                    title: System.data.strings!.installmentStatus,
                    ontap: () {
                      widget.gotoInstallment!();
                    },
                    image:
                        "https://www.sfi.co.id/assets/images/menu/inststat.png",
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: buttonFeature(
                    title: System.data.strings!.branch,
                    ontap: () {
                      widget.gotoBranch!();
                    },
                    image:
                        "https://www.sfi.co.id/assets/images/menu/dealerservice.png",
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: buttonFeature(
                    ontap: () {
                      widget.gotoPayment!();
                    },
                    title: System.data.strings!.paymentOption,
                    image:
                        "https://www.sfi.co.id/assets/images/menu/Icon-Layanan.png",
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buttonApply() {
    return Column(
      children: [
        Container(
          color: Colors.white,
          margin: const EdgeInsets.only(top: 10),
          padding: const EdgeInsets.only(top: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.all(0),
                child: Text(
                  System.data.strings!.applykendaraan,
                  style: TextStyle(
                      color: System.data.color!.primaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
        Container(
            margin: const EdgeInsets.only(right: 10),
            color: Colors.white,
            padding: const EdgeInsets.only(top: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    if (widget.gotoApply != null) {
                      widget.gotoApply!();
                    }
                  },
                  child: Container(
                    width: 120,
                    height: 40,
                    padding: const EdgeInsets.only(
                      left: 5,
                      right: 5,
                      top: 10,
                    ),
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color(0xff0d306b),
                            Colors.indigo,
                          ],
                        ),
                        color: System.data.color!.primaryColor,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20))),
                    child: Text(
                      System.data.strings!.apply,
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ))
      ],
    );
  }

  Widget buttonFeature({
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
              CachedNetworkImage(
                imageUrl: image,
                imageBuilder: (context, imageProvider) => Container(
                  //height: MediaQuery.of(context).size.height / 3.5,
                  //height: 230,
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(50)),
                    // borderRadius: BorderRadius.all(
                    //     Radius.circular(15)),
                    image:
                        DecorationImage(image: imageProvider, fit: BoxFit.fill),
                  ),
                ),
                placeholder: (context, url) => SkeletonAnimation(
                    child: Container(
                  //height: MediaQuery.of(context).size.height / 3,
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: const BorderRadius.all(Radius.circular(50)),
                  ),
                )),
                errorWidget: (context, url, error) => Container(
                  //height: MediaQuery.of(context).size.height / 3,
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: const BorderRadius.all(Radius.circular(50)),
                  ),
                  child: const Center(
                    child: Icon(Icons.error),
                  ),
                ),
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

  Widget latestNews() {
    return Column(
      children: [
        Container(
          color: Colors.white,
          margin: const EdgeInsets.only(top: 10),
          padding: const EdgeInsets.only(top: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(left: 20),
                child: Text(
                  System.data.strings!.latestNews,
                  style: TextStyle(
                      color: System.data.color!.primaryColor,
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
                    width: 100,
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: System.data.color!.primaryColor,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20))),
                    child: Text(
                      System.data.strings!.showAll,
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        Container(
          // padding: const EdgeInsets.symmetric(vertical: 10.0),
          //height: MediaQuery.of(context).size.height * 0.30,
          height: 250,
          padding: const EdgeInsets.all(5),
          color: Colors.white,
          child: FutureBuilder<List<NewsModelNew>>(
            future: homeViewModel.listNewsHomeSufi,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Container(
                  margin: const EdgeInsets.only(top: 5),
                  height: 250,
                  child: ListView.builder(
                    itemCount: snapshot.data?.length ?? 0,
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemBuilder: (ctx, i) {
                      return GestureDetector(
                          onTap: () {
                            widget.gotoDetailNews!(snapshot.data![i]);
                          },
                          child: photos(snapshot.data![i]));
                    },
                  ),
                );
              } else {
                // return SkeletonAnimation(
                //   child: Container(
                //     margin: const EdgeInsets.all(5),
                //     decoration: BoxDecoration(
                //       color: Colors.grey[300],
                //       borderRadius: const BorderRadius.all(
                //         Radius.circular(5),
                //       ),
                //     ),
                //   ),
                // );

                return SkeletonAnimation(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 220,
                    margin: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: const BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                  ),
                );
              }
            },
          ),
        ),
      ],
    );
  }

  Widget photos(NewsModelNew pm) {
    // double width = (MediaQuery.of(context).size.width - 50) > 370
    //     ? 370
    //     : MediaQuery.of(context).size.width - 50;
    // width:
    //                                                       MediaQuery.of(context)
    //                                                               .size
    //                                                               .width *
    //                                                           0.6,
    //                                                           height: 250,
    return Container(
        margin: const EdgeInsets.all(5),
        width: MediaQuery.of(context).size.width * 0.6,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BasicComponent.newsImageContainer2(
            pm,
          ),
        ));
  }

  Widget pointuser(String? struser) {
    return FutureBuilder<PointModel?>(
        future: dashboardViewModel.getDataPointById(id: struser),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container(
              padding: const EdgeInsets.only(left: 0),
              decoration: BoxDecoration(
                color: System.data.color!.whiteColor,
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: Row(
                children: [
                  menuPoint(
                    "Points",
                    snapshot.data?.point,
                    FontAwesomeIcons.coins,
                    Colors.amber,
                    widget.goToRedeemPointHome,
                  ),
                  Container(
                    color: Colors.transparent,
                    height: 40,
                    child: VerticalDivider(
                      color: System.data.color!.greyColor,
                    ),
                  ),
                  menuPoint(
                      "Level",
                      snapshot.data?.leveluser,
                      FontAwesomeIcons.medal,
                      System.data.color!.primaryColor,
                      widget.goTolevel),
                ],
              ),
              // child: Column(
              //   children: [
              //     menuPoint(
              //       "Points",
              //       snapshot.data?.point,
              //       FontAwesomeIcons.coins,
              //       Colors.amber,
              //     ),
              //     menuPoint(
              //       "Level",
              //       snapshot.data?.leveluser,
              //       FontAwesomeIcons.solidArrowAltCircleUp,
              //       System.data.color!.primaryColor,
              //     ),
              //   ],
              // ),
            );
          } else {
            return SkeletonAnimation(
              child: Container(
                padding: const EdgeInsets.only(left: 0),
                // decoration: BoxDecoration(
                //   color: System.data.color!.greyColor2,
                //   borderRadius: const BorderRadius.all(
                //     Radius.circular(10),
                //   ),
                // ),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: System.data.color!.greyColor2,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      height: 20,
                      width: double.infinity,
                      //color: Colors.transparent,
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: System.data.color!.greyColor2,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      height: 20,
                      width: double.infinity,
                      //color: Colors.transparent,
                    ),
                  ],
                ),
              ),
            );
          }
        });
  }

  Widget menuPoint(String? title, String? value, IconData iconstr, colorChild,
      VoidCallback? ontp) {
    return Expanded(
      child: GestureDetector(
        onTap: ontp,
        child: Column(
          children: [
            Text(
              title ?? "",
              style: TextStyle(
                color: System.data.color!.greyColor,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  color: Colors.transparent,
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Icon(
                    iconstr,
                    size: 20,
                    color: colorChild,
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  value ?? "",
                  style: TextStyle(
                    color: System.data.color!.greyColor,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
