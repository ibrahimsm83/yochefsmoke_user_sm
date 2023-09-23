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
import 'package:ycsh/view/common/maps_track.dart';
import 'package:ycsh/widget/app_bar.dart';
import 'package:ycsh/widget/background.dart';
import 'package:ycsh/widget/button.dart';
import 'package:ycsh/widget/icons.dart';

class AddressSelectionScreen extends MapsTrackScreen {

  final void Function(Location loc) onLocationSelected;
  final Location? initial;
  const AddressSelectionScreen({Key? key,this.initial,
    required this.onLocationSelected,}) : super(key: key);

  @override
  MapsTrackScreenState createState() => _AddressSelectionScreenState();
}

class _AddressSelectionScreenState extends MapsTrackScreenState {


  late LatLng sel;


  @override
  AddressSelectionScreen get widget => super.widget as AddressSelectionScreen;

  @override
  void onInit() {
    sel=widget.initial!=null?LatLng(widget.initial!.latitude,
        widget.initial!.longitude):LocationService.def;
    super.onInit();
  }

/*  @override
  Widget build(BuildContext context) {
    final double diameter=AppSizer.getHeight(50);

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
  }*/

  @override
  CustomAppbar buildAppbar() {
    return TransparentAppbar(leading: ButtonBack(
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
    ),);
  }

  @override
  Widget buildLayout() {
    final double iconsize=AppSizer.getHeight(25);
    return Center(child: IconLocation(size: iconsize,),);
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

  @override
  CameraPosition getInitialPosition() {
    return CameraPosition(
        bearing: 0,
        target: sel,
        zoom: AppInteger.MAP_DEFAULT_ZOOM);
  }

  @override
  void onCameraMove(CameraPosition pos) {
    sel=pos.target;
  }

  @override
  Set<Polyline> drawPolylines() {
    return {};
  }

  @override
  Set<Marker> drawMarkers() {
    return {};
  }

}
