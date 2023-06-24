import 'package:flutter/material.dart';
import 'package:ycsh/utils/asset_path.dart';

abstract class ResizableIcon extends Widget{
  double get getIconSize;
}

class CustomMonoIcon extends ImageIcon implements ResizableIcon{
  CustomMonoIcon({required String icon,double? size,Color? color,}):super(
      AssetImage(icon),size: size,color: color);

  @override
  double get getIconSize => size!;
}

class IconBack extends CustomMonoIcon{
  IconBack({double? size,Color? color,}):super(
      icon: AssetPath.ICON_ARROW_BACK,size: size,color: color);
}
class IconDrawer extends CustomMonoIcon{
  IconDrawer({double? size,Color? color,}):super(
      icon: AssetPath.ICON_DRAWER,size: size,color: color);
}

class IconLogout extends CustomMonoIcon{
  IconLogout({double? size,Color? color,}):super(
      icon: AssetPath.ICON_LOGOUT,size: size,color: color);
}


