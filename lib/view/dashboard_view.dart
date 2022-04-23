import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sufismart/util/enum.dart';
import 'package:sufismart/util/system.dart';
import 'package:sufismart/view_model/dashboard_view_model.dart';

class DashboardView extends StatefulWidget {
  final VoidCallback? onTapViewAllUser;

  const DashboardView({
    Key? key,
    this.onTapViewAllUser,
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
    dashboardViewModel.checkAuthenticate();
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
            child: Container(
              color: Colors.transparent,
              child: Stack(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        header(),
                        const SizedBox(
                          height: 20,
                        ),
                        item(
                            title: System.data.strings!.nIK,
                            value: System.data.global.customerModel?.nik),
                        item(
                          title: System.data.strings!.phoneNumber,
                          value: System.data.global.customerModel?.phoneNumber,
                        ),
                        item(
                          title: System.data.strings!.city,
                          value: System.data.global.customerModel?.cityName,
                        ),
                      ],
                    ),
                  ),
                  Consumer<DashboardViewModel>(
                    builder: (c, d, w) {
                      return Align(
                          alignment: Alignment.topRight,
                          child: dashboardViewModel.canAuthenticate
                              ? lockWithMiometric()
                              : const SizedBox());
                    },
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: Consumer<DashboardViewModel>(
            builder: (c, d, w) {
              return bottomNavigationBar();
            },
          ),
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
              System.data.global.customerModel?.imageUrl ?? "",
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            System.data.global.customerModel?.fullName ?? "",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            System.data.global.customerModel?.username ?? "",
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

  Widget lockWithMiometric() {
    return Container(
      height: 50,
      width: 50,
      margin: const EdgeInsets.only(top: 10),
      color: System.data.color!.primaryColor,
      child: Stack(
        children: [
          Center(
            child: Icon(
              Icons.fingerprint,
              color: dashboardViewModel.lockStatus == LockStatus.unRegister
                  ? Colors.red.shade500
                  : Colors.green,
              size: 45,
            ),
          ),
          Center(
            child: GestureDetector(
              onTap: () {
                dashboardViewModel.lockDashboard();
              },
              onLongPress: () {
                if (dashboardViewModel.lockStatus == LockStatus.opened) {
                  dashboardViewModel.registerAuth();
                }
              },
              child: Icon(
                dashboardViewModel.lockStatus == LockStatus.locked
                    ? FontAwesomeIcons.lock
                    : FontAwesomeIcons.lockOpen,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget bottomNavigationBar() {
    return dashboardViewModel.lockStatus == LockStatus.locked
        ? const SizedBox()
        : Container(
            margin: const EdgeInsets.all(15),
            color: Colors.transparent,
            height: 110,
            child: Column(
              children: [
                Container(
                  color: Colors.transparent,
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            System.data.color!.primaryColor)),
                    onPressed: () {
                      widget.onTapViewAllUser!();
                    },
                    child: Text(
                      System.data.strings!.viewAllUser,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  width: double.infinity,
                  color: Colors.transparent,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            System.data.color!.primaryColor)),
                    onPressed: () {},
                    child: Text(System.data.strings!.logOut),
                  ),
                ),
              ],
            ),
          );
  }
}
