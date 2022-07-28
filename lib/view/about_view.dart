import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:skeleton_text/skeleton_text.dart';
import 'package:sufismart/model/aplikasi_model.dart';
import 'package:sufismart/util/system.dart';
import 'package:sufismart/view_model/about_view_model.dart';

class AboutView extends StatefulWidget {
  final VoidCallback? onTapFaq;
  const AboutView({
    Key? key,
    this.onTapFaq,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _AboutState();
  }
}

class _AboutState extends State<AboutView> {
  AboutViewModel aboutViewModel = AboutViewModel();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: FutureBuilder<AplikasiModel?>(
            future: aboutViewModel.getDataAplikasi,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Container(
                  margin: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        child: Image.asset(
                          'assets/logo_suzuki.png',
                          height: 100.0,
                          width: 100.0,
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.only(top: 20),
                        child: Column(
                          children: <Widget>[
                            Text(
                              System.data.strings!.appName,
                              style: TextStyle(
                                color: System.data.color!.primaryColor,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              System.data.strings!.version,
                              style: TextStyle(
                                color: System.data.color!.primaryColor,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 50),
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                aboutViewModel
                                    .openPhone(snapshot.data?.phone ?? "");
                              },
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 8),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      System.data.strings!.callCenter,
                                      style: TextStyle(
                                        color: System.data.color!.primaryColor,
                                        fontSize: 18,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                      snapshot.data?.phone ?? "",
                                      style: TextStyle(
                                        color: System.data.color!.primaryColor,
                                        fontSize: 18,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const Divider(),
                            GestureDetector(
                              onTap: () {
                                aboutViewModel
                                    .sendWhatsapp(snapshot.data?.phone ?? "");
                              },
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 8),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      System.data.strings!.whatsapp,
                                      style: TextStyle(
                                        color: System.data.color!.primaryColor,
                                        fontSize: 18,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                      snapshot.data?.phone ?? "",
                                      style: TextStyle(
                                        color: System.data.color!.primaryColor,
                                        fontSize: 18,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const Divider(),
                            GestureDetector(
                              onTap: () {
                                aboutViewModel
                                    .sendEmail(snapshot.data?.email ?? "");
                              },
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 8),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      System.data.strings!.email,
                                      style: TextStyle(
                                        color: System.data.color!.primaryColor,
                                        fontSize: 18,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                      snapshot.data?.email ?? "",
                                      style: TextStyle(
                                        color: System.data.color!.primaryColor,
                                        fontSize: 18,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const Divider(),
                            GestureDetector(
                              onTap: () {
                                widget.onTapFaq!();
                              },
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 8),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      System.data.strings!.faq,
                                      style: TextStyle(
                                        color: System.data.color!.primaryColor,
                                        fontSize: 18,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    Icon(
                                      FontAwesomeIcons.chevronRight,
                                      color: System.data.color?.primaryColor,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return Container(
                  color: Colors.transparent,
                  margin: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        child: Image.asset(
                          'assets/logo_suzuki.png',
                          height: 100.0,
                          width: 100.0,
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.only(top: 20),
                        child: Column(
                          children: <Widget>[
                            Text(
                              System.data.strings!.appName,
                              style: TextStyle(
                                color: System.data.color!.primaryColor,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              System.data.strings!.version,
                              style: TextStyle(
                                color: System.data.color!.primaryColor,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      ),
                      Container(
                        color: Colors.transparent,
                        margin: const EdgeInsets.only(top: 50),
                        child: Column(
                          children: List.generate(
                            4,
                            (index) {
                              return SkeletonAnimation(
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 30,
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
                        ),
                      )
                    ],
                  ),
                );
              }
            }),
      ),
    );
  }
}
