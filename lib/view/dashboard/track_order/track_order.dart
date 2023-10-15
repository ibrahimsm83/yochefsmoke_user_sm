import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:ycsh/controller/user/controllers.dart';
import 'package:ycsh/controller/user/tracking_controller.dart';
import 'package:ycsh/model/interface.dart';
import 'package:ycsh/model/location.dart';
import 'package:ycsh/model/order.dart';
import 'package:ycsh/service/image_chooser.dart';
import 'package:ycsh/service/location.dart';
import 'package:ycsh/utils/actions.dart';
import 'package:ycsh/utils/asset_path.dart';
import 'package:ycsh/utils/constants.dart';
import 'package:ycsh/utils/navigation.dart';
import 'package:ycsh/utils/sizer.dart';
import 'package:ycsh/utils/strings.dart';
import 'package:ycsh/view/common/maps_track.dart';
import 'package:ycsh/widget/app_bar.dart';
import 'package:ycsh/widget/button.dart';
import 'package:ycsh/widget/common.dart';
import 'package:ycsh/widget/profile_items.dart';

class TrackOrderScreen extends MapsTrackScreen {

  final Order order;
  const TrackOrderScreen({Key? key,required this.order,}) : super(key: key);

  @override
  MapsTrackScreenState createState() => _TrackOrderScreenState();
}

class _TrackOrderScreenState extends MapsTrackScreenState
    implements LocationInterface{

  final double btnRadius=AppSizer.getHeight(48);
  final double panelMinHeight=AppSizer.getHeight(30);

  //final OrderController orderController=Get.find<OrderController>();
  final TrackingController trackingController=Get.find<TrackingController>();

  @override
  TrackOrderScreen get widget => super.widget as TrackOrderScreen;

  @override
  void onInit() {
    trackingController.locationInterface=this;
    trackingController.connectSocket(widget.order.rider!);
    super.onInit();
  }

  @override
  void onDispose() {
    trackingController.locationInterface=null;
    trackingController.disconnectSocket();
    super.onDispose();
  }

  @override
  void onLocationChanged(Location location) {
   // animateCamera(location);
    setState(() {});
  }

  @override
  CustomAppbar buildAppbar() {
    return TransparentAppbar(text: AppString.TEXT_ORDER_TRACK,
      leading: ButtonBack(onTap: (){
        AppNavigator.pop();
      },),);
  }

  @override
  Widget buildLayout() {
    final double radius=AppSizer.getRadius(AppDimen.BOTTOM_PANEL_RADIUS);
    return SlidingUpPanel(color: AppColor.COLOR_WHITE,
      minHeight: panelMinHeight,
      padding: EdgeInsets.zero,
      maxHeight: AppSizer.getPerHeight(AppDimen.PANEL_MAX_HEIGHT_RATIO),
      //    body: CustomText(text: "body",),
      defaultPanelState: PanelState.OPEN,
      borderRadius: BorderRadius.only(topLeft: Radius.circular(radius),
          topRight: Radius.circular(radius)),
      panelSnapping: true,
         panelBuilder: (cont){
          return Container(color: AppColor.COLOR_TRANSPARENT,
            padding:EdgeInsets.only(top: panelMinHeight),
            child: SingleChildScrollView(
              controller: cont,
              padding: EdgeInsets.symmetric(
                  horizontal: AppSizer.getWidth(AppDimen.DASHBOARD_PADDING_HORZ),
                  vertical: AppDimen.SCROLL_OFFSET_PADDING_VERT
              ),
              //controller: cont,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ShadowContainer(
                      radius: AppSizer.getRadius(10),
                      child: Container(
                          color: AppColor.COLOR_WHITE,
                          child:Material(
                            color: AppColor.COLOR_TRANSPARENT,
                            child: InkWell(
                              onTap: (){
                                goToRiderLocation();
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: AppSizer.getHeight(10),
                                    horizontal: AppSizer.getWidth(15)),
                                child: Row(children: [
                                  CircularPic(diameter: AppSizer.getHeight(60),
                                    image: widget.order.rider?.image,imageType: ImageType.TYPE_NETWORK,),
                                  SizedBox(width: AppSizer.getWidth(17),),
                                  Expanded(child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      CustomText(text: "${widget.order.rider?.fullname}",
                                        fontsize: 14,fontweight: FontWeight.bold,),
                                      SizedBox(height: AppSizer.getHeight(5),),
                                    /*  CustomText(text: "Driver - Ad 4525 USA",fontsize: 11,
                                        fontcolor: AppColor.COLOR_GREY6,)*/
                                      CustomText(text: "Driver",fontsize: 11,
                                        fontcolor: AppColor.COLOR_GREY6,)
                                    ],)),
                                  CircularButton(diameter: btnRadius, icon: AssetPath.ICON_PHONE,
                                    bgColor: AppColor.COLOR_BLACK,color: AppColor.COLOR_WHITE,
                                    ratio: 0.5,onTap: (){
                                     AppUrlLauncher.launchPhoneNumber(widget.order.rider!.phone!);
                                    },)
                                ],),
                              ),
                            ),
                          ))),
                  SizedBox(height: AppSizer.getHeight(44),),
                  Padding(padding: EdgeInsets.only(left: AppSizer.getWidth(30),),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [

                        buildInfo(AssetPath.ICON_CLOCK,"Yo Chef Pull Up",
                            "Restaurant | 15:40"),
                        Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: (btnRadius/2)-1,
                                  vertical: AppSizer.getHeight(6)),
                              child: const DottedContainer(height: 24,width: 0,dashlength: 7,
                                dashspacing: 10,
                                borderWidth: 2,),
                            )),
                        buildInfo(AssetPath.ICON_LOCATION2,
                            "${widget.order.address?.location!.name}",
                            "",onTap: (){
                              goToDestination();
                            }),
                      ],
                    ),),
                  SizedBox(height: AppSizer.getHeight(37),),
                  CustomButton(
                    bgColor: Order.colorMap[widget.order.status]??AppColor.THEME_COLOR_PRIMARY1,
                    //text: AppString.TEXT_ORDER_RECEIVED,
                    text: Order.statusMap[widget.order.status]!,
                    textColor: widget.order.status==Order.STATUS_ARRIVED?
                    AppColor.COLOR_WHITE:AppColor.COLOR_BLACK,)
                ],),
            ),);
        },
    );
  }


  Widget buildInfo(String icon,String text1,String text2,{void Function()? onTap,}){
    return Row(
      //crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      CircularButton(diameter: btnRadius, icon: icon,bgColor: AppColor.COLOR_GREY7,
        color: AppColor.COLOR_BLACK,onTap: onTap,),
      SizedBox(width: AppSizer.getWidth(17),),
      Expanded(child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(text: text1,fontsize: 14,fontweight: FontWeight.bold,),
          Visibility(
            visible: text2.isNotEmpty,

            child: Padding(
              padding: EdgeInsets.only(top: AppSizer.getHeight(5),),
              child: CustomText(text: text2,fontsize: 11,
                fontcolor: AppColor.COLOR_GREY6,),
            ),
          )
        ],)),
    ],);
  }

  @override
  void onCameraMove(CameraPosition pos) {

  }

  @override
  Set<Polyline> drawPolylines() {
    return {};
  }

  void goToRiderLocation(){
    final Location? cur_loc=trackingController.getRiderLocation(widget.order.rider!.id!);
    if(cur_loc!=null){
      animateCamera(cur_loc);
    }
  }

  void goToDestination(){
    final Location? cur_loc=widget.order.address?.location;
    if(cur_loc!=null){
      animateCamera(cur_loc);
    }
  }

  @override
  CameraPosition getInitialPosition() {
    final Location? cur_loc=widget.order.address?.location;
    final LatLng cur_points=cur_loc!=null?LatLng(cur_loc.latitude, cur_loc.longitude):
    LocationService.def;
    final double rotation=cur_loc?.heading??0;
    return CameraPosition(
        bearing: rotation,
        target: cur_points,
        zoom: AppInteger.MAP_DEFAULT_ZOOM);
  }

  @override
  Set<Marker> drawMarkers() {
    final Location? cur_loc=trackingController.getRiderLocation(widget.order.rider!.id!);
    final LatLng cur_points=cur_loc!=null?LatLng(cur_loc.latitude, cur_loc.longitude):
    LocationService.def;
    final double rotation=cur_loc?.heading??0;
    final Set<Marker> list={
      Marker(
        rotation: rotation,
        markerId: const MarkerId(TrackingController.CURLOC),
        flat: true,infoWindow: const InfoWindow(title: TrackingController.CURLOC),
        icon: trackingController.curloc_marker,
        position: cur_points,
        draggable: false,
      )
    };
    Location? loc=widget.order.address?.location;
    if(loc!=null){
      list.add(Marker(
        rotation: 0,
        markerId: const MarkerId(TrackingController.DROPOFF),
        flat: true,infoWindow: const InfoWindow(title: TrackingController.DROPOFF),
        icon: trackingController.dropoff_marker,
        position: LatLng(loc.latitude,loc.longitude),
        draggable: false,
      ));
    }
    return list;
  }

}
