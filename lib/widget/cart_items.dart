import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ycsh/model/address.dart';
import 'package:ycsh/model/product.dart';
import 'package:ycsh/service/image_chooser.dart';
import 'package:ycsh/utils/asset_path.dart';
import 'package:ycsh/utils/constants.dart';
import 'package:ycsh/utils/sizer.dart';
import 'package:ycsh/utils/strings.dart';
import 'package:ycsh/widget/button.dart';
import 'package:ycsh/widget/common.dart';
import 'package:ycsh/widget/icons.dart';
import 'package:ycsh/widget/login_items.dart';
import 'package:ycsh/widget/map_widget.dart';

class CartItemContainer extends StatelessWidget {

  final void Function(int val)? onCountTap;
  final void Function()? onDelete,onTap;
  final Product product;
  const CartItemContainer({Key? key,this.onCountTap,this.onDelete,this.onTap,
    required this.product,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double radius=AppSizer.getRadius(AppDimen.FOOD_CON_RADIUS);
    final double imgHeight=AppSizer.getHeight(100);
    final double padding=AppSizer.getHeight(10);
    final double iconsize=AppSizer.getHeight(AppDimen.OPT_ICON_SIZE);
    return Slidable(
      endActionPane: ActionPane(//closeThreshold: 0.3,openThreshold: 0.1,
        dragDismissible: false,
        children: [],
        extentRatio: 0.20,
        //extentRatio: 0.5,
        motion: Padding(
          padding: EdgeInsets.only(left: AppSizer.getWidth(15)),
          child: Container(
            decoration: BoxDecoration(color: AppColor.COLOR_RED_LIGHT,
                borderRadius: BorderRadius.circular(radius)),
            alignment: Alignment.center,
            child: CustomIconButton(icon: IconDelete(size: iconsize,
              color: AppColor.COLOR_RED1,),
              onTap: onDelete,),
          ),
        ),
      ),
      child: GestureDetector(
        onTap: onTap,
        child: ShadowContainer(
          radius: radius,
          child: Container(
            padding: EdgeInsets.all(padding),
              decoration: BoxDecoration(color: AppColor.COLOR_WHITE,
                borderRadius: BorderRadius.circular(radius),
              ),child: Row(
                children: [
                  Container(
                      width: imgHeight,height: imgHeight,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(radius),
                          child: CustomImage(image: product.image,
                            fit: BoxFit.cover,imageType: ImageType.TYPE_NETWORK,))),
                  SizedBox(width: AppSizer.getWidth(15),),
                  Expanded(child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    CustomText(text: "${product.name}",fontsize: 14,
                      fontweight: FontWeight.bold,),
                    SizedBox(height: AppSizer.getHeight(4),),
                    CustomText(text: "${product.cook_type}",
                      fontcolor: AppColor.COLOR_GREY4,fontsize: 9,),
                      SizedBox(height: AppSizer.getHeight(16),),
                      CustomText(text: "\$${product.price}",
                        fontsize: 19,fontweight: FontWeight.w500,)
                  ],)),
                  Padding(
                    padding: EdgeInsets.only(right: AppSizer.getWidth(20)),
                    child: Column(
                      children: [
                      buildButton("-",onTap: (){
                        onCountTap?.call(-1);
                      }),
                      Padding(padding: EdgeInsets.symmetric(vertical: AppSizer.getHeight(17)),
                        child: CustomText(text: "${product.quantity}",
                          fontweight: FontWeight.w500,
                          line_spacing: 1,),),
                      buildButton("+",onTap: (){
                        onCountTap?.call(1);
                      }),
                    ],),
                  ),
                ],
              ),
              ),
        ),
      ),
    );
  }

  Widget buildButton(String text,{Function()? onTap}){
    return TappableText(
      text: text,fontcolor: AppColor.COLOR_BLACK,fontsize: 24,
      fontweight: FontWeight.w600,onTap: onTap,line_spacing: 1,);
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



