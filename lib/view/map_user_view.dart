import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sufismart/component/cilcular_loader_component.dart';
import 'package:sufismart/view_model/map_user_view_model.dart';

class MapUserView extends StatefulWidget {
  const MapUserView({Key? key}) : super(key: key);

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
}
