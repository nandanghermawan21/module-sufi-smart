import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sufismart/component/basic_component.dart';
import 'package:sufismart/model/news_model.dart';
import 'package:sufismart/util/system.dart';
import 'package:sufismart/view_model/all_news_view_model.dart';

class AllNewsView extends StatefulWidget {
  final ValueChanged<NewsModel>? gotoDetailNews;

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
      child: Consumer<AllNewsViewModel>(
        builder: (BuildContext context, vm, Widget? child) {
          return Scaffold(
            appBar: appBar(),
            backgroundColor: System.data.color!.mainColor,
            body: homePage(),
          );
        },
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: List.generate(
              homeViewModel.listNews.length,
              (i) => GestureDetector(
                  onTap: () {
                    widget.gotoDetailNews!(homeViewModel.listNews[i]);
                  },
                  child: photos(homeViewModel.listNews[i])),
            ),
          ),
        ),
      ),
    );
  }

  Widget photos(NewsModel pm) {
    double width = (MediaQuery.of(context).size.width - 10) >= 400
        ? 400
        : MediaQuery.of(context).size.width - 10;
    return Container(
        margin: const EdgeInsets.only(bottom: 10),
        width: width,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BasicComponent.newsImageContainer(pm),
        ));
  }
}
