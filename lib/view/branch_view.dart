import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skeleton_text/skeleton_text.dart';
import 'package:sufismart/component/basic_component.dart';
import 'package:sufismart/component/circular_loader_component.dart';
import 'package:sufismart/model/kota_branch_model.dart';
import 'package:sufismart/util/system.dart';
import 'package:sufismart/view_model/branch_view_model.dart';
import 'package:http/http.dart' as http;

class BranchView extends StatefulWidget {
  const BranchView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _BranchViewState();
  }
}

class _BranchViewState extends State<BranchView> {
  BranchViewModel branchViewModel = BranchViewModel();

  @override
  void initState() {
    super.initState();
    //branchViewModel.ontapSearchBranch = onTapMarker;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BranchViewModel>.value(
      value: branchViewModel,
      builder: (c, w) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: BasicComponent.appBar(),
          body: CircularLoaderComponent(
            controller: branchViewModel.loadingController,
            child: Container(
              color: Colors.transparent,
              padding: const EdgeInsets.all(20),
              height: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    System.data.strings!.branchSfi,
                    style: TextStyle(
                      color: System.data.color!.primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  header(),
                  const Divider(),
                  Expanded(
                    child: pageBranch(),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget pageBranch() {
    return Container(
      color: Colors.transparent,
      child: Consumer<BranchViewModel>(
        builder: (c, d, w) {
          if (d.branchmodels.isEmpty) {
            return Container(
              color: Colors.transparent,
              child: const Center(
                child: Text(
                  "",
                ),
              ),
            );
          } else {
            return ListView.builder(
              itemCount: d.branchmodels.length,
              shrinkWrap: true,              
              itemBuilder: (context, index) {
                return BasicComponent.listBranchpage(d.branchmodels[index]);
              },
            );
          }
        },
      ),
    );
  }

  Widget header() {
    return Row(
      children: [
        Expanded(
          flex: 6,
          child: Container(
            padding: const EdgeInsets.only(right: 10, left: 10),
            decoration: const BoxDecoration(
              color: Color(0xFFEEEEEE),
              borderRadius: BorderRadius.all(
                Radius.circular(5),
              ),
            ),
            child: kotaFuture(),
          ),
        ),
        // Expanded(
        //   flex: 1,
        //   child: GestureDetector(
        //     onTap: () {
        //       branchViewModel.getBranchId();
        //     },
        //     child: Container(
        //       color: Colors.transparent,
        //       child: Icon(
        //         FontAwesomeIcons.search,
        //         color: System.data.color?.mainColor,
        //         size: 24,
        //       ),
        //     ),
        //   ),
        // )
      ],
    );
  }

  Widget kotaFuture() {
    return FutureBuilder<List<KotaBranchModel>>(
      future: branchViewModel.kotaBranch,
      initialData: const [],
      builder: (ctx, snap) {
        if (snap.hasData) {
          return listkota(snap.data ?? []);
        } else if (snap.hasError) {
          return Container(
            color: Colors.white,
            width: double.infinity,
            height: 50,
            child: Text(
              "can't load city : ${(snap.error as http.Response).body}",
              style: const TextStyle(color: Colors.red),
            ),
          );
        } else {
          return SkeletonAnimation(
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: const BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
            ),
          );
        }
      },
    );
  }

  Widget listkota(List<KotaBranchModel> kotaBranch) {
    return Consumer<BranchViewModel>(
      builder: (c, d, w) {
        return Container(
          width: double.infinity,
          height: 50,
          color: Colors.transparent,
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String?>(
              underline: Container(
                height: 1,
                color: System.data.color!.primaryColor,
              ),
              isExpanded: true,
              hint: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(System.data.strings?.cityBranch ?? ""),
                ],
              ),
              value: branchViewModel.kota?.kodekota,
              items: List.generate(kotaBranch.length, (index) {
                return DropdownMenuItem<String?>(
                  value: kotaBranch[index].kodekota,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        kotaBranch[index].namakota ?? "",
                        style: const TextStyle(fontSize: 13),
                      ),
                    ],
                  ),
                );
              }),
              onChanged: (branchKota) {
                branchViewModel.kota =
                    kotaBranch.where((e) => e.kodekota == branchKota).first;
              },
            ),
          ),
        );
      },
    );
  }
}
