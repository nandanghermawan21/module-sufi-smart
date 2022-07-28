import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:skeleton_text/skeleton_text.dart';
import 'package:sufismart/component/basic_component.dart';
import 'package:sufismart/model/news_model_new.dart';
import 'package:sufismart/util/system.dart';
import 'package:sufismart/view_model/all_news_view_model.dart';

class NewsDetailViewDeepLink extends StatefulWidget {
  //final NewsModel newsModel;
  final String? newsid;

  const NewsDetailViewDeepLink({
    Key? key,
    this.newsid,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _NewsDetailViewDeepLink();
  }
}

class _NewsDetailViewDeepLink extends State<NewsDetailViewDeepLink> {
  AllNewsViewModel allNewsViewModel = AllNewsViewModel();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicComponent.appBar(),
      body: SingleChildScrollView(
        child: FutureBuilder<NewsModelNew?>(
            future: allNewsViewModel.getDataNewsById(id: widget.newsid),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Container(
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CachedNetworkImage(
                        imageUrl: snapshot.data?.imagepath ?? "",
                        imageBuilder: (context, imageProvider) => SizedBox(
                          height: MediaQuery.of(context).size.height / 2,
                          child: Card(
                            margin: const EdgeInsets.only(bottom: 10.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(15),
                                  bottomRight: Radius.circular(15),
                                ),
                                image: DecorationImage(
                                    image: imageProvider, fit: BoxFit.fill),
                              ),
                            ),
                          ),
                        ),
                        placeholder: (context, url) => SkeletonAnimation(
                            child: Container(
                          height: MediaQuery.of(context).size.height / 2,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(15),
                              bottomRight: Radius.circular(15),
                            ),
                          ),
                        )),
                        errorWidget: (context, url, error) => Container(
                          height: MediaQuery.of(context).size.height / 2,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(15),
                              bottomRight: Radius.circular(15),
                            ),
                          ),
                          child: const Center(
                            child: Icon(Icons.error),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        width: double.infinity,
                        child: Text(
                          snapshot.data?.title ?? "",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: System.data.color!.mainColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        width: double.infinity,
                        child: HtmlWidget(
                          snapshot.data?.desc ?? "",
                        ),
                      )
                    ],
                  ),
                );
              } else {
                return SkeletonAnimation(
                  child: Container(
                    color: Colors.transparent,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height / 2,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: const BorderRadius.all(
                              Radius.circular(5),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(10),
                          width: double.infinity,
                          height: 30,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: const BorderRadius.all(
                              Radius.circular(5),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(10),
                          width: double.infinity,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: const BorderRadius.all(
                              Radius.circular(5),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
            }
            // child: Container(
            //   color: Colors.transparent,
            //   child: Column(
            //     mainAxisAlignment: MainAxisAlignment.start,
            //     children: [
            //       //BasicComponent.newsImageContainer2(widget.newsModel),
            //       Container(
            //         padding: const EdgeInsets.all(10),
            //         width: double.infinity,
            //         child: Text(
            //           //widget.newsModel.title ?? "",
            //           "",
            //           textAlign: TextAlign.left,
            //           style: TextStyle(
            //             color: System.data.color!.mainColor,
            //             fontWeight: FontWeight.bold,
            //           ),
            //         ),
            //       ),
            //       Container(
            //         padding: const EdgeInsets.all(10),
            //         width: double.infinity,
            //         child: HtmlWidget(
            //             //widget.newsModel.desc ?? "",
            //             ""),
            //       )
            //     ],
            //   ),
            // ),
            ),
      ),
    );
  }

  // Widget newsImageContainer(String imagepath) {
  //   return CachedNetworkImage(
  //     imageUrl: imagepath,
  //     imageBuilder: (context, imageProvider) => SizedBox(
  //       height: MediaQuery.of(context).size.height / 2,
  //       child: Card(
  //         margin: const EdgeInsets.only(bottom: 10.0),
  //         child: Container(
  //           decoration: BoxDecoration(
  //             borderRadius: const BorderRadius.all(Radius.circular(5)),
  //             image: DecorationImage(image: imageProvider, fit: BoxFit.fill),
  //           ),
  //         ),
  //       ),
  //     ),
  //     placeholder: (context, url) => SkeletonAnimation(
  //         child: Container(
  //       height: MediaQuery.of(context).size.height / 2,
  //       decoration: BoxDecoration(
  //           color: Colors.grey[300],
  //           borderRadius: const BorderRadius.all(Radius.circular(5))),
  //     )),
  //     errorWidget: (context, url, error) => Container(
  //       height: MediaQuery.of(context).size.height / 2,
  //       decoration: BoxDecoration(
  //           color: Colors.grey[300],
  //           borderRadius: const BorderRadius.all(Radius.circular(5))),
  //       child: const Center(
  //         child: Icon(Icons.error),
  //       ),
  //     ),
  //   );
  // }
}
