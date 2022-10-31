import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:skeleton_text/skeleton_text.dart';
import 'package:sufismart/component/basic_component.dart';
import 'package:sufismart/model/historypoint_model.dart';
import 'package:sufismart/util/system.dart';
import 'package:sufismart/view_model/historypoint_view_model.dart';

class HistoryPointView extends StatefulWidget {
  final ValueChanged<String>? onTapWebviewRedeem;

  const HistoryPointView({Key? key, this.onTapWebviewRedeem})
      : super(
          key: key,
        );

  @override
  State<StatefulWidget> createState() {
    return _HistoryPointViewState();
  }
}

class _HistoryPointViewState extends State<HistoryPointView> {
  HistoryPointViewModel historyPointViewModel = HistoryPointViewModel();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: historyPointViewModel,
      child: Scaffold(
        appBar: BasicComponent.appBar(),
        backgroundColor: System.data.color!.background,
        body: pageListHistoryPoint(),
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

  Widget pageListHistoryPoint() {
    return Container(
      padding: const EdgeInsets.all(5),
      child: SingleChildScrollView(
        child: FutureBuilder<List<HistoryModel>?>(
          future: historyPointViewModel.getHistoryPointUser(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: List.generate(snapshot.data?.length ?? 0, (index) {
                  // return GestureDetector(
                  //   onTap: () {
                  //     //widget.onTapCategoryitem!(snapshot.data![index]);
                  //   },
                  //   child: listPageApply(snapshot.data![index]),
                  // );
                  return listHistoryPoint(snapshot.data![index]);
                }),
              );
            } else {
              return Column(
                children: List.generate(
                  6,
                  (index) {
                    return SkeletonAnimation(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 100,
                        margin: const EdgeInsets.all(5),
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
    );
  }

  Widget listHistoryPoint(HistoryModel model) {
    return GestureDetector(
      onTap: () {
        if (model.voidredeem == "0") {
          widget.onTapWebviewRedeem!(
            model.link ?? "",
          );
        }
      },
      child: Card(
        child: Container(
          width: MediaQuery.of(System.data.context).size.width,
          padding:
              const EdgeInsets.only(top: 10, right: 10, left: 10, bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: MediaQuery.of(System.data.context).size.width,
                color: Colors.transparent,
                //padding: const EdgeInsets.only(top: ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        // Container(
                        //   margin: const EdgeInsets.only(bottom: 5),
                        //   child: Icon(
                        //     Icons.card_giftcard,
                        //     color: System.data.color?.mainColor,
                        //     size: 15,
                        //   ),
                        // ),
                        Text(
                          model.deskripsi ?? "",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                              fontSize: 14),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          model.crtdate ?? "",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                              fontSize: 14),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        // Icon(
                        //   FontAwesomeIcons.chevronCircleRight,
                        //   color: System.data.color?.mainColor,
                        //   size: 12,
                        // ),
                      ],
                    ),
                  ],
                ),
              ),
              const Divider(),
              Row(
                children: [
                  Container(
                    color: Colors.transparent,
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Icon(
                      model.tipe == 'in'
                          ? FontAwesomeIcons.solidArrowAltCircleDown
                          : FontAwesomeIcons.solidArrowAltCircleUp,
                      size: 20,
                      color:
                          model.tipe == 'in' ? Colors.lightGreen : Colors.red,
                    ),
                  ),
                  const SizedBox(
                    width: 3,
                  ),
                  Text(
                    model.point ?? "",
                    style: TextStyle(
                      //fontWeight: FontWeight.bold,
                      color:
                          model.tipe == 'in' ? Colors.lightGreen : Colors.red,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                model.note ?? "",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: System.data.color?.mainColor,
                    fontSize: 13),
              ),
              const SizedBox(
                height: 5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
