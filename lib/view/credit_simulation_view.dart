import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sufismart/component/basic_component.dart';
import 'package:sufismart/view_model/credit_simulation_view_model.dart';
import 'package:sufismart/util/system.dart';
import 'package:sufismart/model/loan_type_model.dart';
import 'package:sufismart/model/area_type_model.dart';

class CreditSimulationView extends StatefulWidget {
  const CreditSimulationView({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CreditSimulationViewState();
  }
}

class _CreditSimulationViewState extends State<CreditSimulationView> {
  CreditSimulationViewModel creditSimulationViewModel =
      CreditSimulationViewModel();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: creditSimulationViewModel,
      child: Scaffold(
        appBar: BasicComponent.appBar(),
        body: SingleChildScrollView(
          child: Consumer<CreditSimulationViewModel>(
            builder: (c, d, w) {
              return Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        System.data.strings!.creditSimulation
                            .replaceAll("\n", " "),
                        style: TextStyle(
                          fontSize: 20,
                          color: System.data.color!.primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        System.data.strings!
                            .pleaseDoACreditSimulationUsingTheFormBelow
                            .replaceAll("\n", " "),
                        style: TextStyle(
                            fontSize: 15,
                            color: System.data.color!.primaryColor,
                            fontWeight: FontWeight.normal,
                            wordSpacing: 2),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      loanType(),
                      const SizedBox(
                        height: 20,
                      ),
                      area(),
                      const SizedBox(
                        height: 20,
                      ),
                      price(),
                      const SizedBox(
                        height: 20,
                      ),
                      insuranceType(),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: Container(
                            child: dpAmount(),
                          )),
                          const SizedBox(
                            width: 30,
                          ),
                          Container(
                            width: 100,
                            color: Colors.transparent,
                            child: dpPercentage(),
                          )
                        ],
                      )
                    ],
                  ));
            },
          ),
        ),
        bottomNavigationBar: Container(
          margin: const EdgeInsets.all(15),
          color: Colors.transparent,
          height: 50,
          child: ElevatedButton(
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(System.data.color!.primaryColor)),
            onPressed: () {},
            child: Text(System.data.strings!.calculate),
          ),
        ),
      ),
    );
  }

  Widget loanType() {
    return Container(
      width: double.infinity,
      color: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            System.data.strings!.loanType,
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(creditSimulationViewModel.loanTypes.length,
                (index) {
              return Expanded(
                child: Row(
                  children: [
                    Radio<LoanTypeModel>(
                      value: creditSimulationViewModel.loanTypes[index],
                      onChanged: (val) {
                        creditSimulationViewModel.loanType =
                            creditSimulationViewModel.loanTypes[index];
                      },
                      activeColor: System.data.color!.primaryColor,
                      groupValue: creditSimulationViewModel.loanType,
                    ),
                    Expanded(
                      child: Container(
                          width: double.infinity,
                          height: 15,
                          color: Colors.transparent,
                          child: FittedBox(
                            child: Text(creditSimulationViewModel
                                    .loanTypes[index].name ??
                                ""),
                          )),
                    ),
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget area() {
    return Container(
      width: double.infinity,
      color: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            System.data.strings!.area,
          ),
          const SizedBox(
            height: 10,
          ),
          DropdownButton<AreaModel>(
            underline: Container(
              height: 1,
              color: System.data.color!.primaryColor,
            ),
            isExpanded: true,
            hint: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  System.data.strings!.chooseArea,
                ),
              ],
            ),
            value: creditSimulationViewModel.area,
            items:
                List.generate(creditSimulationViewModel.areas.length, (index) {
              return DropdownMenuItem<AreaModel>(
                  value: creditSimulationViewModel.areas[index],
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(creditSimulationViewModel.areas[index].name ?? ""),
                    ],
                  ));
            }),
            onChanged: (area) {
              creditSimulationViewModel.area = area;
            },
          )
        ],
      ),
    );
  }

  Widget price() {
    return Container(
      width: double.infinity,
      color: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            System.data.strings!.price,
          ),
          const SizedBox(
            height: 0,
          ),
          TextField(
            controller: creditSimulationViewModel.priceController,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp("[0-9]")),
              TextInputFormatter.withFunction(
                (oldValue, newValue) =>
                    creditSimulationViewModel.priceFormater(oldValue, newValue),
              ),
            ],
            onChanged: (val) {
              creditSimulationViewModel.price =
                  creditSimulationViewModel.parseDoubleFromString(val);
            },
            decoration: InputDecoration(
              hintText: "Rp.",
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    color: System.data.color!.primaryColor, width: 1.0),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    color: System.data.color!.primaryColor, width: 1.0),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget insuranceType() {
    return Container(
      width: double.infinity,
      color: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            System.data.strings!.insuranceType,
          ),
          const SizedBox(
            height: 0,
          ),
          Row(
            children: List.generate(
                creditSimulationViewModel.insuranceTypes.length, (index) {
              return Expanded(
                child: Row(
                  children: [
                    Checkbox(
                      value: creditSimulationViewModel.insuranceTypeIsCheked(
                          creditSimulationViewModel.insuranceTypes[index]),
                      onChanged: (val) {
                        if (val == true) {
                          creditSimulationViewModel.addInsuranceType(
                              creditSimulationViewModel.insuranceTypes[index]);
                        } else {
                          creditSimulationViewModel.removeInsuranceType(
                              creditSimulationViewModel.insuranceTypes[index]);
                        }
                      },
                    ),
                    Expanded(
                      child: Container(
                        height: 15,
                        alignment: Alignment.centerLeft,
                        color: Colors.transparent,
                        child: FittedBox(
                          child: Text(creditSimulationViewModel
                                  .insuranceTypes[index].name ??
                              ""),
                        ),
                      ),
                    )
                  ],
                ),
              );
            }),
          )
        ],
      ),
    );
  }

  Widget dpAmount() {
    return Container(
      width: double.infinity,
      color: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            System.data.strings!.dpAmount,
          ),
          const SizedBox(
            height: 0,
          ),
          TextField(
            controller: creditSimulationViewModel.dpAmountController,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp("[0-9]")),
              TextInputFormatter.withFunction((oldValue, newValue) =>
                  creditSimulationViewModel.downPaymentAmountFormater(
                      oldValue, newValue))
            ],
            onChanged: (val) {
              creditSimulationViewModel.dpAmount =
                  creditSimulationViewModel.parseDoubleFromString(val);
            },
            decoration: InputDecoration(
              hintText: "Rp.",
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    color: System.data.color!.primaryColor, width: 1.0),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    color: System.data.color!.primaryColor, width: 1.0),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget dpPercentage() {
    return Container(
      width: double.infinity,
      color: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            System.data.strings!.min10percent,
          ),
          const SizedBox(
            height: 0,
          ),
          TextField(
            controller:
                creditSimulationViewModel.downPaymentPercentageController,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp("[0-9]")),
              TextInputFormatter.withFunction(
                (oldValue, newValue) => creditSimulationViewModel
                    .downPaymentPercentageFormater(oldValue, newValue),
              ),
            ],
            onChanged: (val) {
              creditSimulationViewModel.dpPercent =
                  creditSimulationViewModel.parseDoubleFromString(val);
            },
            decoration: InputDecoration(
              hintText: "DP %",
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    color: System.data.color!.primaryColor, width: 1.0),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    color: System.data.color!.primaryColor, width: 1.0),
              ),
            ),
          )
        ],
      ),
    );
  }
}
