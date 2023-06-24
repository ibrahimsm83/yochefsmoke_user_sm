import 'package:flutter/material.dart';
import 'package:ycsh/service/image_chooser.dart';
import 'package:ycsh/utils/asset_path.dart';
import 'package:ycsh/utils/constants.dart';
import 'package:ycsh/widget/common.dart';

class CircularPic extends StatelessWidget {
  final double diameter;
  final String? image;
  final BorderSide border;
  final ImageType imageType;
  const CircularPic({Key? key,required this.diameter, this.image=AssetPath.IMAGE_SAMPLE,
    this.imageType=ImageType.TYPE_ASSET,
    this.border = const BorderSide(width: 0,
        color: AppColor.COLOR_TRANSPARENT)}):super(key: key,);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: diameter,
      height: diameter,
      decoration: BoxDecoration(
        shape: BoxShape.circle, border: Border.fromBorderSide(border),),
      child: ClipOval(
          child: CustomImage(
            image: image,imageType: imageType,fit: BoxFit.cover,
          )),
    );
  }
}