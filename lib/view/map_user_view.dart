import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:skeleton_text/skeleton_text.dart';
import 'package:sufismart/component/cilcular_loader_component.dart';
import 'package:sufismart/model/customer_model.dart';
import 'package:sufismart/model/position_model.dart';
import 'package:sufismart/util/system.dart';
import 'package:sufismart/view_model/map_user_view_model.dart';

class MapUserView extends StatefulWidget {
  final ValueChanged<CustomerModel?>? onTapMarker;

  const MapUserView({
    Key? key,
    this.onTapMarker,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MapUserViewState();
  }
}

class _MapUserViewState extends State<MapUserView> {
  MapUserViewModel mapUserViewModel = MapUserViewModel();

  @override
  void initState() {
    super.initState();
    mapUserViewModel.onTapMarker = onTapMarker;
    mapUserViewModel.loadLocation();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: mapUserViewModel,
      child: Scaffold(
        body: CircularLoaderComponent(
          controller: mapUserViewModel.loaderController,
          child: mapWidget(),
        ),
      ),
    );
  }

  Widget mapWidget() {
    return Consumer<MapUserViewModel>(
      builder: (c, d, w) {
        return GoogleMap(
          mapType: MapType.hybrid,
          initialCameraPosition: d.cameraPosition,
          onMapCreated: (controller) {
            d.mapController = controller;
          },
          markers: d.markers.toSet(),
        );
      },
    );
  }

  void onTapMarker(PositionModel positionModel) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return Container(
          height: 300,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          child: FutureBuilder<CustomerModel?>(
            future: mapUserViewModel.getCustomerInfo(
              id: positionModel.ref?.split("-")[1],
            ),
            builder: (ctx, snap) {
              if (snap.hasData) {
                return Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(15),
                      color: Colors.transparent,
                      child: Center(
                        child: Container(
                          color: Colors.transparent,
                          height: 80,
                          width: 80,
                          child: ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(50)),
                            child: Image.network(
                              snap.data?.imageUrl ?? "",
                              fit: BoxFit.cover,
                              errorBuilder: (bb, o, st) => Container(
                                color: Colors.transparent,
                                child: Image.asset("assets/avatar.jpeg"),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        snap.data?.fullName ?? "",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        child: ListView(
                          children: [
                            item(
                              title: System.data.strings!.username,
                              value: snap.data?.username,
                            ),
                            item(
                              title: System.data.strings!.phoneNumber,
                              value: snap.data?.username,
                            ),
                          ],
                        ),
                      ),
                    ),
                    bottonSendMessage(snap.data),
                  ],
                );
              } else {
                return SkeletonAnimation(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: const BorderRadius.all(
                        Radius.circular(5),
                      ),
                    ),
                  ),
                );
              }
            },
          ),
        );
      },
    );
  }

  Widget item({
    String? title,
    String? value,
  }) {
    return Container(
      height: 20,
      width: double.infinity,
      color: Colors.transparent,
      margin: const EdgeInsets.only(bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title ?? "title",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(value ?? "value"),
        ],
      ),
    );
  }

  Widget bottonSendMessage(CustomerModel? customer) {
    return Container(
      margin: const EdgeInsets.all(15),
      color: Colors.transparent,
      height: 40,
      width: double.infinity,
      child: ElevatedButton(
        style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all(System.data.color!.primaryColor)),
        onPressed: () {
          Navigator.of(context).pop();
          widget.onTapMarker!(customer);
        },
        child: Text(System.data.strings!.sendMessage),
      ),
    );
  }
}
