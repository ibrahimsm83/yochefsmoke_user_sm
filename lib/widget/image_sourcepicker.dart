import 'package:flutter/material.dart';
import 'package:ycsh/utils/constants.dart';
import 'package:ycsh/utils/strings.dart';
import 'package:ycsh/widget/common.dart';

class ImageSourcePicker extends StatelessWidget {
  final bool isPdfFileAvailable;
  const ImageSourcePicker({
    this.isPdfFileAvailable = false,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.THEME_COLOR_PRIMARY1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Visibility(
              visible: isPdfFileAvailable,
              child: buildOption(context, AppString.TEXT_FILE)),
          buildOption(
            context,
            AppString.TEXT_IMAGE_GALLERY,
          ),
          buildOption(
            context,
            AppString.TEXT_IMAGE_CAMERA,
          ),
        ],
      ),
    );
  }

  Widget buildOption(
      BuildContext context,
      String text,
      ) {
    return Container(
      child: ElevatedButton(
        onPressed: () {
          Navigator.pop(context, text);
        },
        style: ElevatedButton.styleFrom(
            onPrimary: AppColor.THEME_COLOR_PRIMARY1,
            primary: AppColor.THEME_COLOR_SECONDARY,
            //splashFactory: InkRipple.splashFactory,
            shadowColor: Colors.redAccent,
            padding: const EdgeInsets.symmetric(vertical: 15),
            elevation: 10
          /*shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
             // side: BorderSide(width: 0,color: AppColors.TRANSPARENT_COLOR)
          )*/
        ),
        //    color: AppColor.COLOR_TRANSPARENT,
        child: Center(
            child: CustomText(
              text: text,
              fontcolor: AppColor.COLOR_WHITE,
            )),
      ),
    );
  }
}