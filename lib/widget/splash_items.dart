import 'package:flutter/material.dart';
import 'package:ycsh/service/image_chooser.dart';
import 'package:ycsh/utils/asset_path.dart';
import 'package:ycsh/widget/common.dart';

class AppLogo extends StatelessWidget {
  final double? width;
  final double? height;
  const AppLogo({Key? key, this.width,this.height,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(width: width,height: height,
      //color: AppColor.COLOR_BLACK,
      child: const CustomImage(image:AssetPath.APP_LOGO,fit: BoxFit.contain,
        imageType: ImageType.TYPE_ASSET,),);
  }
}