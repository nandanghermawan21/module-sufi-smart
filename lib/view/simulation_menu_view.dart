import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sufismart/util/system.dart';
import 'package:sufismart/view_model/simulation_menu_view_model.dart';
import 'package:sufismart/component/basic_component.dart';

class SimulationMenuView extends StatefulWidget {
  final VoidCallback? onTapSimulationCredit;
  final VoidCallback? onTapSimulationInstalment;
  final VoidCallback? onTapSimulationTotalPay;

  const SimulationMenuView({
    Key? key,
    this.onTapSimulationCredit,
    this.onTapSimulationInstalment,
    this.onTapSimulationTotalPay,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SimulationMenuViewState();
  }
}

class _SimulationMenuViewState extends State<SimulationMenuView> {
  SimulasiMenuViewModel simulasiMenuViewModel = SimulasiMenuViewModel();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: simulasiMenuViewModel,
      child: WillPopScope(
        onWillPop: () async {
          if (simulasiMenuViewModel.modeMenu == 1) {
            return true;
          } else {
            simulasiMenuViewModel.modeMenu = 1;
            return false;
          }
        },
        child: Scaffold(
            appBar: BasicComponent.appBar(),
            body: Consumer<SimulasiMenuViewModel>(
              builder: (c, d, w) {
                if (d.modeMenu == 1) {
                  return menuMode1();
                } else {
                  return menuMode2();
                }
              },
            )),
      ),
    );
  }

  Widget menuMode1() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          menu(
            image: "assets/ic_icon_credit_simulation.png",
            title: System.data.strings!.creditSimulation,
            onTap: widget.onTapSimulationCredit ?? () {},
          ),
          const SizedBox(
            width: 30,
          ),
          menu(
            image: "assets/ic_icon_credit_simulation.png",
            title: System.data.strings!.bugetSimulation,
            onTap: () {
              simulasiMenuViewModel.modeMenu = 2;
            },
          ),
        ],
      ),
    );
  }

  Widget menuMode2() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          menu(
            image: "assets/ic_icon_credit_simulation.png",
            title: System.data.strings!.installmentSimulation,
            onTap: () {},
          ),
          const SizedBox(
            width: 30,
          ),
          menu(
            image: "assets/ic_icon_credit_simulation.png",
            title: System.data.strings!.totalPaySimulation,
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget menu({
    required String image,
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 150,
        height: 200,
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 10,
            ),
          ],
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              child: Image.asset(
                image,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: FittedBox(
                child: Text(
                  title.replaceAll("\n", " "),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
