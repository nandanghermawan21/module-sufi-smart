import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skeleton_text/skeleton_text.dart';
import 'package:sufismart/component/basic_component.dart';
import 'package:sufismart/model/banner_model.dart';
import 'package:sufismart/model/news_model.dart';
import 'package:sufismart/model/news_model_new.dart';
import 'package:sufismart/util/system.dart';
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

  const HomeView(
      {Key? key,
      this.gotoForgotPassword,
      this.gotoPromo,
      this.gotoProduct,
      this.gotoBranch,
      this.gotoSimulation,
      this.gotoInstallment,
      this.gotoPayment,
      this.gotoShowAll,
      this.gotoDetailNews})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HomeViewState();
  }
}

class _HomeViewState extends State<HomeView> {
  HomeViewModel homeViewModel = HomeViewModel();

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
                    featureList(),
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

  Widget swiperBanner() {
    return Container(
      height: 230,
      margin: const EdgeInsets.only(bottom: 5),
      width: double.infinity,
      child: FutureBuilder<List<BannerModel>>(
        future: homeViewModel.listBannerSufi,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Swiper(
              itemBuilder: (BuildContext context, int index) {
                return Image.network(
                  "${snapshot.data?[index].imagepath}",
                  fit: BoxFit.fill,
                );
              },
              indicatorLayout: PageIndicatorLayout.COLOR,
              autoplay: true,
              itemCount: snapshot.data?.length ?? 0,
              pagination: const SwiperPagination(
                alignment: Alignment.bottomRight,
                margin: EdgeInsets.only(right: 0, bottom: 10),
              ),
              // control: const SwiperControl(),
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
            child: Text(
              System.data.strings!.features,
              style: TextStyle(
                  color: System.data.color!.primaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 25, right: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                buttonFeature(
                  image:
                      "https://www.sfi.co.id/assets/images/menu/Icon-Promo.png",
                  ontap: () {
                    widget.gotoPromo!();
                  },
                  title: System.data.strings!.promo,
                ),
                buttonFeature(
                  image:
                      "https://www.sfi.co.id/assets/images/menu/ic_menu/product.png",
                  ontap: () {
                    widget.gotoProduct!();
                  },
                  title: System.data.strings!.product,
                ),
                buttonFeature(
                  title: System.data.strings!.creditSimulation,
                  ontap: () {
                    widget.gotoSimulation!();
                  },
                  image:
                      "https://www.sfi.co.id/assets/images/menu/creditsimulation.png",
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 25, right: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                buttonFeature(
                  title: System.data.strings!.installmentStatus,
                  ontap: () {
                    widget.gotoInstallment!();
                  },
                  image:
                      "https://www.sfi.co.id/assets/images/menu/inststat.png",
                ),
                buttonFeature(
                  title: System.data.strings!.branch,
                  ontap: () {
                    widget.gotoBranch!();
                  },
                  image:
                      "https://www.sfi.co.id/assets/images/menu/dealerservice.png",
                ),
                buttonFeature(
                  ontap: () {
                    widget.gotoPayment!();
                  },
                  title: System.data.strings!.paymentOption,
                  image:
                      "https://www.sfi.co.id/assets/images/menu/Icon-Layanan.png",
                ),
              ],
            ),
          ),
        ],
      ),
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
                margin: const EdgeInsets.only(left: 10),
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
                    width: 80,
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
          height: MediaQuery.of(context).size.height * 0.30,
          padding: const EdgeInsets.all(5),
          color: Colors.white,
          child: FutureBuilder<List<NewsModelNew>>(
            future: homeViewModel.listNewsHomeSufi,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Container(
                  margin: const EdgeInsets.only(top: 5),
                  height: 200,
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
                return SkeletonAnimation(
                  child: Container(
                    margin: const EdgeInsets.all(5),
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
        ),
      ],
    );
  }

  Widget photos(NewsModelNew pm) {
    double width = (MediaQuery.of(context).size.width - 50) > 370
        ? 370
        : MediaQuery.of(context).size.width - 50;
    return Container(
        margin: const EdgeInsets.all(5),
        width: width,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BasicComponent.newsImageContainer2(
            pm,
          ),
        ));
  }
}
