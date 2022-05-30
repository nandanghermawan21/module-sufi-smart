import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sufismart/util/mode_util.dart';
import 'package:sufismart/util/system.dart';
import 'package:sufismart/view_model/dashboard_view_model.dart';

class DashboardView extends StatefulWidget {
  final VoidCallback? goToChangePass;
  final VoidCallback? goToChangeProfile;
  final VoidCallback? goTologout;
  const DashboardView({
    Key? key,
    this.goToChangePass,
    this.goToChangeProfile,
    this.goTologout,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _DashboardViewState();
  }
}

class _DashboardViewState extends State<DashboardView> {
  DashboardViewModel dashboardViewModel = DashboardViewModel();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: dashboardViewModel,
      builder: (c, w) {
        return Scaffold(
          body: Container(
            padding: const EdgeInsets.all(15),
            color: Colors.transparent,
            height: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                children: [
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
                  menuProfilBar(System.data.strings!.ajukanPembiayaan,
                      "assets/ic_icon_address.png"),
                  const Divider(),
                  GestureDetector(
                    onTap: () {
                      widget.goToChangeProfile!();
                    },
                    child: menuProfilBar(System.data.strings!.updateProfile,
                        "assets/ic_icon_address.png"),
                  ),
                  const Divider(),
                  GestureDetector(
                    onTap: () {
                      widget.goToChangePass!();
                      ModeUtil.debugPrint("tap change pass");
                    },
                    child: menuProfilBar(System.data.strings!.settingPassword,
                        "assets/ic_icon_password.png"),
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
                                content: Text(System.data.strings!
                                    .infoLogout), // Message which will be pop up on the screen
                                // Action widget which will provide the user to acknowledge the choice
                                actions: [
                                  ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(System
                                                .data.color!.primaryColor)),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    }, // function used to perform after pressing the button
                                    child: const Text('No'),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      widget.goTologout!();
                                    },
                                    child: const Text('Yes'),
                                  ),
                                ],
                              ));
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
                    child: menuProfilBar(System.data.strings!.logOut,
                        "assets/ic_icon_signout.png"),
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
      },
    );
  }

  Widget header() {
    return Container(
      width: double.infinity,
      color: Colors.transparent,
      child: Column(
        children: [
          CircleAvatar(
            maxRadius: 50,
            minRadius: 30,
            backgroundImage: const NetworkImage(
              "https://www.w3schools.com/howto/img_avatar.png",
            ),
            foregroundImage: NetworkImage(
              System.data.global.customerNewModel?.imageuser ?? "",
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            System.data.global.customerNewModel?.name ?? "",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            System.data.global.customerNewModel?.email ?? "",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
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

  Widget menuProfilBar(String? title, String? imageAsset) {
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
                            color: Colors.transparent,
                            child: //Icon(iconData, size: 14, color: Colors.grey),
                                Image.asset(
                              imageAsset ?? "",
                              width: 15,
                              height: 15,
                            )),
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
}
