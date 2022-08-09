import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skeleton_text/skeleton_text.dart';
import 'package:sufismart/component/basic_component.dart';

import 'package:sufismart/model/news_model_new.dart';
import 'package:sufismart/util/system.dart';
import 'package:sufismart/view_model/all_news_view_model.dart';

class AllNewsView extends StatefulWidget {
  final ValueChanged<NewsModelNew>? gotoDetailNews;

  const AllNewsView({
    Key? key,
    this.gotoDetailNews,
  }) : super(key: key);

  @override
  _AllNewsViewState createState() => _AllNewsViewState();
}

class _AllNewsViewState extends State<AllNewsView> {
  AllNewsViewModel homeViewModel = AllNewsViewModel();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: homeViewModel,
      child: Scaffold(
        appBar: appBar(),
        backgroundColor: System.data.color!.background,
        body: homePage(),
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      backgroundColor: System.data.color!.mainColor,
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
      child: Container(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: FutureBuilder<List<NewsModelNew>>(
            future: homeViewModel.allListNews,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: List.generate(snapshot.data?.length ?? 0, (index) {
                    return GestureDetector(
                      onTap: () {
                        widget.gotoDetailNews!(snapshot.data![index]);
                      },
                      child: photos(snapshot.data![index]),
                    );
                  }),
                );
              } else {
                return Column(
                  children: List.generate(
                    3,
                    (index) {
                      return SkeletonAnimation(
                        child: Container(
                          margin: const EdgeInsets.all(5),
                          height: MediaQuery.of(context).size.height / 2,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: const BorderRadius.all(
                              Radius.circular(5),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Widget photos(NewsModelNew pm) {
    double width = (MediaQuery.of(context).size.width - 10) >= 400
        ? 400
        : MediaQuery.of(context).size.width - 10;
    return Container(
        margin: const EdgeInsets.only(bottom: 10),
        width: width,
        child: ClipRRect(
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
          child: BasicComponent.newsImageContainer2(pm),
        ));
  }
}
