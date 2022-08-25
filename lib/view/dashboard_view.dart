import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:skeleton_text/skeleton_text.dart';
import 'package:sufismart/model/point_model.dart';
import 'package:sufismart/util/mode_util.dart';
import 'package:sufismart/util/system.dart';
import 'package:sufismart/view_model/dashboard_view_model.dart';

class DashboardView extends StatefulWidget {
  final VoidCallback? goToChangePass;
  final VoidCallback? goToChangeProfile;
  final VoidCallback? goTologout;
  final VoidCallback? goToListApply;
  final VoidCallback? goToListHistoryPoint;
  final VoidCallback? goToLevelUser;
  final VoidCallback? goToRedeemPoint;

  const DashboardView({
    Key? key,
    this.goToChangePass,
    this.goToChangeProfile,
    this.goTologout,
    this.goToListApply,
    this.goToListHistoryPoint,
    this.goToLevelUser,
    this.goToRedeemPoint,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _DashboardViewState();
  }
}

class _DashboardViewState extends State<DashboardView> {
  DashboardViewModel dashboardViewModel = DashboardViewModel();
  String? strUserid = System.data.global.customerNewModel?.userid;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(15),
        color: Colors.white24,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              //header2(),
              header(),
              const SizedBox(
                height: 20,
              ),
              // item(
              //     title: System.data.strings!.nIK,
              //     value: System.data.global.customerNewModel?.nik),
              // item(
              //   title: System.data.strings!.phoneNumber,
              //   value: System.data.global.customerNewModel?.nohp,
              // ),
              pointuser(strUserid),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: System.data.color!.whiteColor,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        widget.goToListApply!();
                      },
                      child: menuProfilBar(
                          System.data.strings!.ajukanPembiayaan,
                          "assets/ic_icon_address.png",
                          FontAwesomeIcons.clipboardList),
                    ),
                    const Divider(),
                    GestureDetector(
                      onTap: () {
                        widget.goToListHistoryPoint!();
                      },
                      child: menuProfilBar(
                          System.data.strings!.historyPoint,
                          "assets/ic_icon_address.png",
                          FontAwesomeIcons.history),
                    ),
                    const Divider(),
                    GestureDetector(
                      onTap: () {
                        widget.goToChangeProfile!();
                      },
                      child: menuProfilBar(
                          System.data.strings!.updateProfile,
                          "assets/ic_icon_address.png",
                          FontAwesomeIcons.userCheck),
                    ),
                    const Divider(),
                    GestureDetector(
                      onTap: () {
                        widget.goToChangePass!();
                        //ModeUtil.debugPrint("tap change pass");
                      },
                      child: menuProfilBar(System.data.strings!.settingPassword,
                          "assets/ic_icon_password.png", FontAwesomeIcons.lock),
                    ),
                    const Divider(),
                    GestureDetector(
                      onTap: () {
                        ModeUtil.debugPrint("tap change pass");
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: Text(System.data.strings!
                                .logOut), // To display the title it is optional
                            content: Text(
                              System.data.strings!.infoLogout,
                            ), // Message which will be pop up on the screen
                            // content: (SingleChildScrollView(
                            //   child: Container(
                            //     color: Colors.transparent,
                            //     child: Column(
                            //       children: const [
                            //         Text(
                            //           "Announcement",
                            //           style: TextStyle(
                            //               color: Color(0xff0d306b),
                            //               fontSize: 16,
                            //               fontWeight: FontWeight.bold),
                            //           textAlign: TextAlign.left,
                            //         ),
                            //         SizedBox(
                            //           height: 10,
                            //         ),
                            //         Text(
                            //           "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                            //           textAlign: TextAlign.justify,
                            //         ),
                            //       ],
                            //     ),
                            //   ),
                            // )),
                            // Action widget which will provide the user to acknowledge the choice
                            actions: [
                              ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        System.data.color!.primaryColor)),
                                onPressed: () {
                                  Navigator.pop(context);
                                }, // function used to perform after pressing the button
                                child: const Text('No'),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  widget.goTologout!();
                                },
                                child: const Text('Yes'),
                              ),
                            ],
                          ),
                        );
                        // showDialog(
                        //     context: context,
                        //     builder: (BuildContext context) => AlertDialog(
                        //           title: const Text('Warning'),
                        //           content: const Text(
                        //               'Hi this is Flutter Alert Dialog'),
                        //           actions: <Widget>[
                        //             IconButton(
                        //                 icon: const Icon(Icons.close),
                        //                 onPressed: () {
                        //                   Navigator.pop(context);
                        //                 })
                        //           ],
                        //         ));

                        //widget.goTologout!();
                      },
                      child: menuProfilBar(
                          System.data.strings!.logOut,
                          "assets/ic_icon_password.png",
                          FontAwesomeIcons.signOutAlt),
                    ),
                  ],
                ),
              ),

              // item(
              //   title: System.data.strings!.city,
              //   value: System.data.global.customerNewModel?.cityName,
              // ),
            ],
          ),
        ),
      ),
      //bottomNavigationBar: bottomNavigationBar(),
    );
  }

  Widget header2() {
    return Container(
      padding: const EdgeInsets.only(top: 10, left: 30, right: 30, bottom: 30),
      //height: 100,
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xff0d306b),
                Colors.indigo,
              ]),
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              const Expanded(
                flex: 3,
                child: Text(
                  "Welcome,",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const [
                    Icon(
                      FontAwesomeIcons.userCircle,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(
                      FontAwesomeIcons.bell,
                      color: Colors.white,
                    )
                  ],
                ),
              )
            ],
          ),
          const Text(
            "Dear",
            style: TextStyle(
                color: Colors.white, fontSize: 28, fontWeight: FontWeight.w900),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          const SizedBox(
            height: 5,
          ),
          const Text(
            "Choose Suzuki Finance Indonesia \nfor your Suzuki credit",
            //"Pilih Suzuki Finance Indonesia \nUntuk kenyamanan kredit Suzuki anda",
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget header() {
    return Container(
      width: double.infinity,
      color: Colors.transparent,
      child: Column(
        children: [
          ClipOval(
            child: CachedNetworkImage(
              imageUrl: System.data.global.customerNewModel?.imageuser ??
                  "https://www.w3schools.com/howto/img_avatar.png",
              imageBuilder: (context, imageProvider) => Container(
                height: 120,
                width: 120,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(50)),
                  image:
                      DecorationImage(image: imageProvider, fit: BoxFit.fill),
                ),
              ),
              placeholder: (context, url) => SkeletonAnimation(
                  child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: const BorderRadius.all(Radius.circular(50))),
              )),
              errorWidget: (context, url, error) => Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: const BorderRadius.all(Radius.circular(50))),
                child: const Center(
                  child: Icon(Icons.error),
                ),
              ),
            ),
          ),
          // CircleAvatar(
          //   maxRadius: 50,
          //   minRadius: 30,
          //   backgroundImage: const NetworkImage(
          //     "",
          //   ),
          //   foregroundImage: NetworkImage(
          //     System.data.global.customerNewModel?.imageuser ??
          //         "https://www.w3schools.com/howto/img_avatar.png",
          //   ),
          // ),
          const SizedBox(
            height: 10,
          ),
          Text(
            //"${System.data.strings!.welcomeUser}${System.data.global.customerNewModel?.name ?? ""}",
            System.data.global.customerNewModel?.name ?? "",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            color: Colors.transparent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 4),
                  child: Icon(
                    FontAwesomeIcons.envelopeSquare,
                    size: 15,
                    color: System.data.color!.greyColor2,
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  System.data.global.customerNewModel?.email ?? "",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget item({
    String? title,
    String? value,
  }) {
    return Container(
      height: 20,
      width: double.infinity,
      color: Colors.transparent,
      margin: const EdgeInsets.only(bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title ?? "title",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(value ?? "value"),
        ],
      ),
    );
  }

  Widget bottomNavigationBar() {
    return Container(
      margin: const EdgeInsets.all(15),
      color: Colors.transparent,
      height: 50,
      child: ElevatedButton(
        style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all(System.data.color!.primaryColor)),
        onPressed: () {},
        child: Text(System.data.strings!.logOut),
      ),
    );
  }

  Widget menuProfilBar(String? title, String? imageAsset, IconData? str) {
    return Container(
      color: Colors.transparent,
      width: MediaQuery.of(System.data.context).size.width,
      child: Container(
        padding: const EdgeInsets.all(5),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Container(
                    color: Colors.transparent,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.only(bottom: 2),
                          color: Colors.transparent,
                          child: Icon(str, size: 20, color: Colors.grey),
                          //     Image.asset(
                          //   imageAsset ?? "",
                          //   width: 15,
                          //   height: 15,
                          // ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                    flex: 6,
                    child: Container(
                      color: Colors.transparent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            color: Colors.transparent,
                            child: Text(title ?? "",
                                style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey)),
                          ),
                        ],
                      ),
                    )),
                Expanded(
                  flex: 1,
                  child: Container(
                    color: Colors.transparent,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          color: Colors.transparent,
                          child: const Icon(Icons.arrow_forward_ios,
                              size: 16, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget pointuser(String? struser) {
    return FutureBuilder<PointModel?>(
        future: dashboardViewModel.getDataPointById(id: struser),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: System.data.color!.whiteColor,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: Container(
                  color: Colors.transparent,
                  child: Column(
                    children: [
                      Container(
                        color: Colors.transparent,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              snapshot.data?.tipe ?? "",
                              style: TextStyle(
                                color: System.data.color!.greyColor,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            Text(
                              " - ",
                              style: TextStyle(
                                color: System.data.color!.greyColor,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            Text(
                              snapshot.data?.idkomunitas ?? "",
                              style: TextStyle(
                                color: System.data.color!.greyColor,
                                fontWeight: FontWeight.normal,
                              ),
                            )
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          menuPoint(
                              "Points",
                              snapshot.data?.point,
                              FontAwesomeIcons.coins,
                              Colors.amber,
                              widget.goToRedeemPoint!),
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
                              widget.goToLevelUser),

                          // menuPoint(
                          //   "Points",
                          //   snapshot.data?.point,
                          //   FontAwesomeIcons.coins,
                          //   Colors.amber,
                          // ),
                          // menuPoint(
                          //   "Level",
                          //   snapshot.data?.leveluser,
                          //   FontAwesomeIcons.solidArrowAltCircleUp,
                          //   System.data.color!.primaryColor,
                          // ),
                        ],
                      ),
                    ],
                  ),
                ));
          } else {
            return SkeletonAnimation(
              child: Container(
                color: Colors.transparent,
                padding: const EdgeInsets.all(10),
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
                      height: 2,
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

  // Widget menuPoint2(
  //     String? title, String? title2, IconData iconstr, colorChild) {
  //   return Container(
  //     color: Colors.transparent,
  //     child: Column(
  //       children: [
  //         Container(
  //           color: Colors.transparent,
  //           width: MediaQuery.of(System.data.context).size.width,
  //           child: Container(
  //             padding: const EdgeInsets.all(0),
  //             child: Column(
  //               children: <Widget>[
  //                 Row(
  //                   children: <Widget>[
  //                     Expanded(
  //                       flex: 2,
  //                       child: Container(
  //                         color: Colors.transparent,
  //                         child: Column(
  //                           crossAxisAlignment: CrossAxisAlignment.start,
  //                           children: <Widget>[
  //                             Container(
  //                               margin: const EdgeInsets.only(bottom: 2),
  //                               color: Colors.transparent,
  //                               child: Text(
  //                                 title ?? "",
  //                                 style: const TextStyle(
  //                                   fontSize: 15,
  //                                   fontWeight: FontWeight.bold,
  //                                   color: Colors.grey,
  //                                 ),
  //                               ),
  //                               //     Image.asset(
  //                               //   imageAsset ?? "",
  //                               //   width: 15,
  //                               //   height: 15,
  //                               // ),
  //                             ),
  //                           ],
  //                         ),
  //                       ),
  //                     ),
  //                     Expanded(
  //                       flex: 6,
  //                       child: Container(
  //                         color: Colors.transparent,
  //                         child: Column(
  //                           crossAxisAlignment: CrossAxisAlignment.start,
  //                           children: <Widget>[
  //                             Container(
  //                               color: Colors.transparent,
  //                               child: Row(
  //                                 children: [
  //                                   Container(
  //                                     color: Colors.transparent,
  //                                     padding: const EdgeInsets.only(bottom: 5),
  //                                     child: Icon(
  //                                       iconstr,
  //                                       size: 24,
  //                                       color: colorChild,
  //                                     ),
  //                                   ),
  //                                   const SizedBox(
  //                                     width: 5,
  //                                   ),
  //                                   Text(
  //                                     title2 ?? "",
  //                                     style: const TextStyle(
  //                                       fontSize: 15,
  //                                       fontWeight: FontWeight.bold,
  //                                       color: Colors.grey,
  //                                     ),
  //                                   ),
  //                                 ],
  //                               ),
  //                             ),
  //                           ],
  //                         ),
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

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
                  width: 3,
                ),
                Text(
                  value ?? "",
                  style: TextStyle(
                    color: System.data.color!.greyColor,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
