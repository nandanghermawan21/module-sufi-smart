import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skeleton_text/skeleton_text.dart';
import 'package:sufismart/component/basic_component.dart';
import 'package:sufismart/model/merchant_model.dart';
import 'package:sufismart/util/mode_util.dart';
import 'package:sufismart/view_model/merchant_view_model.dart';

import '../util/system.dart';

class MerchantView extends StatefulWidget {
  final ValueChanged<MerchantModel>? onTapMerchantItems;
  const MerchantView({
    Key? key,
    this.onTapMerchantItems,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MerchantViewState();
  }
}

class _MerchantViewState extends State<MerchantView> {
  MerchantViewModel merchantViewModel = MerchantViewModel();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: merchantViewModel,
      child: Scaffold(
        appBar: BasicComponent.appBar(),
        backgroundColor: System.data.color!.background,
        body: pageListMerchantPoint(),
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      backgroundColor: System.data.color!.mainColor,
      title: Image.asset(
        "assets/logo_sfi_white.png",
        fit: BoxFit.cover,
        height: 30,
      ),
    );
  }

  Widget pageListMerchantPoint() {
    return Container(
      padding: const EdgeInsets.all(5),
      child: SingleChildScrollView(
        child: FutureBuilder<List<MerchantModel>?>(
          future: merchantViewModel.getListMerchantRedeem(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: List.generate(
                  snapshot.data?.length ?? 0,
                  (index) {
                    return GestureDetector(
                      onTap: () {
                        if (snapshot.data![index].claim == "1") {
                          ModeUtil.debugPrint("bisa claim");
                          widget.onTapMerchantItems!(snapshot.data![index]);
                        } else {
                          System.data.showmodal(
                              System.data.strings?.pointtidakcukup,
                              "Announcement");
                        }
                      },
                      child: listMerchantPoint2(snapshot.data![index]),
                    );
                  },
                ),
              );
            } else {
              return Column(
                children: List.generate(
                  6,
                  (index) {
                    return SkeletonAnimation(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 130,
                        margin: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: const BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Widget listMerchantPoint2(MerchantModel model) {
    return Card(
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: SizedBox(
              child: CachedNetworkImage(
                imageUrl: model.img ?? "",
                imageBuilder: (context, imageProvider) => Container(
                  width: 110,
                  height: 115,                  
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      image: DecorationImage(
                          image: imageProvider, fit: BoxFit.contain),
                    ),
                  ),
                ),
                placeholder: (context, url) => SkeletonAnimation(
                    child: Container(
                  //height: MediaQuery.of(context).size.height / 2,
                  width: 110,
                  height: 115,
                  
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: const BorderRadius.all(Radius.circular(5))),
                )),
                errorWidget: (context, url, error) => Container(
                  width: 110,
                  height: 115,                  
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: const BorderRadius.all(Radius.circular(5))),
                  child: const Center(
                    child: Icon(Icons.error),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model.namaproduk ?? "",
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
                maxLines: 2,
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: model.claim == "1"
                      ? System.data.color?.primaryColor
                      : Colors.grey,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text.rich(
                  TextSpan(
                    text: model.point,
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: model.claim == "1"
                            ? System.data.color?.whiteColor
                            : Colors.white),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
