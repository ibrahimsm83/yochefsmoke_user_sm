import 'package:flutter/material.dart';
import 'package:ycsh/utils/asset_path.dart';
import 'package:ycsh/utils/sizer.dart';

class SplashBackground extends StatelessWidget {
  final Widget child;
  const SplashBackground({Key? key,required this.child,}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Container(
        width: AppSizer.getPerWidth(1),height: AppSizer.getPerHeight(1),
        decoration: const BoxDecoration(
            image: DecorationImage(image: AssetImage(AssetPath.SPLASH_BG),
                fit: BoxFit.cover)),
        child: SafeArea(child: child),
    );
  }
}

class CustomBackground extends StatelessWidget {
  final Widget child;

  const CustomBackground({Key? key,required this.child,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: AppColor.COLOR_GREY1,
      child: SafeArea(child: child,),);
  }
}