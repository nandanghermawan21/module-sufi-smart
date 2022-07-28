import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skeleton_text/skeleton_text.dart';
import 'package:sufismart/component/basic_component.dart';
import 'package:sufismart/model/product_category_model.dart';
import 'package:sufismart/util/system.dart';
import 'package:sufismart/view_model/product_view_model.dart';

class ProductCategoryView extends StatefulWidget {
  final ValueChanged<ProductCategoryModel>? onTapCategoryitem;

  const ProductCategoryView({
    Key? key,
    this.onTapCategoryitem,
  }) : super(key: key);

  @override
  _ProductCategoryViewState createState() => _ProductCategoryViewState();
}

class _ProductCategoryViewState extends State<ProductCategoryView> {
  ProductViewModel productViewModel = ProductViewModel();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: productViewModel,
      child: Scaffold(
        appBar: appBar(),
        backgroundColor: System.data.color!.background,
        body: productPage(),
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

  Widget productPage() {
    return RefreshIndicator(
      triggerMode: RefreshIndicatorTriggerMode.anywhere,
      onRefresh: productViewModel.onRefreshHomePage,
      child: Container(
        padding: const EdgeInsets.all(5),
        child: SingleChildScrollView(
          child: FutureBuilder<List<ProductCategoryModel>>(
            future: productViewModel.allProductCategory,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: List.generate(snapshot.data?.length ?? 0, (index) {
                    return GestureDetector(
                      onTap: () {
                        widget.onTapCategoryitem!(snapshot.data![index]);
                      },
                      child: photos(snapshot.data![index]),
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
                          height: 120,
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
        ),
      ),
    );
  }

  // FutureBuilder<List<ProductCategoryModel>>(
  //           future: productViewModel.allProductCategory,
  //           builder: (context, snapshot) {
  //             if (snapshot.hasData) {
  //               return Column(
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 crossAxisAlignment: CrossAxisAlignment.center,
  //                 children: List.generate(snapshot.data?.length ?? 0, (index) {
  //                   return GestureDetector(
  //                     onTap: () {
  //                       //widget.gotoDetailNews!(snapshot.data![index]);
  //                     },
  //                     child: photos(snapshot.data![index]),
  //                   );
  //                 }),
  //               );
  //             } else {
  //               return Column(
  //                 children: List.generate(
  //                   5,
  //                   (index) {
  //                     return SkeletonAnimation(
  //                       child: Container(
  //                         width: MediaQuery.of(context).size.width,
  //                         height: 110,
  //                         margin: const EdgeInsets.all(5),
  //                         decoration: BoxDecoration(
  //                           color: Colors.grey[300],
  //                           borderRadius: const BorderRadius.all(
  //                             Radius.circular(5),
  //                           ),
  //                         ),
  //                       ),
  //                     );
  //                   },
  //                 ),
  //               );
  //             }
  //           },
  //         ),

  Widget photos(ProductCategoryModel pm) {
    double width = (MediaQuery.of(context).size.width - 10) >= 400
        ? 400
        : MediaQuery.of(context).size.width - 10;
    return Container(
        margin: const EdgeInsets.only(bottom: 0),
        width: width,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: BasicComponent.productCategoryImageContainer(pm),
        ));
  }
}
