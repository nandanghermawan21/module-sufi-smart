import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sufismart/component/basic_component.dart';
import 'package:sufismart/model/menu_model.dart';
import 'package:sufismart/util/system.dart';
import 'package:sufismart/view_model/main_menu_view_model.dart';

class MainMenuView extends StatefulWidget {
  final List<MenuModel?>? menus;
  final Widget? Function(MenuModel, int)? onCreateBody;

  const MainMenuView({
    Key? key,
    this.onCreateBody,
    this.menus,
  }) : super(key: key);

  @override
  _MainMenuViewState createState() => _MainMenuViewState();
}

class _MainMenuViewState extends State<MainMenuView>
    with TickerProviderStateMixin {
  MainMenuViewModel mainMenuViewModel = MainMenuViewModel();

  @override
  void initState() {
    super.initState();
    mainMenuViewModel.initializeLang();
    mainMenuViewModel.tabController =
        TabController(length: widget.menus?.length ?? 0, vsync: this);
    mainMenuViewModel.tabController?.addListener(() {
      mainMenuViewModel.selectedIndex =
          mainMenuViewModel.tabController?.index ?? 0;
      final FancyBottomNavigationState fState = mainMenuViewModel
          .bottomNavigationKey.currentState as FancyBottomNavigationState;
      fState.setPage(mainMenuViewModel.selectedIndex);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: mainMenuViewModel,
      child: Consumer<MainMenuViewModel>(
        builder: (BuildContext context, vm, Widget? child) {
          return Scaffold(
            appBar: BasicComponent.appBar(actions: [
              dropDownLang(),
            ]),
            backgroundColor: System.data.color!.background,
            body: TabBarView(
              controller: mainMenuViewModel.tabController,
              children: List.generate(
                widget.menus?.length ?? 0,
                (index) {
                  return Container(
                    child: widget.onCreateBody!(widget.menus![index]!, index),
                  );
                },
              ),
            ),
            bottomNavigationBar: bottomNavigationBar(vm),
          );
        },
      ),
    );
  }

  Widget dropDownLang() {
    return DropdownButton<String>(
        value: mainMenuViewModel.lang?.lang,
        items: List.generate(mainMenuViewModel.langs.length, (index) {
          return DropdownMenuItem<String>(
            value: mainMenuViewModel.langs[index].lang,
            child: Container(
              height: 35,
              color: Colors.transparent,
              child: Image.asset(
                mainMenuViewModel.langs[index].flag ?? "",
              ),
            ),
          );
        }),
        onChanged: (lang) {
          mainMenuViewModel.lang =
              mainMenuViewModel.langs.where((e) => e.lang == lang).first;
        });
  }

  Widget bottomNavigationBar(MainMenuViewModel vm) {
    return FancyBottomNavigation(
      key: vm.bottomNavigationKey,
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
