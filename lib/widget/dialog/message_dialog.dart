import 'package:flutter/material.dart';
import 'package:ycsh/utils/constants.dart';
import 'package:ycsh/utils/navigation.dart';
import 'package:ycsh/utils/sizer.dart';
import 'package:ycsh/utils/strings.dart';
import 'package:ycsh/widget/button.dart';
import 'package:ycsh/widget/common.dart';

class MessageDialog extends StatelessWidget {
  final String message;
  final void Function()? onDone;
  const MessageDialog({Key? key,required this.message,this.onDone,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double padd=AppDimen.BTN_CLOSE_PADDING;
    return Container(
      decoration: const BoxDecoration(color: AppColor.COLOR_WHITE),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Align(alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.only(top: padd,right: padd),
              child: ButtonClose(color: AppColor.COLOR_BLACK,
                border: const BorderSide(width: 1,color: AppColor.COLOR_BLACK),
                onTap: (){
                  AppNavigator.pop();
                },),
            ),
          ),
          Padding(padding: EdgeInsets.symmetric(
              horizontal: AppSizer.getWidth(AppDimen.DASHBOARD_PADDING_HORZ)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: AppSizer.getHeight(10),),
                CustomText(text: message,fontsize: 14,fontweight: FontWeight.bold,),
                SizedBox(height: AppSizer.getHeight(15),),
                CustomButton(text: AppString.TEXT_OK,onTap: (){
                  AppNavigator.pop();
                  onDone?.call();
                },),
                SizedBox(height: AppSizer.getHeight(15),),
              ],),),

        ],),);
  }
}
