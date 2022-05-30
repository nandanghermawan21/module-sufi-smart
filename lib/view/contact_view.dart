import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sufismart/component/circular_loader_component.dart';
import 'package:sufismart/util/mode_util.dart';
import 'package:sufismart/util/system.dart';
import 'package:sufismart/view_model/contact_view_model.dart';

class ContactView extends StatefulWidget {
  const ContactView({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ContactViewState();
  }
}

class _ContactViewState extends State<ContactView> {
  ContactViewModel contactViewModel = ContactViewModel();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: contactViewModel,
      child: CircularLoaderComponent(
        controller: contactViewModel.circularLoaderController,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: SingleChildScrollView(child: Consumer<ContactViewModel>(
            builder: (c, d, w) {
              return Container(
                padding: const EdgeInsets.all(30),
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 5),
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        System.data.strings!.contactUs,
                        style: TextStyle(
                            color: System.data.color!.primaryColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        System.data.strings!
                            .pleaseFillInTheInformationBelowForComplaintsAndOtherServices,
                        style: TextStyle(
                          color: System.data.color!.primaryColor,
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Form(
                      key: contactViewModel.formKeyContact,
                      autovalidateMode: AutovalidateMode.always,
                      child: Container(
                        margin: const EdgeInsets.only(top: 20),
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          children: <Widget>[
                            TextFormField(
                              controller: contactViewModel
                                  .namaLengkapTextEditingController,
                              autofocus: false,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp("[a-z A-Z]")),
                              ],
                              decoration: InputDecoration(
                                  labelText: System.data.strings!.fullname,
                                  labelStyle: const TextStyle(
                                    color: Colors.grey,
                                  ),
                                  focusedBorder: const UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.grey))),
                              keyboardType: TextInputType.text,
                              cursorColor: Colors.grey,
                              validator: (String? value) {
                                if (value!.isEmpty) {
                                  return (System.data.strings!.fullname) +
                                      (" " + System.data.strings!.canNotBeEmpty);
                                }
                                return null;
                              },
                              onSaved: (String? value) {
                                contactViewModel.setName = value!;
                              },
                            ),
                            TextFormField(
                              controller:
                                  contactViewModel.notelpTextEditingController,
                              autofocus: false,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp("[0-9]")),
                              ],
                              decoration: InputDecoration(
                                  labelText: System.data.strings!.phoneNumber,
                                  labelStyle: const TextStyle(
                                    color: Colors.grey,
                                  ),
                                  focusedBorder: const UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.grey))),
                              keyboardType: TextInputType.number,
                              cursorColor: Colors.grey,
                              validator: (String? value) {
                                if (value!.isEmpty) {
                                  return (System.data.strings!.phoneNumber) +
                                      (" " + System.data.strings!.canNotBeEmpty);
                                } else if (value.length < 10) {
                                  return System
                                      .data.strings!.phoneNumberAtLeast8Digits;
                                } else if (value.length > 15) {
                                  return System
                                      .data.strings!.maximumPhoneNumber15Digits;
                                }
                                return null;
                              },
                              onSaved: (String? value) {
                                contactViewModel.setPhone = value!;
                              },
                            ),
                            TextFormField(
                              controller:
                                  contactViewModel.emailTextEditingController,
                              autofocus: false,
                              decoration: InputDecoration(
                                  labelText: System.data.strings!.email,
                                  labelStyle: const TextStyle(
                                    color: Colors.grey,
                                  ),
                                  focusedBorder: const UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.grey))),
                              keyboardType: TextInputType.emailAddress,
                              cursorColor: Colors.grey,
                              validator: (String? value) {
                                RegExp regex = RegExp(
                                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
                                if (value!.isEmpty) {
                                  return (System.data.strings!.email) +
                                      (" " + System.data.strings!.canNotBeEmpty);
                                } else if (!regex.hasMatch(value)) {
                                  return System.data.strings!.enterAValidEmail;
                                }
                                return null;
                              },
                              onSaved: (String? value) {
                                contactViewModel.setEmail = value!;
                              },
                            ),
                            TextFormField(
                              controller:
                                  contactViewModel.pesanTextEditingController,
                              decoration: InputDecoration(
                                  labelText: System.data.strings!.message,
                                  labelStyle: const TextStyle(
                                    color: Colors.grey,
                                  ),
                                  focusedBorder: const UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.grey))),
                              keyboardType: TextInputType.text,
                              cursorColor: Colors.grey,
                              validator: (String? value) {
                                if (value!.isEmpty) {
                                  return (System.data.strings!.message) +
                                      (" " + System.data.strings!.canNotBeEmpty);
                                }
                                return null;
                              },
                              onSaved: (String? value) {
                                contactViewModel.setMessage = value!;
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            GestureDetector(
                              onTap: () {
                                if (contactViewModel.formKeyContact.currentState!
                                    .validate()) {
                                  ModeUtil.debugPrint(
                                      "homeViewModel.formKeyContact.currentState ${contactViewModel.formKeyContact.currentState}");

                                  ModeUtil.debugPrint("masuk");
                                  contactViewModel.sendKeluhan();
                                }
                              },
                              child: Container(
                                height: 50,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: System.data.color!.primaryColor,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(5))),
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
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          )),
        ),
      ),
    );
  }
}
