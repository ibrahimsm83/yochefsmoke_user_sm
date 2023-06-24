import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppSizer{

  static double getRadius(double val){
    return val.r;
  }

  static double getFontSize(double val){
    return val.sp;
  }

  static double getWidth(double val){
    return val.w;
  }

  static double getHeight(double val){
    return val.h;
  }

  static double getPerWidth(double val){
    return val.sw;
  }

  static double getPerHeight(double val){
    return val.sh;
  }

}