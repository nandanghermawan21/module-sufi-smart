import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sufismart/util/system.dart';
import 'package:sufismart/view_model/dashboard_view_model.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _DashboardViewState();
  }
}

class _DashboardViewState extends State<DashboardView> {
  DashboardViewModel dashboardViewModel = DashboardViewModel();

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
                  item(title: System.data.strings!.nIK),
                  item(title: System.data.strings!.phoneNumber),
                  item(
                    title: System.data.strings!.city,
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: bottomNavigationBar(),
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
          const CircleAvatar(
            maxRadius: 50,
            minRadius: 30,
            backgroundImage: NetworkImage(
              "https://www.w3schools.com/howto/img_avatar.png",
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            System.data.strings!.fullname,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            System.data.strings!.username,
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
          Text(title ?? "value"),
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
}
