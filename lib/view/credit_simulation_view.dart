import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sufismart/component/basic_component.dart';
import 'package:sufismart/view_model/credit_simulation_view_model.dart';
import 'package:sufismart/util/system.dart';
import 'package:flutter/services.dart';

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
                          fontWeight: FontWeight.normal,
                          wordSpacing: 2),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    loanType(),
                    creditSimulationViewModel.loanType == null
                        ? const SizedBox()
                        : Column(
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              area(),
                              const SizedBox(
                                height: 20,
                              ),
                              price(),
                              creditSimulationViewModel.loanType?.id != 2
                                  ? const SizedBox()
                                  : Column(
                                      children: [
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        insuranceType(),
                                      ],
                                    ),
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
                          )
                  ],
                ),
              );
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
      height: 60,
      color: Colors.amber,
    );
  }

  Widget area() {
    return Container(
      width: double.infinity,
      height: 60,
      color: Colors.amber,
    );
  }

  Widget price() {
    return Container(
      width: double.infinity,
      height: 60,
      color: Colors.amber,
    );
  }

  Widget insuranceType() {
    return Container(
      width: double.infinity,
      height: 60,
      color: Colors.amber,
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
      height: 60,
      color: Colors.amber,
    );
  }
}
