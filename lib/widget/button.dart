import 'package:flutter/material.dart';
import 'package:ycsh/utils/constants.dart';
import 'package:ycsh/utils/sizer.dart';
import 'package:ycsh/widget/common.dart';
import 'package:ycsh/widget/icons.dart';

class CustomButton extends StatelessWidget{

  final String text;
  final Color? textColor,bgColor;
  final void Function()? onTap;
  final double fontsize;
  double? radius;
  final EdgeInsets? padding;
  final BorderSide border;
  final bool italic;
  final FontWeight fontWeight;

  CustomButton({this.text="",this.textColor=AppColor.COLOR_BLACK,
    this.bgColor=AppColor.THEME_COLOR_PRIMARY1,this.onTap,this.radius,this.italic=false,
    this.fontsize=AppDimen.FONT_BUTTON,this.border=BorderSide.none,
    this.fontWeight=FontWeight.bold,
    this.padding,
  }){
    radius??=AppSizer.getRadius(AppDimen.LOGIN_BUTTON_RADIUS);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius!),border: Border.fromBorderSide(border),
        color: bgColor,
      ),
      child: Material(color: AppColor.COLOR_TRANSPARENT,
        child: InkWell(onTap: onTap,child: Padding(
          padding: padding??EdgeInsets.symmetric(
              vertical: AppSizer.getHeight(AppDimen.LOGIN_BUTTON_VERT_PADDING)),
          child: child,
        ),),
      ),);
  }


  @override
  Widget get child{
    return CustomText(text: text,fontcolor: textColor,fontsize: fontsize,textAlign: TextAlign.center,
      fontweight: fontWeight,);
  }

}

class CustomIconButton extends StatelessWidget {
  final ResizableIcon icon;
  final void Function()? onTap;
  const CustomIconButton({
    Key? key,
    required this.icon,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Material(
            color: AppColor.COLOR_TRANSPARENT,
            child: IconButton(
              icon: Container(
                //   color: AppColor.COLOR_RED1,
                  child: buildIcon()),
              onPressed: onTap,
              iconSize: icon.getIconSize,
            )));
  }

  Widget buildIcon() {
    return icon;
  }
}

class ButtonBack extends CustomIconButton {

  ButtonBack({
    final void Function()? onTap,
    double? size,
    Color color = AppColor.COLOR_BLACK,
  }) : super(
      icon: IconBack(
        size: size ?? AppSizer.getHeight(AppDimen.APPBAR_ICON_SIZE),
        color: color,
      ),
      onTap: onTap);
}

class ButtonDrawer extends CustomIconButton {

  ButtonDrawer({
    final void Function()? onTap,
    double? size,
    Color color = AppColor.COLOR_BLACK,
  }) : super(
      icon: IconDrawer(
        size: size ?? AppSizer.getHeight(AppDimen.APPBAR_ICON_SIZE),
        color: color,
      ),
      onTap: onTap);
}