import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:ycsh/utils/asset_path.dart';
import 'package:ycsh/utils/constants.dart';
import 'package:ycsh/utils/sizer.dart';
import 'package:ycsh/utils/strings.dart';
import 'package:ycsh/widget/button.dart';
import 'package:ycsh/widget/common.dart';
import 'package:ycsh/widget/icons.dart';
import 'package:ycsh/widget/login_items.dart';

class CartItemContainer extends StatelessWidget {

  final void Function()? onTap,onDelete;
  const CartItemContainer({Key? key,this.onTap,this.onDelete,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double radius=AppSizer.getRadius(AppDimen.FOOD_CON_RADIUS);
    final double imgHeight=AppSizer.getHeight(100);
    final double padding=AppSizer.getHeight(10);
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
            child: CustomIconButton(icon: IconDelete(size: AppSizer.getHeight(20),
              color: AppColor.COLOR_RED1,),
              onTap: onDelete,),
          ),
        ),
      ),
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
                        child: CustomImage(image: AssetPath.IMAGE_SAMPLE2,
                          fit: BoxFit.cover,))),
                SizedBox(width: AppSizer.getWidth(15),),
                Expanded(child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  CustomText(text: "Red Snapper Fillet",fontsize: 14,
                    fontweight: FontWeight.bold,),
                  SizedBox(height: AppSizer.getHeight(4),),
                  CustomText(text: "Fried or Grilled",
                    fontcolor: AppColor.COLOR_GREY4,fontsize: 9,),
                    SizedBox(height: AppSizer.getHeight(16),),
                    CustomText(text: "\$20",fontsize: 19,fontweight: FontWeight.w500,)
                ],)),
                Padding(
                  padding: EdgeInsets.only(right: AppSizer.getWidth(20)),
                  child: Column(
                    children: [
                    buildButton("-",),
                    Padding(padding: EdgeInsets.symmetric(vertical: AppSizer.getHeight(17)),
                      child: CustomText(text: "2",fontweight: FontWeight.w500,
                        line_spacing: 1,),),
                    buildButton("+",),
                  ],),
                ),
              ],
            ),
            ),
      ),
    );
  }

  Widget buildButton(String text,{Function()? onTap}){
    return Container(//color: Colors.red,
      child: TappableText(text: text,fontcolor: AppColor.COLOR_BLACK,fontsize: 24,
        fontweight: FontWeight.w600,onTap: onTap,line_spacing: 1,),
    );
  }

}

class AddressContainer extends StatelessWidget {
  const AddressContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double imgHeight=AppSizer.getHeight(90);
    final double radius=AppSizer.getRadius(AppDimen.ADDRESS_CON_RADIUS);
    return ShadowContainer(
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
          color: AppColor.THEME_COLOR_PRIMARY1,
          ),),
          SizedBox(width: AppSizer.getWidth(13),),
          Expanded(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            const CustomText(text: AppString.TEXT_HOME,fontsize: 14,fontweight: FontWeight.bold,),
            SizedBox(height: AppSizer.getHeight(5),),
            CustomText(text: "25 East 38th Street, New York, NY, 10016, USA",fontsize: 11,
              fontcolor: AppColor.COLOR_GREY4,),
          ],))
      ],),),
    );
  }
}



