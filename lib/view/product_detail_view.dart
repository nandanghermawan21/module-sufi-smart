import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skeleton_text/skeleton_text.dart';
import 'package:sufismart/model/product_type_model.dart';
import 'package:sufismart/util/mode_util.dart';
import 'package:sufismart/util/system.dart';
import 'package:sufismart/view_model/product_detaill_view_model.dart';

import '../component/basic_component.dart';

class ProductDetailView extends StatefulWidget {
  final ProductTypeModel? productTypeModel;
  final ValueChanged<String>? ontapSimulatiCreditProduct;

  const ProductDetailView({
    Key? key,
    this.productTypeModel,
    this.ontapSimulatiCreditProduct,
  }) : super(key: key);

  @override
  _ProductDetailViewState createState() => _ProductDetailViewState();
}

class _ProductDetailViewState extends State<ProductDetailView> {
  ProductDetailViewModel productDetailViewModel = ProductDetailViewModel();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: productDetailViewModel,
      child: Scaffold(
        appBar: BasicComponent.appBar(),
        backgroundColor: System.data.color!.background,
        body: productDetailpage(),
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

  Widget productDetailpage() {
    return RefreshIndicator(
      triggerMode: RefreshIndicatorTriggerMode.anywhere,
      onRefresh: productDetailViewModel.onRefreshHomePage,
      child: Container(
        padding: const EdgeInsets.all(5),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Card(
                child: Column(
                  children: [
                    CachedNetworkImage(
                      imageUrl:
                          widget.productTypeModel?.productDetailImage ?? "",
                      imageBuilder: (context, imageProvider) => Container(
                        //height: MediaQuery.of(context).size.height / 4,
                        //height: 200,
                        color: Colors.transparent,
                        width: MediaQuery.of(context).size.width,
                        height: 200,
                        child: Card(
                          margin: const EdgeInsets.only(bottom: 5.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5)),
                              image: DecorationImage(
                                  image: imageProvider, fit: BoxFit.fill),
                            ),
                          ),
                        ),
                      ),
                      placeholder: (context, url) => SkeletonAnimation(
                          child: Container(
                        //height: MediaQuery.of(context).size.height / 4,
                        //height: 200,
                        width: MediaQuery.of(context).size.width,
                        height: 200,
                        decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10))),
                      )),
                      errorWidget: (context, url, error) => Container(
                        //height: MediaQuery.of(context).size.height / 4,
                        //height: 200,
                        width: MediaQuery.of(context).size.width,
                        height: 200,
                        decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5))),
                        child: const Center(
                          child: Icon(Icons.error),
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.only(
                          top: 10.0, left: 10.0, right: 10.0, bottom: 10.0),
                      child: Text(
                        widget.productTypeModel?.productDetailName ?? "",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: System.data.color?.mainColor),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        alignment: Alignment.topLeft,
                        //width: 150,
                        width: MediaQuery.of(context).size.width / 1,
                        margin: const EdgeInsets.only(
                            top: 5, left: 10.0, right: 10.0, bottom: 10.0),
                        padding: const EdgeInsets.only(
                            top: 5, left: 10.0, right: 10.0, bottom: 10.0),
                        decoration: const BoxDecoration(
                          color: Color(0xff0d306b),
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                        child: Container(
                          padding: const EdgeInsets.only(top: 5),
                          child: Column(
                            children: <Widget>[
                              Text(
                                "Rp. "
                                "${widget.productTypeModel?.productDetailPrice ?? ""}",
                                style: const TextStyle(
                                    fontSize: 20, color: Colors.white),
                                textAlign: TextAlign.left,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.only(
                          top: 5.0, left: 10.0, right: 10.0, bottom: 10.0),
                      child: Text(
                        //"* Harga sewaktu-waktu dapat berubah tanpa pemberitahuan terlebih dahulu",
                        System.data.strings?.noteProduct ?? "",
                        style: TextStyle(
                            fontSize: 14, color: System.data.color?.mainColor),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ],
                ),
              ),
              Card(
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.only(
                          top: 20.0, left: 10.0, right: 10.0, bottom: 10.0),
                      child: Text(
                        System.data.strings?.description ?? "",
                        style: TextStyle(
                          fontSize: 20,
                          color: System.data.color?.mainColor,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.only(
                          top: 5.0, left: 10.0, right: 10.0, bottom: 10.0),
                      child: Text(
                        System.data.strings?.descriptionLink ?? "",
                        style: TextStyle(
                          fontSize: 13,
                          color: System.data.color?.mainColor,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  String? strUserid =
                      System.data.global.customerNewModel?.userid;

                  //ModeUtil.debugPrint(strUserid!);
                  if (strUserid == null) {
                    ModeUtil.debugPrint("user id kosong");
                    widget.ontapSimulatiCreditProduct!(
                        "https://sufismart.sfi.co.id/sufismart/api/credit_simulation_sufismart.php?prod_code=${widget.productTypeModel?.productCode}&detail_code=${widget.productTypeModel?.productDetailCode}&userid="
                        "");
                  } else {
                    widget.ontapSimulatiCreditProduct!(
                        "https://sufismart.sfi.co.id/sufismart/api/credit_simulation_sufismart.php?prod_code=${widget.productTypeModel?.productCode}&detail_code=${widget.productTypeModel?.productDetailCode}&userid=" +
                            strUserid);
                    ModeUtil.debugPrint(
                        "${System.data.global.customerNewModel?.userid}");
                  }

                  //
                },
                child: Card(
                  color: System.data.color?.mainColor,
                  margin: const EdgeInsets.only(left: 20, top: 5, right: 3),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            margin: const EdgeInsets.only(
                                top: 20.0,
                                left: 10.0,
                                right: 10.0,
                                bottom: 10.0),
                            child: Text(
                              System.data.strings?.hitungcreditSimulation ?? "",
                              style: const TextStyle(
                                  fontSize: 20, color: Colors.white),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                                top: 20.0,
                                left: 10.0,
                                right: 10.0,
                                bottom: 10.0),
                            // child: Text(
                            //   ">",
                            //   style:
                            //       TextStyle(fontSize: 20, color: Colors.black),
                            //   textAlign: TextAlign.left,
                            // ),
                            child: const Icon(Icons.arrow_forward_ios,
                                color: Colors.white),
                          ),
                        ],
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.only(
                            top: 5.0, left: 10.0, right: 10.0, bottom: 10.0),
                        child: Text(
                          System.data.strings?.hitungCicilan ?? "",
                          style: const TextStyle(
                              fontSize: 18, color: Colors.white),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
