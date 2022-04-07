import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: mapWidget(),
    );
  }

  Widget mapWidget() {
    return GoogleMap(
      mapType: MapType.hybrid,
      initialCameraPosition: mapUserViewModel.cameraPosition,
      onMapCreated: (GoogleMapController controller) {
        mapUserViewModel.mapController.complete(controller);
      },
    );
  }
}
