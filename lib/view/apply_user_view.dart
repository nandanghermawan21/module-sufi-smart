import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skeleton_text/skeleton_text.dart';

import 'package:sufismart/model/apply_model.dart';
import 'package:sufismart/util/mode_util.dart';
import 'package:sufismart/util/system.dart';
import 'package:sufismart/view_model/apply_view_model.dart';

class ApplyViewUser extends StatefulWidget {
  final ValueChanged<String>? tapDetailApply;
  const ApplyViewUser({
    Key? key,
    this.tapDetailApply,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ApplyViewUser();
  }
}

class _ApplyViewUser extends State<ApplyViewUser> {
  ApplyViewModel applyViewModel = ApplyViewModel();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: applyViewModel,
      child: Scaffold(
        appBar: appBar(),
        backgroundColor: System.data.color!.background,
        body: pageListApplyUser(),
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

  Widget pageListApplyUser() {
    return Container(
      padding: const EdgeInsets.all(5),
      child: SingleChildScrollView(
        child: FutureBuilder<List<ApplyModel>?>(
            future: applyViewModel.getApplyUser(),
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
                    return listPageApply(snapshot.data![index]);
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
                          height: 110,
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
            }),
      ),
    );
  }

  Widget listPageApply(ApplyModel modelApp) {
    return GestureDetector(
      onTap: () {
        //ModeUtil.debugPrint("${modelApp.viewdetail}");
        widget.tapDetailApply!(
          modelApp.viewdetail ?? "",
        );
      },
      child: Card(
        child: Container(
          width: MediaQuery.of(System.data.context).size.width,
          padding:
              const EdgeInsets.only(top: 3, right: 10, left: 10, bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:[
              Container(
                width: MediaQuery.of(System.data.context).size.width,
                padding: const EdgeInsets.only(top: 10),
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
                          modelApp.trxno ?? "",
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
                          modelApp.stat ?? "",
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
              // const SizedBox(
              //   height: 5,
              // ),
              Text(
                modelApp.orderno ?? "",
                style: const TextStyle(
                  //fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 12,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                "Produk ${modelApp.produk}",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: System.data.color?.mainColor,
                    fontSize: 13),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                "Model ${modelApp.model}",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: System.data.color?.mainColor,
                    fontSize: 13),
              ),
              // Container(
              //   width: MediaQuery.of(System.data.context).size.width,
              //   padding: const EdgeInsets.only(top: 10),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       Row(
              //         mainAxisAlignment: MainAxisAlignment.start,
              //         children: [
              //           Container(
              //             margin: const EdgeInsets.only(bottom: 5),
              //             child: Icon(
              //               Icons.location_on_outlined,
              //               color: System.data.color?.mainColor,
              //               size: 15,
              //             ),
              //           ),
              //           Text(
              //             "Produk ${modelApp.produk}",
              //             textAlign: TextAlign.center,
              //             style: TextStyle(
              //                 fontWeight: FontWeight.bold,
              //                 color: System.data.color?.mainColor,
              //                 fontSize: 13),
              //           ),
              //         ],
              //       ),
              //       Row(
              //         mainAxisAlignment: MainAxisAlignment.end,
              //         children: [
              //           Text(
              //             System.data.strings?.viewLocation ?? "",
              //             textAlign: TextAlign.center,
              //             style: TextStyle(
              //                 fontWeight: FontWeight.bold,
              //                 color: System.data.color?.mainColor,
              //                 fontSize: 12),
              //           ),
              //           const SizedBox(
              //             width: 10,
              //           ),
              //           Icon(
              //             FontAwesomeIcons.chevronCircleRight,
              //             color: System.data.color?.mainColor,
              //             size: 12,
              //           ),
              //         ],
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
