import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skeleton_text/skeleton_text.dart';
import 'package:sufismart/component/basic_component.dart';
import 'package:sufismart/component/circular_loader_component.dart';
import 'package:sufismart/model/merchant_model.dart';
import 'package:sufismart/util/mode_util.dart';
import 'package:sufismart/util/system.dart';
import 'package:sufismart/view_model/merchant_view_model.dart';

class MerchantDetailView extends StatefulWidget {
  final MerchantModel? merchantModel;
  const MerchantDetailView({
    Key? key,
    this.merchantModel,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MerchantDetailView();
  }
}

class _MerchantDetailView extends State<MerchantDetailView> {
  MerchantViewModel merchantViewModel = MerchantViewModel();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: merchantViewModel,
      child: Scaffold(
        appBar: BasicComponent.appBar(),
        body: CircularLoaderComponent(
          controller: merchantViewModel.loadingController,
          child: SingleChildScrollView(
            child: Consumer<MerchantViewModel>(
              builder: (c, d, w) {
                return Container(
                  padding: const EdgeInsets.all(3),
                  child: Column(
                    children: [
                      Card(
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              child: CachedNetworkImage(
                                imageUrl: widget.merchantModel?.img ?? "",
                                imageBuilder: (context, imageProvider) => Container(
                                  //height: MediaQuery.of(context).size.height / 4,
                                  //height: 200,
                                  color: Colors.transparent,
                                  width: MediaQuery.of(context).size.width,
                                  height: 200,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(5)),
                                      image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.contain),
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
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10))),
                                )),
                                errorWidget: (context, url, error) => Container(
                                  //height: MediaQuery.of(context).size.height / 4,
                                  //height: 200,
                                  width: MediaQuery.of(context).size.width,
                                  height: 200,
                                  decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(5))),
                                  child: const Center(
                                    child: Icon(Icons.error),
                                  ),
                                ),
                              ),
                            ),
                            
                          ],
                        ),
                      ),
                      Card(
                        child: Column(
                          children: <Widget>[
                            Container(
                              //text kepanjangan jadi titik-titik
                              width:
                                  MediaQuery.of(System.data.context).size.width,
                              padding: const EdgeInsets.only(
                                  top: 15.0,
                                  bottom: 10.0,
                                  right: 3.0,
                                  left: 3.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Flexible(
                                    child: Container(
                                      padding: const EdgeInsets.only(
                                          right: 5, left: 5),
                                      child: Text(
                                        widget.merchantModel?.namaproduk ?? "",
                                        style: TextStyle(
                                            color: System.data.color?.mainColor,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      color: System.data.color?.primaryColor,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Text(
                                      widget.merchantModel?.point ?? "",
                                      style: TextStyle(
                                        color: System.data.color?.whiteColor,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Form(
                        key: merchantViewModel.formKeyContact,
                        autovalidateMode: AutovalidateMode.always,
                        child: Container(
                          color: Colors.transparent,
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(3),
                                child: Column(
                                  children: [
                                    address(),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    note(),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                margin: const EdgeInsets.only(
                                    top: 5.0,
                                    left: 10.0,
                                    right: 10.0,
                                    bottom: 10.0),
                                child: Text(
                                  System.data.strings?.tujuanalamat ?? "",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: System.data.color?.mainColor,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              buttonSubmit()
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ),
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

  Widget address() {
    return TextFormField(
      controller: merchantViewModel.alamatTextController,
      autofocus: false,
      minLines: 1,
      maxLines: 5, // allow user to enter 5 line in textfield
      keyboardType: TextInputType.multiline,
      decoration: InputDecoration(
        labelText: System.data.strings!.inputalamat,
        labelStyle: const TextStyle(
          color: Colors.grey,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: System.data.color!.primaryColor),
          borderRadius: BorderRadius.circular(5.5),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        prefixIcon: Icon(
          Icons.phone,
          color: System.data.color?.primaryColor,
        ),
        filled: true,
        fillColor: System.data.color?.whiteSmoke,
      ),
      cursorColor: Colors.grey,
      validator: (String? value) {
        if (value!.isEmpty) {
          return (System.data.strings!.phoneNumber) +
              (" " + System.data.strings!.canNotBeEmpty);
        }
        return null;
      },
      onSaved: (String? value) {
        merchantViewModel.alamat = value!;
      },
    );
  }

  Widget note() {
    return TextFormField(
      controller: merchantViewModel.noteTextController,
      autofocus: false,
      minLines: 1,
      maxLines: 5, // allow user to enter 5 line in textfield
      keyboardType: TextInputType.multiline,
      decoration: InputDecoration(
        labelText: System.data.strings!.note,
        labelStyle: const TextStyle(
          color: Colors.grey,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: System.data.color!.primaryColor),
          borderRadius: BorderRadius.circular(5.5),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        prefixIcon: Icon(
          Icons.note_alt,
          color: System.data.color?.primaryColor,
        ),
        filled: true,
        fillColor: System.data.color?.whiteSmoke,
      ),
      cursorColor: Colors.grey,
      onSaved: (String? value) {
        merchantViewModel.note = value!;
      },
    );
  }

  Widget buttonSubmit() {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
        if (merchantViewModel.formKeyContact.currentState!.validate()) {
          // ModeUtil.debugPrint(
          //     "homeViewModel.formKeyContact.currentState ${registerViewModel.formKeyContact.currentState}");
          ModeUtil.debugPrint("masuk");
          // registerViewModel.sendRegistrasi(
          //   onRegisterSuccess: widget.onRegisterSucces,
          // );
          //merchantViewModel.submitRedeemPoint(widget.merchantModel?.merchantid);

          showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              content: Text(
                System.data.strings!.validateRedeem ,
              ),
              actions: [
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          System.data.color!.primaryColor)),
                  onPressed: () {
                    Navigator.pop(context);                    
                  }, // function used to perform after pressing the button
                  child: const Text('No'),
                ),
                ElevatedButton(
                  onPressed: () {                    
                    Navigator.pop(context);                    
                    //widget.goTologout!();
                    merchantViewModel.submitRedeemPoint(widget.merchantModel?.merchantid);
                  },
                  child: const Text('Yes'),
                ),
              ],
            ),
          );
        }
      },
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
            color: System.data.color!.primaryColor,
            borderRadius: const BorderRadius.all(Radius.circular(5))),
        child: Center(
          child: Text(
            System.data.strings!.send,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
        ),
      ),
    );
  }
}
