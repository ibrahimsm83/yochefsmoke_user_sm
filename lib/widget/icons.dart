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

class IconEdit extends CustomMonoIcon{
  IconEdit({double? size,Color? color,}):super(
      icon: AssetPath.ICON_EDIT,size: size,color: color);
}

class IconDelete extends CustomMonoIcon{
  IconDelete({double? size,Color? color,}):super(
      icon: AssetPath.ICON_DELETE,size: size,color: color);
}

class IconPlus extends CustomMonoIcon{
  IconPlus({double? size,Color? color,}):super(
      icon: AssetPath.ICON_PLUS,size: size,color: color);
}

class IconHeart extends CustomMonoIcon{
  IconHeart({double? size,Color? color,}):super(
      icon: AssetPath.ICON_HEART,size: size,color: color);
}

class IconDropdown extends CustomMonoIcon{
  IconDropdown({double? size,Color? color,}):super(
      icon: AssetPath.ICON_DROPDOWN,size: size,color: color);
}

class IconTick extends CustomMonoIcon{
  IconTick({double? size,Color? color,}):super(
      icon: AssetPath.ICON_TICK,size: size,color: color);
}

class IconVoucher extends CustomMonoIcon{
  IconVoucher({double? size,Color? color,}):super(
      icon: AssetPath.ICON_VOUCHER,size: size,color: color);
}

class IconLocation extends CustomMonoIcon{
  IconLocation({double? size,Color? color,}):super(
      icon: AssetPath.ICON_LOCATION2,size: size,color: color);
}

