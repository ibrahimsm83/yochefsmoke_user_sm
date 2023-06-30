import 'package:flutter/material.dart';
import 'package:ycsh/utils/asset_path.dart';
import 'package:ycsh/utils/constants.dart';
import 'package:ycsh/utils/sizer.dart';
import 'package:ycsh/widget/common.dart';

class MenuCategoryContainer extends StatelessWidget {

  final String text;
  final void Function()? onTap;
  final bool selected;
  const MenuCategoryContainer({Key? key,this.text="",this.onTap,this.selected=false,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(color:AppColor.COLOR_TRANSPARENT,
          child: CustomText(text: text,fontsize: 18,fontweight: FontWeight.w600,
            fontcolor: selected?AppColor.THEME_COLOR_PRIMARY1:AppColor.COLOR_GREY8,),));
  }
}

class MenuContainer2 extends StatelessWidget {

  final void Function()? onTap;
  final bool selected;
  const MenuContainer2({Key? key,this.selected=false,this.onTap,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double padding=AppSizer.getHeight(17);
    final double radius=AppSizer.getRadius(AppDimen.FOOD_CON_RADIUS);
    return GestureDetector(
      onTap: onTap,
      child: ShadowContainer(
        radius: radius,
        enabledPadding: true,
        child: Container(
          padding: EdgeInsets.all(padding),
          decoration: BoxDecoration(color: selected?AppColor.COLOR_RED1:AppColor.COLOR_WHITE),
          child: Column(
          children: [
            Expanded(
              child: Container(child: CustomImage(
                image: AssetPath.IMAGE_SAMPLE4,fit: BoxFit.contain,
              ),),
            ),
            SizedBox(height: AppSizer.getHeight(7),),
            CustomText(text: "Brunch",
              fontcolor: selected?AppColor.COLOR_WHITE:AppColor.COLOR_BLACK,
              fontweight: FontWeight.w600,fontsize: 14,)
          ],
        ),),
      ),
    );
  }
}
