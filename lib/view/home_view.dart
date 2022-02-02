import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sufismart/component/basic_component.dart';
import 'package:sufismart/model/news_model.dart';
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
  final ValueChanged<NewsModel>? gotoDetailNews;

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
                  image: 'assets/ic_icon_promo.png',
                  ontap: () {
                    widget.gotoPromo!();
                  },
                  title: System.data.strings!.promo,
                ),
                buttonFeature(
                  image: 'assets/ic_icon_product.png',
                  ontap: () {
                    widget.gotoProduct!();
                  },
                  title: System.data.strings!.product,
                ),
                buttonFeature(
                  title: System.data.strings!.branch,
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
                buttonFeature(
                  title: System.data.strings!.creditSimulation,
                  ontap: () {
                    widget.gotoSimulation!();
                  },
                  image: 'assets/ic_icon_credit_simulation.png',
                ),
                buttonFeature(
                  title: System.data.strings!.installmentStatus,
                  ontap: () {
                    widget.gotoInstallment!();
                  },
                  image: 'assets/ic_icon_installment_status.png',
                ),
                buttonFeature(
                  ontap: () {
                    widget.gotoPayment!();
                  },
                  title: System.data.strings!.paymentOption,
                  image: 'assets/ic_icon_wop.png',
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

  Widget latestNews() {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 10),
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
                return GestureDetector(
                    onTap: () {
                      widget.gotoDetailNews!(homeViewModel.listNews[i]);
                    },
                    child: photos(homeViewModel.listNews[i]));
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget photos(NewsModel pm) {
    double width = (MediaQuery.of(context).size.width - 50) > 370
        ? 370
        : MediaQuery.of(context).size.width - 50;
    return Container(
        margin: const EdgeInsets.all(5),
        width: width,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BasicComponent.newsImageContainer(
            pm,
          ),
        ));
  }
}
