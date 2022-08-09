import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skeleton_text/skeleton_text.dart';
import 'package:sufismart/component/basic_component.dart';
import 'package:sufismart/model/product_list_model.dart';
import 'package:sufismart/model/product_type_model.dart';
import 'package:sufismart/util/system.dart';
import 'package:sufismart/view_model/product_type_view_model.dart';

class ProductTypeView extends StatefulWidget {
  final ProductListModel? productListModel;
  final ValueChanged<ProductTypeModel>? onTapProductDetail;

  const ProductTypeView(
      {Key? key, this.productListModel, this.onTapProductDetail})
      : super(key: key);

  @override
  _ProductTypeViewState createState() => _ProductTypeViewState();
}

class _ProductTypeViewState extends State<ProductTypeView> {
  ProductTypeViewModel productTypeViewModel = ProductTypeViewModel();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: productTypeViewModel,
      child: Scaffold(
        appBar: BasicComponent.appBar(),
        backgroundColor: System.data.color!.background,
        body: productTypePage(),
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

  Widget productTypePage() {
    return RefreshIndicator(
      triggerMode: RefreshIndicatorTriggerMode.anywhere,
      onRefresh: productTypeViewModel.onRefreshHomePage,
      child: Container(
        padding: const EdgeInsets.all(5),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CachedNetworkImage(
                imageUrl: widget.productListModel?.productimage ?? "",
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
                  margin: const EdgeInsets.only(bottom: 5.0),
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
                  margin: const EdgeInsets.only(bottom: 5.0),
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: const BorderRadius.all(Radius.circular(5))),
                  child: const Center(
                    child: Icon(Icons.error),
                  ),
                ),
              ),
              Card(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.only(
                      top: 10.0, left: 10.0, right: 10.0, bottom: 10.0),
                  child: Text(
                    System.data.strings!.producttype,
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              FutureBuilder<List<ProductTypeModel>>(
                future: productTypeViewModel.getAllProductType(
                    productId: widget.productListModel?.productcode),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children:
                          List.generate(snapshot.data?.length ?? 0, (index) {
                        return GestureDetector(
                          onTap: () {
                            widget.onTapProductDetail!(snapshot.data![index]);
                          },
                          child: priceList(snapshot.data![index]),
                        );
                      }),
                    );
                  } else {
                    return Column(
                      children: List.generate(
                        6,
                        (index) {
                          return SkeletonAnimation(
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 50,
                              margin: const EdgeInsets.all(5),
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
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(
                    top: 10.0, left: 10.0, right: 10.0, bottom: 10.0),
                child: Text(
                  System.data.strings?.infoOtrJakarta ?? "",
                  style: TextStyle(
                      fontSize: 13, color: System.data.color?.mainColor),
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget priceList(ProductTypeModel pm) {
    double width = (MediaQuery.of(context).size.width - 10) >= 400
        ? 400
        : MediaQuery.of(context).size.width - 10;
    return Container(
      margin: const EdgeInsets.only(bottom: 0),
      width: width,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: BasicComponent.priceListProduct(pm),
      ),
    );
  }
}
