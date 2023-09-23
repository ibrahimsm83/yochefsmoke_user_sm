import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ycsh/model/location.dart';
import 'package:ycsh/service/location.dart';
import 'package:ycsh/utils/asset_path.dart';
import 'package:ycsh/utils/constants.dart';
import 'package:ycsh/utils/sizer.dart';
import 'package:ycsh/widget/app_bar.dart';
import 'package:ycsh/widget/background.dart';
import 'package:ycsh/widget/button.dart';

abstract class MapsTrackScreen extends StatefulWidget {
  const MapsTrackScreen({Key? key}) : super(key: key);

  @override
  MapsTrackScreenState createState();
}

abstract class MapsTrackScreenState extends State<MapsTrackScreen> {

  GoogleMapController? _mapController;

  void onInit(){

  }

  void onDispose(){

  }

  @override
  void initState() {
    onInit();
    super.initState();
  }

  @override
  void dispose() {
    onDispose();
    _mapController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double diameter=AppSizer.getHeight(50);
    return CustomBackground(
      child: Scaffold(extendBodyBehindAppBar: true,
        appBar: buildAppbar(),
        floatingActionButton: CircularButton(diameter: diameter,
          icon: AssetPath.ICON_LOCATION,
          onTap: (){
            getCurrentLocation();
          },
        ),
        body: Container(
          child: Stack(
            children: [
              buildMap(),
              buildLayout(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildMap() {
    return Container(child: GoogleMap(
      compassEnabled: false,
      mapToolbarEnabled: false,
      zoomControlsEnabled: false,
      myLocationButtonEnabled: false,
      myLocationEnabled: true,
      mapType: MapType.normal,
      markers: drawMarkers(),
      initialCameraPosition: getInitialPosition(),
      polylines: drawPolylines(),
      onMapCreated: (GoogleMapController controller) {
        _mapController = controller;
      },
      onCameraMove: onCameraMove,
      // onCameraMove: onCameraMove,
    ));
  }


  void animateCamera(Location location){
    _mapController?.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
            bearing: location.heading,
            // bearing: location.heading.value,
            target: LatLng(location.latitude, location.longitude),
            zoom: AppInteger.MAP_DEFAULT_ZOOM)));
  }

  Widget buildLayout();

  CustomAppbar buildAppbar();

  CameraPosition getInitialPosition(){
    return CameraPosition(
        bearing: 0,
        target: LocationService.def,
        zoom: AppInteger.MAP_DEFAULT_ZOOM);
  }

  void getCurrentLocation(){
    LocationService().getCurrentLocation().then((value) {
      if(value!=null) {
        animateCamera(value);
      }
    });
  }

  Set<Marker> drawMarkers();

  Set<Polyline> drawPolylines();

  void onCameraMove(CameraPosition pos);
}
