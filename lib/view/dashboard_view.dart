import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sufismart/util/system.dart';
import 'package:sufismart/view_model/dashboard_view_model.dart';

class DashboardView extends StatefulWidget {

  final VoidCallback? ontapview;

  const DashboardView({Key? key, this.ontapview}) : super(key: key);

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

  Widget bottomNavigationBar() {
    return Container(
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
                backgroundColor:
                    MaterialStateProperty.all(System.data.color!.primaryColor)),
            onPressed: () {

              widget.ontapview!();
            },
            child: Text(System.data.strings!.viewalluser),
        ),
         ),
          Container(
            color: Colors.transparent,
            width: double.infinity,
            child: ElevatedButton(
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(System.data.color!.primaryColor)),
            onPressed: () {},
            child: Text(System.data.strings!.logOut),
        ),
          ),
        ]
      ),
    );
  }
}
