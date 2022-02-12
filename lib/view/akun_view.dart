import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sufismart/model/akun_model.dart';
import 'package:sufismart/util/data.dart';
import 'package:sufismart/view_model/akun_view_model.dart';
import 'package:sufismart/view_model/main_menu_view_model.dart';
import '../component/basic_component.dart';
import '../util/system.dart';

class AkunView extends StatefulWidget {
  final VoidCallback? logout;
  const AkunView({Key? key, this.logout}) : super(key: key);

  @override
  _AkunViewState createState() => _AkunViewState();
}

class _AkunViewState extends State<AkunView> {
  MainMenuViewModel mainMenuViewModel = MainMenuViewModel();
  AkunViewModel akunViewModel = AkunViewModel();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
        value: akunViewModel,
        child: Scaffold(body: SingleChildScrollView(
            child: Consumer<AkunViewModel>(builder: (c, d, w) {
          return Container(
            margin: const EdgeInsets.all(20),
            child: Column(
              children: [
                photo(),
                nama(),
                const SizedBox(
                  height: 40,
                ),
                detail(),
                const SizedBox(
                  height: 40,
                ),
                tombol()
              ],
            ),
          );
        }))));
  }

  Widget photo() {
    return Container(
      width: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Image.asset(akunViewModel.data?.img ?? "")]),
    );
  }

  Widget nama() {
    return Container(
        width: double.infinity,
        color: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              akunViewModel.data?.nama ?? "",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
            Text(
              akunViewModel.data?.namapengguna ?? "",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ],
        ));
  }

  Widget detail() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("No KTP",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
              Text(
                akunViewModel.data?.noktp ?? "",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("No Ponsel",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
              Text(
                akunViewModel.data?.noponsel ?? "",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Kota",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
              Text(
                akunViewModel.data?.kota ?? "",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget tombol() {
    return GestureDetector(
      onTap: () {
        widget.logout!();
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 5),
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
            color: System.data.color!.primaryColor,
            borderRadius: BorderRadius.all(Radius.circular(5))),
        child: Center(
          child: Text(
            System.data.strings!.keluar,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
        ),
      ),
    );
  }
}
