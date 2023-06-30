import 'package:flutter/material.dart';
import 'package:ycsh/utils/constants.dart';
import 'package:ycsh/utils/sizer.dart';
import 'package:ycsh/widget/common.dart';
import 'package:ycsh/widget/splash_items.dart';

abstract class CustomAppbar extends StatelessWidget implements PreferredSizeWidget{

  final double height;
  final Widget? action;
  final Widget? leading;
  final Widget? title;
  final Color color;
  const CustomAppbar({Key? key,required this.height,
    this.leading,
    this.action,this.title,this.color=AppColor.COLOR_WHITE});


  @override
  Widget build(BuildContext context) {
    return Container(color: color,
      height: preferredSize.height,
      padding: const EdgeInsets.symmetric(
          horizontal: AppDimen.APPBAR_HORZ_PADDING),
      child: Row(//crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          leading??Container(width: action!=null?AppDimen.APPBAR_ICON_BUTTON_SIZE:0,),
          Expanded(child: title?? Container()),
          action??Container(width: leading!=null?AppDimen.APPBAR_ICON_BUTTON_SIZE:0,),
        ],),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);

}

class LogoAppbar extends CustomAppbar{
  LogoAppbar({Key? key,double? height,
    Widget? leading,Widget? action,
    Color color=AppColor.COLOR_TRANSPARENT,}):super(key: key,
      height: height??AppSizer.getHeight(AppDimen.DASHBOARD_APPBAR_HEIGHT),
      leading: leading,action: action,
      color: color);

  @override
  Widget? get title => Center(child: AppLogo(height: height*0.9,));

}

class DashboardAppbar extends CustomAppbar{

  final String text;
  final Color textColor;
  DashboardAppbar({Key? key,double? height,
    Widget? leading,Widget? action,this.textColor=AppColor.COLOR_BLACK,
    Color color=AppColor.COLOR_WHITE,
    this.text=""}):super(key: key,
      height: height??AppSizer.getHeight(AppDimen.DASHBOARD_APPBAR_HEIGHT),
      leading: leading,action: action,
      color: color);

  @override
  Widget? get title {
    return CustomText(text:text,fontcolor: textColor,textAlign: TextAlign.center,
      fontsize: 16,fontweight: FontWeight.bold,);
  }


}

class TransparentAppbar extends DashboardAppbar{

  TransparentAppbar({double? height,
    Widget? leading,Widget? action,Color textColor=AppColor.COLOR_BLACK,
    String text=""}):super(height: height??AppSizer.getHeight(AppDimen.LOGIN_APPBAR_HEIGHT),
      leading: leading,action: action,textColor: textColor,
      color: AppColor.COLOR_TRANSPARENT,
      text: text);

}