import 'dart:async';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapUserViewModel {
  Completer<GoogleMapController> mapController = Completer();
  CameraPosition cameraPosition = const CameraPosition(
    target: LatLng(-6.1857713, 106.9070565),
    zoom: 17,
  );
}
