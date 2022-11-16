import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:skeleton_text/skeleton_text.dart';
import 'package:sufismart/model/aplikasi_model.dart';
import 'package:sufismart/util/mode_util.dart';
import 'package:sufismart/util/system.dart';
import 'package:sufismart/view_model/about_view_model.dart';

class AboutView extends StatefulWidget {
  final VoidCallback? onTapFaq;
  final VoidCallback? onTapWeb;
  final ValueChanged<String>? onTapWebview;
  const AboutView({
    Key? key,
    this.onTapFaq,
    this.onTapWeb,
    this.onTapWebview,
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
                          'assets/sufismart.png',
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
                            ),
                            snapshot.data?.versi !=
                                    System.data.strings!.versiapk
                                ? Text(
                                    System.data.strings!.latestversion,
                                    style: const TextStyle(
                                      color: Colors.red,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  )
                                : const SizedBox(),
                            rowsosmed(snapshot.data!)
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 30),
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
                                //widget.onTapWeb!();
                                aboutViewModel.openbrowser(
                                  Uri.parse("https://www.sfi.co.id"),
                                );
                              },
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 8),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      System.data.strings!.websitekami,
                                      style: TextStyle(
                                        color: System.data.color!.primaryColor,
                                        fontSize: 18,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                      "https://www.sfi.co.id",
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
                                ModeUtil.debugPrint(
                                    snapshot.data?.komunitas ?? "");
                                widget.onTapWebview!(
                                    snapshot.data?.komunitas ?? "");
                              },
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 8,right: 5),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,                                  
                                  children: <Widget>[
                                    Text(
                                      System.data.strings!.komunitas,
                                      style: TextStyle(
                                        color: System.data.color!.primaryColor,
                                        fontSize: 18,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    Icon(
                                      FontAwesomeIcons.users,
                                      color: System.data.color?.primaryColor,
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
                          'assets/sufismart.png',
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
                            ),
                            SkeletonAnimation(
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                margin: const EdgeInsets.only(top: 5),
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        color: Colors.transparent,
                        margin: const EdgeInsets.only(top: 30),
                        child: Column(
                          children: List.generate(
                            5,
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

  Widget rowsosmed(AplikasiModel model) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(top: 5),
      decoration: BoxDecoration(
        color: System.data.color!.whiteColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Container(
        color: Colors.transparent,
        child: Column(
          children: [
            Row(
              children: [
                menuSosmed(FontAwesomeIcons.instagram, Colors.pink[600],
                    model.instagram!),
                menuSosmed(FontAwesomeIcons.whatsapp, Colors.green,
                    "https://wa.me/${model.whatsapp!}?text=Hello"),
                menuSosmed(
                    FontAwesomeIcons.youtube, Colors.red, model.youtube!),
                menuSosmed(FontAwesomeIcons.twitter, Colors.blueAccent,
                    model.twitter!),
                menuSosmed(FontAwesomeIcons.facebook,
                    System.data.color!.primaryColor, model.facebook!),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget menuSosmed(IconData iconstr, colorChild, String? url) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          aboutViewModel.openbrowser(Uri.parse(url ?? ""));
        },
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  color: Colors.transparent,
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Icon(
                    iconstr,
                    size: 24,
                    color: colorChild,
                  ),
                ),
                const SizedBox(
                  width: 3,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
