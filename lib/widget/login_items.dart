import 'package:flutter/material.dart';
import 'package:ycsh/service/image_chooser.dart';
import 'package:ycsh/utils/asset_path.dart';
import 'package:ycsh/utils/constants.dart';
import 'package:ycsh/utils/sizer.dart';
import 'package:ycsh/utils/strings.dart';
import 'package:ycsh/widget/button.dart';
import 'package:ycsh/widget/common.dart';
import 'package:ycsh/widget/icons.dart';
import 'package:ycsh/widget/textfield.dart';

class LoginBottomField extends StatelessWidget {
  final String text1, text2;
  final Color text2Color;
  final void Function()? onTap;
  final EdgeInsets padding;
  const LoginBottomField({
    Key? key,
    this.text1 = "",
    this.text2 = "",
    this.onTap,
    this.padding = const EdgeInsets.symmetric(
      vertical: 20,
    ),
    this.text2Color = AppColor.COLOR_BLUE3,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double fontsize = 13;
    return Container(
      padding: padding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        // mainAxisSize: MainAxisSize.min,
        children: [
          CustomText(
            text: text1 + " ",
            fontsize: fontsize,
            fontweight: FontWeight.w500,
            fontcolor: AppColor.COLOR_GREY2,
          ),
          TappableText(
            text: text2,
            fontcolor: text2Color,
            fontsize: fontsize,
            onTap: onTap,
          ),
        ],
      ),
    );
  }
}

class TappableText extends CustomText {
  final void Function()? onTap;
  const TappableText({
    Key? key,
    required String text,
    this.onTap,
    Color fontcolor = Colors.black,
    double fontsize = 15,
    TextAlign textAlign = TextAlign.start,
    FontWeight fontweight = FontWeight.normal,
    bool underlined = false,
    bool italic = false,
    double line_spacing = 1.2,
    bool isSp = true,
    int? max_lines, //double line_spacing=1.2,
    String? fontFamily,
    bool linethrough = false,
    double textScaleFactor = 1.0,
  }) : super(
          key: key,
          text: text,
          fontcolor: fontcolor,
          fontsize: fontsize,
          textAlign: textAlign,
          fontweight: fontweight,
          underlined: underlined,
          italic: italic,
          line_spacing: line_spacing,
          isSp: isSp,
          max_lines: max_lines,
          fontFamily: fontFamily,
          linethrough: linethrough,
          textScaleFactor: textScaleFactor,
        );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
          color: AppColor.COLOR_TRANSPARENT,
          child: super.build(context),
        ));
  }
}

class SocialLoginButton extends CustomButton {
  final String? icon;
  SocialLoginButton(
      {String text = "",
      Color textColor = AppColor.COLOR_WHITE,
      Function()? onTap,
      double? radius,
      Color bgColor = AppColor.COLOR_BLACK,
      this.icon})
      : super(
          text: text,
          textColor: textColor,
          onTap: onTap,
          radius: radius,
          bgColor: bgColor,
          fontsize: AppDimen.FONT_BUTTON,
        );

  @override
  EdgeInsets? get padding => EdgeInsets.symmetric(
      horizontal: AppSizer.getWidth(22), vertical: AppSizer.getHeight(10));

  @override
  Widget get child {
    //final double size=AppSizer.getFontSize(fontsize+4);
    final double size = AppSizer.getHeight(26);
    return Row(
      //mainAxisAlignment: MainAxisAlignment.center,
      children: [
        icon != null
            ? Padding(
                padding: EdgeInsets.only(right: AppSizer.getWidth(0)),
                child: Container(
                    //color: Colors.red,
                    width: size,
                    height: size,
                    child: CustomImage(
                      image: icon!,
                      imageType: ImageType.TYPE_ASSET,
                    )),
              )
            : Container(),
        Expanded(
          child: CustomText(
            text: text,
            fontcolor: textColor,
            fontweight: FontWeight.w600,
            fontsize: fontsize,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}

class LocationField extends CustomField {
  LocationField(
      {Key? key,
      TextEditingController? controller,
      String hinttext = "",
      void Function()? onTap})
      : super(
            key: key,
            controller: controller,
            prefixIcon: AssetPath.ICON_ADD,
            hinttext: hinttext,
            onTap: onTap,
            readOnly: true,
            hintColor: AppColor.COLOR_BLACK);

  @override
  TextStyle get hintstyle => TextStyle(
        color: hintColor,
        fontFamily: FontFamily.PRIMARY,
        fontWeight: FontWeight.bold,
      );

  @override
  Widget? get suffixIcon {
    final double iconsize = AppSizer.getHeight(12);
    return Padding(
        padding: EdgeInsets.symmetric(
            horizontal: AppSizer.getWidth(AppDimen.LOGINFIELD_ICON_HORZ_PADDING)
            //  vertical: 10
            ),
        child: Container(//alignment:Alignment.centerRight,
          width: iconsize,height: iconsize,
          child: Center(
            child: CustomMonoIcon(
              icon: AssetPath.ICON_ARROW_FORWARD,
              color: AppColor.COLOR_RED1,
              size: iconsize,
            ),
          ),
        ));
  }

  @override
  Widget buildPrefixIcon(){
    //final double iconsize=AppSizer.getFontSize(fontsize+8);
    final double iconsize=AppSizer.getHeight(44);
    return Container(//color: AppColor.COLOR_RED1,
      width: iconsize,height: iconsize,
      padding: EdgeInsets.symmetric(
        horizontal: AppSizer.getWidth(AppDimen.LOGINFIELD_ICON_HORZ_PADDING),),
      child: Center(
        child: CustomMonoIcon(icon: prefixIcon!,color: AppColor.COLOR_RED1,
          size: iconsize,),
      ),
    );
  }
}
