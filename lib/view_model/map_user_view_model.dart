import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sufismart/component/cilcular_loader_component.dart';
import 'package:sufismart/model/position_model.dart';
import 'package:sufismart/util/error_handling_util.dart';

class MapUserViewModel extends ChangeNotifier {
  GoogleMapController? mapController;
  CircularLoaderController loaderController = CircularLoaderController();
  List<PositionModel> positions = [];
  List<Marker> markers = [];
  CameraPosition cameraPosition = const CameraPosition(
    target: LatLng(-6.1857713, 106.9070565),
    zoom: 17,
  );

  void commit() {
    notifyListeners();
  }

  void loadLocation({
    bool withLoadingIndicator = true,
    bool animateCamera = true,
  }) {
    if (withLoadingIndicator) loaderController.startLoading();
    PositionModel.load(
      filter: "CUSTPOS-%",
    ).then(
      (value) {
        loaderController.forceStop();
        positions = value;
        createMarkers(
          animateCamera: animateCamera,
        );
        createMarkersLabel();
      },
    ).catchError((onError) {
      if (withLoadingIndicator) {
        loaderController.stopLoading(
            isError: true, message: ErrorHandlingUtil.handleApiError(onError));
      }
    }).whenComplete(
      () {
        loadLocation(
          withLoadingIndicator: false,
          animateCamera: false,
        );
      },
    );
  }

  createMarkers({
    bool animateCamera = true,
  }) {
    for (var p in positions) {
      iconMarker().then(
        (icon) {
          markers.add(
            Marker(
                markerId: MarkerId(p.ref ?? ""),
                position: LatLng(p.lat ?? 0, p.lon ?? 0),
                // rotation: p.direction ?? 0,
                flat: false,
                icon: BitmapDescriptor.fromBytes(
                  icon,
                ),
                infoWindow: InfoWindow(
                  title: "Customer",
                  snippet: "${p.ref}",
                ),
                onTap: () {}),
          );
        },
      );
      commit();
      if (!animateCamera) return;
      mapController?.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(
              positions.last.lat ?? 0,
              positions.last.lon ?? 0,
            ),
            zoom: 17,
          ),
        ),
      );
    }
  }

  createMarkersLabel() {
    for (var p in positions) {
      labelMarker(
        label: p.ref?.replaceFirst("CUSTPOS-", ""),
      ).then(
        (icon) {
          markers.add(
            Marker(
                markerId: MarkerId("${p.ref}_label"),
                position: LatLng(p.lat ?? 0, p.lon ?? 0),
                // rotation: p.direction ?? 0,
                flat: false,
                icon: BitmapDescriptor.fromBytes(
                  icon,
                ),
                anchor: const Offset(1.2, 1.5)),
          );
        },
      );
      commit();
    }
  }

  Future<Uint8List> iconMarker() async {
    ByteData data = await rootBundle.load("assets/user_icon_map.png");
    Codec codec = await instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: 100, targetHeight: 100);
    FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  Future<Uint8List> labelMarker({
    String? label,
  }) {
    return createLabelImage(
      text: label ?? "",
      backgroundColor: Colors.transparent,
      textStyle: const TextStyle(
        color: Colors.white,
        backgroundColor: Colors.transparent,
        fontSize: 50,
        fontWeight: FontWeight.bold,
      ),
    ).then(
      (value) {
        return value!.buffer.asUint8List();
      },
    ).catchError((onError) {
      throw onError;
    });
  }

  static Future<ByteData?> createLabelImage({
    String? text,
    Color? backgroundColor,
    TextStyle? textStyle,
  }) {
    Paint paint = Paint();

    paint.color = backgroundColor ?? Colors.white;

    PictureRecorder recorder = PictureRecorder();
    Canvas c = Canvas(recorder);
    c.drawPaint(paint); // etc

    TextSpan span = TextSpan(
        style: textStyle ??
            const TextStyle(
              color: Colors.black,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
        text: " ${text ?? "label"} ");

    TextPainter tp = TextPainter(
      text: span,
      textAlign: TextAlign.left,
      textDirection: TextDirection.ltr,
    );
    tp.layout();
    tp.paint(c, const Offset(0.0, 0.0));

    Picture p = recorder.endRecording();

    return p
        .toImage(tp.size.width.toInt(), tp.size.height.toInt())
        .then((value) {
      return value.toByteData(format: ImageByteFormat.png);
    });
  }
}
