import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';

import 'constants.dart';

class AppNavigator{

  static void navigateTo(Widget widget,{Transition transition=Transition.native,
    int duration=AppInteger.STANDARD_DURATION_MILLI}){
    Get.to(widget,transition: transition,duration: Duration(milliseconds: duration));
  }

  static void navigateToReplace(Widget Function() navigate,{Transition transition=Transition.native,
    int duration=AppInteger.STANDARD_DURATION_MILLI}){
    Get.off(navigate,transition: transition,duration: Duration(milliseconds: duration));
  }
  static void navigateToReplaceAll(Widget Function() navigate,{Transition transition=Transition.native,
    int duration=AppInteger.STANDARD_DURATION_MILLI}){
    Get.offAll(navigate,transition: transition,duration: Duration(milliseconds: duration));
  }

  static void pop(){
    Get.back();
  }

}

class AppDialog {

  static Future<T?> showDialog<T>(Widget widget, {bool disable_back = false,
    bool barrierDismissible=false,bool scrollable=true,bool backDrop=true}) {
    return Get.generalDialog(
        barrierDismissible: barrierDismissible,
        // barrierLabel: barrierDismissible?"aaaaa":null,
        barrierColor: backDrop==true?const Color(0x88000000,):AppColor.COLOR_TRANSPARENT,
        transitionDuration: const Duration(milliseconds: AppInteger.STANDARD_DURATION_MILLI),

        pageBuilder: (context, anim1, anim2) {
          return widget;
        }, transitionBuilder: (context, anim1, anim2, child) {
      return ScaleTransition(
        scale: anim1, child: Opacity(
        opacity: anim1.value,
        child: WillPopScope(
          onWillPop: () async {
            return disable_back;
          },
          child: SafeArea(
            child: AlertDialog(
              scrollable: scrollable,
              backgroundColor: AppColor.COLOR_TRANSPARENT,
              contentPadding: EdgeInsets.zero,
              insetPadding: EdgeInsets.zero,
              /*   shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(radius),
                        topRight: Radius.circular(radius),)
                  ),*/
              //useMaterialBorderRadius: true,
              //  title: Center(child: VariableText(text:"Payment",weight: FontWeight.bold,),),
              content: child,
            ),
          ),
        ),
      ),);
    });
    // Get.dialog(widget)
  }


  static Future<T?> showPlainDialog<T>(Widget widget, {bool disable_back = false,bool backDrop=true,}) {
    return Get.generalDialog(
        barrierDismissible: false,
        barrierColor: backDrop?const Color(0x88000000,):AppColor.COLOR_TRANSPARENT,
        transitionDuration: const Duration(milliseconds: AppInteger.STANDARD_DURATION_MILLI),
        pageBuilder: (context, anim1, anim2) {
          return Center(
            child: Material(
                color: AppColor.COLOR_TRANSPARENT,
                child: widget),
          );
        }, transitionBuilder: (context, anim1, anim2, child) {
      return ScaleTransition(
        scale: anim1, child: Opacity(
        opacity: anim1.value,
        child: WillPopScope(
          onWillPop: () async {
            return disable_back;
          },
          child: SafeArea(
            child: child,
          ),
        ),
      ),);
    });
    // Get.dialog(widget)
  }

  static Future<T?> showBottomPanel<T>(BuildContext context,Widget widget,){
    return showModalBottomSheet<T>(context: context, backgroundColor: AppColor.COLOR_TRANSPARENT,
        enableDrag: false,
        builder: (con){
          return widget;
        });
  }

}