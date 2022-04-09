import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sufismart/component/cilcular_loader_component.dart';
import 'package:sufismart/view_model/map_user_view_model.dart';


class MapUserView extends StatefulWidget {
  const MapUserView({ Key? key }) : super(key: key);

  @override
  State<MapUserView> createState() => _MapUserViewState();
}

class _MapUserViewState extends State<MapUserView> {
 MapUserViewModel mapUserViewModel = MapUserViewModel();
  
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

  Widget mapWidget(){
  return  Consumer<MapUserViewModel>(
      builder: ((context, value, child) {
        return GoogleMap(
          initialCameraPosition: value.cameraPosition,
          onMapCreated: (controller){
            value.mapController = controller;
          },
          markers: value.markers.toSet(),
          );
      }
    ));
  }
}
