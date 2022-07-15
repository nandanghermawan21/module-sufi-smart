import 'package:flutter/material.dart';
import 'package:skeleton_text/skeleton_text.dart';
import 'package:sufismart/component/basic_component.dart';
import 'package:sufismart/model/popup_model.dart';
import 'package:sufismart/util/system.dart';
import 'package:sufismart/view_model/notif_view_model.dart';

class AnnouncementView extends StatefulWidget {
  final String? id;

  const AnnouncementView({
    Key? key,
    this.id,
  }) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _AnnouncementView();
  }
}

class _AnnouncementView extends State<AnnouncementView> {
  NotifViewModel notifViewModel = NotifViewModel();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicComponent.appBar(),
      body: SingleChildScrollView(
        child: FutureBuilder<PopupModel?>(
            future: notifViewModel.getDataNotifByid(id: widget.id),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Container(
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
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
                        child: Text(
                          snapshot.data?.content ?? "",
                          textAlign: TextAlign.justify,
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
                        // Container(
                        //   height: MediaQuery.of(context).size.height / 2,
                        //   width: double.infinity,
                        //   decoration: BoxDecoration(
                        //     color: Colors.grey[300],
                        //     borderRadius: const BorderRadius.all(
                        //       Radius.circular(5),
                        //     ),
                        //   ),
                        // ),
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
}
