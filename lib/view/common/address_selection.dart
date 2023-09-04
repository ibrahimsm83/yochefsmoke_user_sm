import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ycsh/model/location.dart';
import 'package:ycsh/service/location.dart';
import 'package:ycsh/utils/actions.dart';
import 'package:ycsh/utils/asset_path.dart';
import 'package:ycsh/utils/constants.dart';
import 'package:ycsh/utils/navigation.dart';
import 'package:ycsh/utils/sizer.dart';
import 'package:ycsh/utils/strings.dart';
import 'package:ycsh/widget/app_bar.dart';
import 'package:ycsh/widget/background.dart';
import 'package:ycsh/widget/button.dart';
import 'package:ycsh/widget/icons.dart';

class AddressSelectionScreen extends StatefulWidget {

  final void Function(Location loc) onLocationSelected;
  final Location? initial;
  const AddressSelectionScreen({Key? key,this.initial,
    required this.onLocationSelected,}) : super(key: key);

  @override
  State<AddressSelectionScreen> createState() => _AddressSelectionScreenState();
}

class _AddressSelectionScreenState extends State<AddressSelectionScreen> {
  GoogleMapController? _mapController;

  late LatLng sel;

  @override
  void initState() {
    sel=widget.initial!=null?LatLng(widget.initial!.latitude,
        widget.initial!.longitude):LocationService.def;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double diameter=AppSizer.getHeight(50);
    final double iconsize=AppSizer.getHeight(25);
    return CustomBackground(
      child: Scaffold(extendBodyBehindAppBar: true,
        appBar: TransparentAppbar(leading: ButtonBack(
          onTap: (){
            AppNavigator.pop();
          },
        ),action: CustomButton(
          text: AppString.TEXT_OK,bgColor: AppColor.COLOR_TRANSPARENT,
          textColor: AppColor.COLOR_BLACK,
          padding: EdgeInsets.symmetric(horizontal: AppSizer.getWidth(15),
              vertical: AppSizer.getHeight(15)),
          onTap: (){
            saveLocation();
          },
        ),),
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
              Center(child: IconLocation(size: iconsize,),),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }

  Widget buildMap() {
    return Container(child: GoogleMap(
      compassEnabled: false,
      mapToolbarEnabled: false,
      zoomControlsEnabled: false,
      myLocationButtonEnabled: false,
      myLocationEnabled: true,
      mapType: MapType.normal,
      //markers: drawMarkers(initial),
      initialCameraPosition: getInitialPosition(),
      //polylines: drawPolylines(),
      onMapCreated: (GoogleMapController controller) {
        _mapController = controller;
      },
      onCameraMove: (pos){
        sel=pos.target;
        print("oncamera move: $sel");
      },
      // onCameraMove: onCameraMove,
    ));
  }

  void saveLocation(){
    AppLoader.showLoader();
    LocationService().geoCode(sel).then((value) {
      AppLoader.dismissLoader();
      AppNavigator.pop();
      widget.onLocationSelected(value);
    });
  }

  void getCurrentLocation(){
    LocationService().getCurrentLocation().then((value) {
      if(value!=null) {
        animateCamera(value);
      }
    });
  }

  void animateCamera(Location location){
    _mapController?.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
            bearing: location.heading,
            // bearing: location.heading.value,
            target: LatLng(location.latitude, location.longitude),
            zoom: AppInteger.MAP_DEFAULT_ZOOM)));
  }

  CameraPosition getInitialPosition() {
    return CameraPosition(
        bearing: 0,
        target: sel,
        zoom: AppInteger.MAP_DEFAULT_ZOOM);
  }
}
