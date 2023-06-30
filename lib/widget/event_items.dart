import 'package:flutter/material.dart';
import 'package:ycsh/utils/asset_path.dart';
import 'package:ycsh/utils/constants.dart';
import 'package:ycsh/utils/sizer.dart';
import 'package:ycsh/widget/common.dart';

class EventContainer extends StatelessWidget {

  final Color color;
  final void Function()? onTap;
  const EventContainer({Key? key,this.color=AppColor.COLOR_BLACK,this.onTap,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double radius=AppSizer.getRadius(8);
    final double height=AppSizer.getHeight(180);
    return GestureDetector(
      onTap: onTap,
      child: Container(decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),color: AppColor.COLOR_TRANSPARENT),
        clipBehavior: Clip.antiAlias,
        height: height,
        child: Stack(children: [
        Positioned.fill(child: CustomImage(image: AssetPath.IMAGE_SAMPLE2,fit: BoxFit.cover,)),
          Positioned.fill(
            child: Container(decoration: BoxDecoration(gradient: LinearGradient(
                begin: Alignment.topCenter,end: Alignment.bottomCenter,
                stops: [0,0.6,1],
                colors: [
              color,AppColor.COLOR_TRANSPARENT, AppColor.COLOR_TRANSPARENT,
            ])),),
          ),
          Container(
              padding: EdgeInsets.symmetric(horizontal: AppSizer.getWidth(18),
                  vertical: AppSizer.getHeight(25)),
              child: CustomText(text: "Your event name goes here",fontsize: 18,
                fontcolor: AppColor.COLOR_WHITE,fontweight: FontWeight.w600,)),
          Positioned(child: buildRoundContainer("17 April"),
            bottom: AppSizer.getHeight(22),right: 0,),
      ],),),
    );
  }

  Widget buildRoundContainer(String text){
    final double radius=AppSizer.getRadius(30);
    final double paddVert=AppSizer.getHeight(11);
    return Container(
      padding: EdgeInsets.fromLTRB(AppSizer.getWidth(20), paddVert,
          AppSizer.getWidth(13), paddVert),
      decoration: BoxDecoration(color: AppColor.THEME_COLOR_PRIMARY1,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(radius),
              bottomLeft: Radius.circular(radius))),
      child: CustomText(text: text,fontsize: 14,fontweight: FontWeight.bold,),);
  }
}
