import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:ycsh/utils/asset_path.dart';
import 'package:ycsh/utils/constants.dart';
import 'package:ycsh/utils/navigation.dart';
import 'package:ycsh/utils/sizer.dart';
import 'package:ycsh/utils/strings.dart';
import 'package:ycsh/widget/app_bar.dart';
import 'package:ycsh/widget/background.dart';
import 'package:ycsh/widget/button.dart';
import 'package:ycsh/widget/common.dart';
import 'package:ycsh/widget/profile_items.dart';

class TrackOrderScreen extends StatefulWidget {
  const TrackOrderScreen({Key? key}) : super(key: key);

  @override
  State<TrackOrderScreen> createState() => _TrackOrderScreenState();
}

class _TrackOrderScreenState extends State<TrackOrderScreen> {

  final double btnRadius=AppSizer.getHeight(48);
  final double panelMinHeight=AppSizer.getHeight(30);

  @override
  Widget build(BuildContext context) {
    return CustomBackground(child: Scaffold(
      extendBodyBehindAppBar: true,
      appBar: TransparentAppbar(text: AppString.TEXT_ORDER_TRACK,
        leading: ButtonBack(onTap: (){
        AppNavigator.pop();
      },),),
      body: Container(child: Stack(children: [
        Positioned.fill(child: GoogleMap(
          compassEnabled: false,
          mapToolbarEnabled: true,
          zoomControlsEnabled: false,
          myLocationButtonEnabled: false,
          myLocationEnabled: false,
          mapType: MapType.normal,

          initialCameraPosition: CameraPosition(
            target: LatLng(37.42796133580664, -122.085749655962),
            zoom: 14.0, bearing: 0),)),
        buildBottom(),
      ],),),
    ));
  }

  Widget buildBottom(){
    final double radius=AppSizer.getRadius(AppDimen.BOTTOM_PANEL_RADIUS);
    return SlidingUpPanel(color: AppColor.COLOR_WHITE,
        minHeight: panelMinHeight,
        padding: EdgeInsets.zero,
        maxHeight: AppSizer.getPerHeight(0.5),
  //    body: CustomText(text: "body",),
      defaultPanelState: PanelState.OPEN,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(radius),
            topRight: Radius.circular(radius)),
        //panel: Container(color: AppColor.COLOR_BLACK,),
      panel: Container(color: AppColor.COLOR_TRANSPARENT,
          padding:EdgeInsets.only(top: panelMinHeight),
      child: SingleChildScrollView(
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
                    padding: EdgeInsets.symmetric(vertical: AppSizer.getHeight(10),
                        horizontal: AppSizer.getWidth(15)),
                    color: AppColor.COLOR_WHITE,
                    child:Row(children: [
                      CircularPic(diameter: AppSizer.getHeight(60)),
                      SizedBox(width: AppSizer.getWidth(17),),
                      Expanded(child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(text: "James Robert",fontsize: 14,fontweight: FontWeight.bold,),
                          SizedBox(height: AppSizer.getHeight(5),),
                          CustomText(text: "Driver - Ad 4525 USA",fontsize: 11,
                            fontcolor: AppColor.COLOR_GREY6,)
                        ],)),
                      CircularButton(diameter: btnRadius, icon: AssetPath.ICON_PHONE,
                        bgColor: AppColor.COLOR_BLACK,color: AppColor.COLOR_WHITE,ratio: 0.5,)
                    ],))),
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
                        child: DottedContainer(height: 24,width: 0,dashlength: 7,
                          dashspacing: 10,
                          borderWidth: 2,),
                      )),
                  buildInfo(AssetPath.ICON_LOCATION2,"East 38Th Street, USA",
                      "Restaurant | 15:40"),
                ],
              ),),
            SizedBox(height: AppSizer.getHeight(37),),
            CustomButton(text: AppString.TEXT_ORDER_RECEIVED,)
          ],),
      ),),
        panelSnapping: true,
     /*   panelBuilder: (cont){
          return Container(color: AppColor.COLOR_TRANSPARENT,
          padding:EdgeInsets.only(top: panelMinHeight),
      child: SingleChildScrollView(
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
                    padding: EdgeInsets.symmetric(vertical: AppSizer.getHeight(10),
                        horizontal: AppSizer.getWidth(15)),
                    color: AppColor.COLOR_WHITE,
                    child:Row(children: [
                      CircularPic(diameter: AppSizer.getHeight(60)),
                      SizedBox(width: AppSizer.getWidth(17),),
                      Expanded(child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(text: "James Robert",fontsize: 14,fontweight: FontWeight.bold,),
                          SizedBox(height: AppSizer.getHeight(5),),
                          CustomText(text: "Driver - Ad 4525 USA",fontsize: 11,
                            fontcolor: AppColor.COLOR_GREY6,)
                        ],)),
                      CircularButton(diameter: btnRadius, icon: AssetPath.ICON_PHONE,
                        bgColor: AppColor.COLOR_BLACK,color: AppColor.COLOR_WHITE,ratio: 0.5,)
                    ],))),
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
                        child: DottedContainer(height: 24,width: 0,dashlength: 7,
                          dashspacing: 10,
                          borderWidth: 2,),
                      )),
                  buildInfo(AssetPath.ICON_LOCATION2,"East 38Th Street, USA",
                      "Restaurant | 15:40"),
                ],
              ),),
            SizedBox(height: AppSizer.getHeight(37),),
            CustomButton(text: AppString.TEXT_ORDER_RECEIVED,)
          ],),
      ),);
        },*/
    );
  }

  Widget buildInfo(String icon,String text1,String text2){
    return Row(children: [
      CircularButton(diameter: btnRadius, icon: icon,bgColor: AppColor.COLOR_GREY7,
        color: AppColor.COLOR_BLACK,),
      SizedBox(width: AppSizer.getWidth(17),),
      Expanded(child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(text: "James Robert",fontsize: 14,fontweight: FontWeight.bold,),
          SizedBox(height: AppSizer.getHeight(5),),
          CustomText(text: "Driver - Ad 4525 USA",fontsize: 11,
            fontcolor: AppColor.COLOR_GREY6,)
        ],)),
    ],);
  }
}
