import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skeleton_text/skeleton_text.dart';
import 'package:sufismart/model/product_category_model.dart';
import 'package:sufismart/model/product_list_model.dart';
import 'package:sufismart/util/system.dart';
import 'package:sufismart/view_model/product_list_view_model.dart';

import '../component/basic_component.dart';

class ProductListView extends StatefulWidget {
  final ProductCategoryModel? productCategoryModel;
  final ValueChanged<ProductListModel>? onTapProductItems;
  const ProductListView({
    Key? key,
    this.productCategoryModel,
    this.onTapProductItems,
  }) : super(key: key);

  @override
  _ProductListViewState createState() => _ProductListViewState();
}

class _ProductListViewState extends State<ProductListView> {
  ProductListViewModel productListViewModel = ProductListViewModel();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: productListViewModel,
      child: Scaffold(
        appBar: appBar(),
        backgroundColor: System.data.color!.background,
        body: productListPage(),
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

  Widget productListPage() {
    return RefreshIndicator(
      triggerMode: RefreshIndicatorTriggerMode.anywhere,
      onRefresh: productListViewModel.onRefreshHomePage,
      child: Container(
        padding: const EdgeInsets.all(5),
        child: SingleChildScrollView(
          child: FutureBuilder<List<ProductListModel>>(
            future: productListViewModel.getallProductList(
                categoryId: widget.productCategoryModel?.categorycode),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: List.generate(snapshot.data?.length ?? 0, (index) {
                    return GestureDetector(
                      onTap: () {
                        widget.onTapProductItems!(snapshot.data![index]);
                      },
                      child: prodListImage(snapshot.data![index]),
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
                          height: 250,
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

  Widget prodListImage(ProductListModel pm) {
    double width = (MediaQuery.of(context).size.width - 10) >= 400
        ? 400
        : MediaQuery.of(context).size.width - 10;
    return Container(
      margin: const EdgeInsets.only(bottom: 0),
      width: width,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: BasicComponent.productListImage(pm),
      ),
    );
  }
}

// child: Column(
//             children: List.generate(
//               6,
//               (index) {
//                 return SkeletonAnimation(
//                   child: Container(
//                     width: MediaQuery.of(context).size.width,
//                     height: 150,
//                     margin: const EdgeInsets.all(5),
//                     decoration: BoxDecoration(
//                       color: Colors.grey[300],
//                       borderRadius: const BorderRadius.all(
//                         Radius.circular(5),
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
