import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:skeleton_text/skeleton_text.dart';

import 'package:sufismart/model/branch_model.dart';
import 'package:sufismart/model/news_model.dart';
import 'package:sufismart/model/news_model_new.dart';
import 'package:sufismart/model/product_category_model.dart';
import 'package:sufismart/model/product_list_model.dart';
import 'package:sufismart/model/product_type_model.dart';
import 'package:sufismart/util/system.dart';
import 'package:url_launcher/url_launcher.dart';

class BasicComponent {
  static AppBar appBar({
    List<Widget>? actions,
  }) {
    return AppBar(
      centerTitle:false,
      backgroundColor: System.data.color!.mainColor,
      title: Image.asset(
        "assets/logo_sfi_white.png",
        fit: BoxFit.cover,
        height: 30,
      ),
      actions: actions,
    );
  }

  static Future<void> opengooglemap(double lat, double lon) async {
    //final url = 'http://maps.google.com/maps?q=loc:${lat},${lon}(${tag})';
    final url = 'https://www.google.com/maps/search/?api=1&query=$lat,$lon';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  static Widget newsImageContainer2(NewsModelNew news) {
    return CachedNetworkImage(
      imageUrl: news.imagepath ?? "",
      imageBuilder: (context, imageProvider) => SizedBox(
        height: MediaQuery.of(context).size.height / 2,
        //width: MediaQuery.of(context).size.width,
        child: Container(
          margin: const EdgeInsets.only(bottom: 10.0),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
            image: DecorationImage(image: imageProvider, fit: BoxFit.fill),
          ),
        ),
      ),
      placeholder: (context, url) => SkeletonAnimation(
          child: Container(
        height: MediaQuery.of(context).size.height / 2,
        decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: const BorderRadius.all(Radius.circular(5))),
      )),
      errorWidget: (context, url, error) => Container(
        height: MediaQuery.of(context).size.height / 2,
        decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: const BorderRadius.all(Radius.circular(5))),
        child: const Center(
          child: Icon(Icons.error),
        ),
      ),
    );
  }

  static Widget newsImageContainer(NewsModel news) {
    return CachedNetworkImage(
      imageUrl: news.imagepath ?? "",
      imageBuilder: (context, imageProvider) => SizedBox(
        height: MediaQuery.of(context).size.height / 2,
        child: Card(
          margin: const EdgeInsets.only(bottom: 10.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              image: DecorationImage(image: imageProvider, fit: BoxFit.fill),
            ),
          ),
        ),
      ),
      placeholder: (context, url) => SkeletonAnimation(
          child: Container(
        height: MediaQuery.of(context).size.height / 2,
        decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: const BorderRadius.all(Radius.circular(5))),
      )),
      errorWidget: (context, url, error) => Container(
        height: MediaQuery.of(context).size.height / 2,
        decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: const BorderRadius.all(Radius.circular(5))),
        child: const Center(
          child: Icon(Icons.error),
        ),
      ),
    );
  }

  static Widget productCategoryImageContainer(ProductCategoryModel prodCat) {
    return Card(
      child: Row(
        children: [
          // prodCat.categoryimage == null
          //     ? Container(
          //         width: 110,
          //         height: 110,
          //         decoration: const BoxDecoration(
          //           borderRadius: BorderRadius.all(Radius.circular(5)),
          //           image: DecorationImage(
          //               image: AssetImage("assets/images/image_default.jpg"),
          //               fit: BoxFit.fill),
          //         ),
          //       )
          //     :
          CachedNetworkImage(
            imageUrl: prodCat.categoryimage ?? "",
            imageBuilder: (context, imageProvider) => Container(
              margin: const EdgeInsets.all(0),
              width: 110,
              height: 115,              
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                  image:
                      DecorationImage(image: imageProvider, fit: BoxFit.fill),
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
          const SizedBox(
            height: 5,
          ),
          Container(
            padding: const EdgeInsets.all(0),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(5),
                  width: MediaQuery.of(System.data.context).size.width * 0.60,
                  //width: 220,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        prodCat.categoryname ?? "",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: System.data.color!.mainColor),
                        maxLines: 2,
                        textAlign: TextAlign.justify,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Icon(FontAwesomeIcons.chevronCircleRight,
                          color: System.data.color!.mainColor),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget productListImage(ProductListModel pm) {
    return Card(
      child: Column(
        children: <Widget>[
          CachedNetworkImage(
            imageUrl: pm.productimage ?? "",
            imageBuilder: (context, imageProvider) => Container(
              //height: MediaQuery.of(context).size.height / 4,
              //height: 190,
              width: MediaQuery.of(context).size.width,
              height: 190,
              margin: const EdgeInsets.only(bottom: 5.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                  image:
                      DecorationImage(image: imageProvider, fit: BoxFit.fill),
                ),
              ),
            ),
            placeholder: (context, url) => SkeletonAnimation(
                child: Container(
              //height: MediaQuery.of(context).size.height / 4,
              //height: 190,
              width: MediaQuery.of(context).size.width,
              height: 190,
              margin: const EdgeInsets.only(bottom: 5.0),
              decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: const BorderRadius.all(Radius.circular(5))),
            )),
            errorWidget: (context, url, error) => Container(
              //height: MediaQuery.of(context).size.height / 4,
              //height: 190,
              width: MediaQuery.of(context).size.width,
              height: 190,
              margin: const EdgeInsets.only(bottom: 5.0),
              decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: const BorderRadius.all(Radius.circular(5))),
              child: const Center(
                child: Icon(Icons.error),
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Container(
            //text kepanjangan jadi titik-titik
            width: MediaQuery.of(System.data.context).size.width,
            padding: const EdgeInsets.only(left: 10.0, bottom: 5.0),
            child: Text(
              pm.productname ?? "",
              style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[900]),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Container(
            //text kepanjangan jadi titik-titik
            width: MediaQuery.of(System.data.context).size.width,
            padding: const EdgeInsets.only(
                top: 0.0, bottom: 10.0, right: 10.0, left: 10.0),
            // child: Text(
            //   model.productList[index].productCategory,
            //   style: TextStyle(
            //       fontSize: 14,
            //       fontWeight: FontWeight.bold,
            //       color: Colors.black38
            //   ),
            //   maxLines: 2,
            //   overflow: TextOverflow.ellipsis,
            // ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(0),
                  child: Text(
                    System.data.strings!.startFrom,
                    style: const TextStyle(
                        color: Colors.black38,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                // Expanded(
                //   flex: 1,
                //    child: Align(
                //      alignment: Alignment.topRight,
                //      child:Container(
                //       padding: EdgeInsets.all(5),
                //       child: Text(
                //       "Dimulai Dari "+model.productList[index].productPrice,
                //       style: TextStyle(
                //           color: Colors.black38,
                //           fontSize: 16,
                //           fontWeight: FontWeight.bold),
                //     ),
                //      )

                //    ),
                // ),
                Container(
                  color: Colors.transparent,
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                        padding: const EdgeInsets.all(5),
                        // decoration: BoxDecoration(
                        //     color: Color(0xff0d306b),
                        //     borderRadius: BorderRadius.all(
                        //         Radius.circular(20))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            // Text(
                            //   System.data.strings!.startFrom,
                            //   style:
                            //       TextStyle(color: Colors.black, fontSize: 15),
                            //   textAlign: TextAlign.center,
                            // ),
                            Text(
                              pm.productprice ?? "",
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        )),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget priceListProduct(ProductTypeModel pm) {
    return Card(
      child: Column(
        children: <Widget>[
          Container(
            //text kepanjangan jadi titik-titik
            width: MediaQuery.of(System.data.context).size.width,
            padding: const EdgeInsets.only(
                top: 10.0, bottom: 10.0, right: 5.0, left: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(
                  child: Container(
                    padding: const EdgeInsets.only(right: 5, left: 5),
                    child: Text(
                      pm.productDetailName ?? "",
                      style: TextStyle(
                        color: System.data.color?.mainColor,
                        fontSize: 13,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(5),
                  child: Text(
                    "Rp. "
                    "${pm.productDetailPrice ?? ""}",
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget listBranchpage(BranchModel pm) {
    return Card(
      child: GestureDetector(
        onTap: () {
          var lat = double.parse(pm.lat ?? "");
          var lng = double.parse(pm.lng ?? "");
          opengooglemap(lat, lng);
        },
        child: Container(
          width: MediaQuery.of(System.data.context).size.width,
          padding:
              const EdgeInsets.only(top: 10, right: 10, left: 10, bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                pm.officename ?? "",
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                    fontSize: 14),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                pm.addr ?? "",
                style: const TextStyle(
                  //fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 12,
                ),
              ),
              Container(
                width: MediaQuery.of(System.data.context).size.width,
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 5),
                          child: Icon(
                            Icons.location_on_outlined,
                            color: System.data.color?.mainColor,
                            size: 15,
                          ),
                        ),
                        Text(
                          "${pm.jarak} Km",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: System.data.color?.mainColor,
                              fontSize: 12),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          System.data.strings?.viewLocation ?? "",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: System.data.color?.mainColor,
                              fontSize: 12),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Icon(
                          FontAwesomeIcons.chevronCircleRight,
                          color: System.data.color?.mainColor,
                          size: 12,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
