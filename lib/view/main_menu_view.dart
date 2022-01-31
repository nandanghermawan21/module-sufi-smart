import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sufismart/component/basic_component.dart';
import 'package:sufismart/model/menu_model.dart';
import 'package:sufismart/util/system.dart';
import 'package:sufismart/view_model/main_menu_view_model.dart';

class MainMenuView extends StatefulWidget {
  final Widget? Function(MenuModel, int)? onCreateBody;
  final List<MenuModel?>? menus;

  const MainMenuView({
    Key? key,
    this.onCreateBody,
    this.menus,
  }) : super(key: key);

  @override
  _MainMenuViewState createState() => _MainMenuViewState();
}

class _MainMenuViewState extends State<MainMenuView> {
  MainMenuViewModel mainMenuViewModel = MainMenuViewModel();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: mainMenuViewModel,
      child: Consumer<MainMenuViewModel>(
        builder: (BuildContext context, vm, Widget? child) {
          return Scaffold(
            appBar: BasicComponent.appBar(),
            backgroundColor: System.data.color!.background,
            body: widget.onCreateBody != null
                ? widget.onCreateBody!(MenuModel(), vm.selectedIndex)
                : null,
            bottomNavigationBar: bottomNavigationBar(vm),
          );
        },
      ),
    );
  }

  Widget bottomNavigationBar(MainMenuViewModel vm) {
    return FancyBottomNavigation(
      barBackgroundColor: System.data.color!.mainColor,
      activeIconColor: System.data.color!.mainColor,
      circleColor: System.data.color!.background,
      inactiveIconColor: System.data.color!.background,
      textColor: System.data.color!.background,
      tabs: List.generate(widget.menus?.length ?? 0, (index) {
        return TabData(
          iconData: widget.menus![index]?.iconData ?? Icons.home,
          title: widget.menus![index]?.title ?? System.data.strings!.home,
        );
      }),
      initialSelection: vm.selectedIndex,
      onTabChangedListener: vm.onItemTapped,
    );
  }
}
