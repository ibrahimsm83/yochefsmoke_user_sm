import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ycsh/model/address.dart';
import 'package:ycsh/utils/constants.dart';
import 'package:ycsh/utils/sizer.dart';
import 'package:ycsh/widget/button.dart';
import 'package:ycsh/widget/common.dart';
import 'package:ycsh/widget/icons.dart';
import 'package:ycsh/widget/map_widget.dart';

class ProfileAddressContainer extends StatelessWidget {
  final void Function(bool selected)? onTap;
  final void Function()? onEdit,onDelete;
  final Address address;
  final bool selected;
  const ProfileAddressContainer({Key? key,this.onEdit,this.onDelete,
    this.onTap,required this.address,
    this.selected=false,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double radius=AppSizer.getRadius(AppDimen.FOOD_CON_RADIUS);
    final double imgHeight=AppSizer.getHeight(90);
    final double iconsize=AppSizer.getHeight(AppDimen.OPT_ICON_SIZE);
    return Slidable(
        endActionPane: ActionPane(
          //closeThreshold: 0.3,openThreshold: 0.1,
          dragDismissible: false,
          children: [],
          extentRatio: 0.30,
          //extentRatio: 0.5,
          motion: Padding(
            padding: EdgeInsets.only(left: AppSizer.getWidth(15)),
            child: Builder(
              builder: (cont) {
                return Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: AppColor.COLOR_RED_LIGHT,
                          borderRadius: BorderRadius.circular(radius)),
                      alignment: Alignment.center,
                      child: CustomIconButton(
                        icon: IconDelete(
                          size: iconsize,
                          color: AppColor.COLOR_RED1,
                        ),
                        onTap: (){
                          onDelete?.call();
                          Slidable.of(cont)?.close();
                        },
                      ),
                    ),

                    SizedBox(width: AppSizer.getWidth(10),),
                    Container(
                      decoration: BoxDecoration(
                          color: AppColor.COLOR_RED_LIGHT,
                          borderRadius: BorderRadius.circular(radius)),
                      alignment: Alignment.center,
                      child: CustomIconButton(
                        icon: IconEdit(
                          size: iconsize,
                          color: AppColor.COLOR_RED1,
                        ),
                        onTap: (){
                          onEdit?.call();
                          Slidable.of(cont)?.close();
                        },
                      ),
                    ),
                  ],
                );
              }
            ),
          ),
        ),
        child: GestureDetector(
          onTap: (){
            onTap?.call(selected);
          },
          child: ShadowContainer(
            radius: radius,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: AppSizer.getHeight(10),
                  horizontal: AppSizer.getWidth(10)),
              decoration: BoxDecoration(//borderRadius: BorderRadius.circular(radius),
                  color: selected?AppColor.THEME_COLOR_PRIMARY1 :AppColor.COLOR_WHITE),
              child: Row(children: [
                Container(
                  height: imgHeight,width: imgHeight*1.4,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(radius),
                    //color: AppColor.THEME_COLOR_PRIMARY1,
                  ),child: MapWidget(
                  myLocationEnabled: false,
                  zoomGesturesEnabled: false,
                  rotateGesturesEnabled: false,
                  scrollGesturesEnabled: false,
                  initialCameraPosition: CameraPosition(
                    bearing: 0,
                    target: LatLng(address.location!.latitude,address.location!.longitude),
                    zoom: AppInteger.MAP_DEFAULT_ZOOM),),),
                SizedBox(width: AppSizer.getWidth(13),),
                Expanded(child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(text: "${address.title}",
                      fontsize: 14,fontweight: FontWeight.bold,),
                    SizedBox(height: AppSizer.getHeight(5),),
                    CustomText(text: "${address.location!.name}",fontsize: 11,
                      fontcolor: AppColor.COLOR_GREY4,),
                  ],))
              ],),),
          ),
        ));
  }
}

class AddressContainer extends StatelessWidget {

  final Address address;
  final void Function()? onTap;
  const AddressContainer({Key? key,required this.address,this.onTap,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double imgHeight=AppSizer.getHeight(90);
    final double radius=AppSizer.getRadius(AppDimen.ADDRESS_CON_RADIUS);
    return GestureDetector(
      onTap: onTap,
      child: ShadowContainer(
        radius: radius,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: AppSizer.getHeight(10),
              horizontal: AppSizer.getWidth(10)),
          decoration: const BoxDecoration(//borderRadius: BorderRadius.circular(radius),
              color: AppColor.COLOR_WHITE),
          child: Row(children: [
            Container(
              height: imgHeight,width: imgHeight*1.6,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(radius),
                // color: AppColor.THEME_COLOR_PRIMARY1,
              ),child: MapWidget(
              myLocationEnabled: false,
              zoomGesturesEnabled: false,
              rotateGesturesEnabled: false,
              scrollGesturesEnabled: false,
              initialCameraPosition: CameraPosition(
                  bearing: 0,
                  target: LatLng(address.location!.latitude,address.location!.longitude),
                  zoom: AppInteger.MAP_DEFAULT_ZOOM),),),
            SizedBox(width: AppSizer.getWidth(13),),
            Expanded(child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(text: address.title!,fontsize: 14,fontweight: FontWeight.bold,),
                SizedBox(height: AppSizer.getHeight(5),),
                CustomText(text: "${address.location?.name}",fontsize: 11,
                  fontcolor: AppColor.COLOR_GREY4,),
              ],))
          ],),),
      ),
    );
  }
}