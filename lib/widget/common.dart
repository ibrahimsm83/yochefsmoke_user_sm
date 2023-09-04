import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:ycsh/service/image_chooser.dart';
import 'package:ycsh/utils/asset_path.dart';
import 'package:ycsh/utils/constants.dart';
import 'package:ycsh/utils/sizer.dart';
import 'package:ycsh/utils/strings.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CustomText extends StatelessWidget {
  final String text;
  final Color? fontcolor;
  final TextAlign textAlign;
  final FontWeight fontweight;
  final bool underlined, linethrough;
  final String? fontFamily;
  final double fontsize;
  final double? line_spacing;
  final int? max_lines;
  final double textScaleFactor;
  final bool isSp, italic;
  //final double minfontsize,scalefactor,fontsize;

  const CustomText({
    Key? key,
    this.text = "",
    this.fontcolor = AppColor.COLOR_BLACK,
    this.fontsize = 15,
    this.textAlign = TextAlign.start,
    this.fontweight = FontWeight.normal,
    this.underlined = false,
    this.italic = false,
    this.line_spacing = 1.2,
    this.isSp = true,
    this.max_lines, //double line_spacing=1.2,
    this.fontFamily,
    this.linethrough = false,
    this.textScaleFactor = 1.0,
    // this.minfontsize=10,//this.scalefactor,
  }):super(key: key,);

  @override
  Widget build(BuildContext context) {
    //  double text_scale_factor=(media.size.width*media.size.height)/328190;
    //print("new text scale factor: ${text_scale_factor}");
    return Text(
      text, //textScaleFactor: textScaleFactor,
      maxLines: max_lines,
      overflow:
      max_lines != null ? TextOverflow.ellipsis : TextOverflow.visible,
      textAlign: textAlign,
      style: TextStyle(
        color: fontcolor, fontWeight: fontweight, height: line_spacing,
        fontStyle: italic ? FontStyle.italic : FontStyle.normal,
        fontSize: isSp ? AppSizer.getFontSize(fontsize) : fontsize,
        // fontSize: (fontsize*0.89).sp,
        fontFamily: fontFamily,
        decorationThickness: 2.0,
        decoration: underlined
            ? TextDecoration.underline
            : (linethrough ? TextDecoration.lineThrough : TextDecoration.none),
      ),
    );
  }
}

class CustomImage extends StatelessWidget {
  final String? image;
  final BoxFit fit;
  final String placeholder;
  final ImageType imageType;
  const CustomImage({
    this.image,
    this.fit = BoxFit.contain,
    this.imageType = ImageType.TYPE_ASSET,
    this.placeholder = AssetPath.IMAGE_CAMERA,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (con, cons) {
        final double width = cons.biggest.width;
        return Container(
          child: imageType == ImageType.TYPE_NETWORK
              ? CachedNetworkImage(
            imageUrl: image ?? "",
            fit: fit,
            placeholder: (con, img) {
              return Center(
                  child: Container(
                    width: 0.4 * width,
                    child: Image.asset(placeholder),
                  ));
            },
            errorWidget: (con, _, __) {
              return Center(
                  child: Container(
                      width: 0.4 * width,
                      child: Image.asset(placeholder)));
            },
          )
              : imageType == ImageType.TYPE_FILE
              ? Image.file(
            File(image ?? ""),
            fit: fit,
            errorBuilder: (_, __, ___) {
              return Center(
                  child: Container(
                      width: 0.4 * width,
                      child: Image.asset(placeholder)));
            },
          )
              : imageType == ImageType.TYPE_ASSET
              ? Image.asset(
            image ?? "",
            fit: fit,
          )
              : Container(),
        );
      },
    );
  }
}


class ShadowContainer extends StatelessWidget {
  final double elevation;
  final Widget child;
  final double radius;
  final bool enabledPadding;
  const ShadowContainer({
    Key? key,
    this.elevation = 5,
    required this.child,
    this.enabledPadding = false,
    this.radius = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(enabledPadding ? elevation : 0),
      child: Material(
        elevation: elevation,
        shadowColor: AppColor.COLOR_GREY3,
        color: AppColor.COLOR_TRANSPARENT,
        borderRadius: BorderRadius.circular(radius),
        clipBehavior: Clip.antiAlias,
        child: child,
      ),
    );
  }
}

class CustomCheckBox extends StatefulWidget {

  double? _size;
  final void Function(bool value) onValueChanged;
  final bool value;
  CustomCheckBox(
      {Key? key,
        double? size,
        this.value = false,
        required this.onValueChanged})
      : super(key: key) {
    _size = size ?? AppSizer.getHeight(AppDimen.CHECK_BOX_SIZE);
  }

  @override
  State<CustomCheckBox> createState() => _CustomCheckBoxState();
}

class _CustomCheckBoxState extends State<CustomCheckBox> {
  late bool check;

  @override
  void initState() {
    check = widget.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(//color: Colors.red,
      width: widget._size,height: widget._size,
      child: Checkbox(value: check,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          checkColor: AppColor.COLOR_GREY2,
          visualDensity: const VisualDensity(horizontal:-4,vertical: -4),
          side: const BorderSide(width: 2,color: AppColor.COLOR_GREY2),
          onChanged: (val){
        setState(() {
          check = !check;
          widget.onValueChanged(val!);
        });
      }),
    );
/*    return GestureDetector(
      onTap: () {
        setState(() {
          check = !check;
          widget.onValueChanged(check);
        });
      },
      child: Container(
        color: AppColor.COLOR_TRANSPARENT,
        width: widget._size,
        height: widget._size,
        child: CustomImage(
          image: check ? AssetPath.IMAGE_CHECKED : AssetPath.IMAGE_CHECK,
          imageType: ImageType.TYPE_ASSET,
        ),
      ),
    );*/
  }
}

class CustomRichText extends StatelessWidget {
  //final String text1,text2;
  final double fontSize;
  final TextAlign textAlign;
  final List<TextSpan> spans;
  final double linespacing;
  final String? fontFamily;
  final bool isSp;
  final FontWeight fontWeight;
  const CustomRichText({
    Key? key,
    required this.spans,
    this.fontSize = 15,
    this.linespacing = 1.2,
    this.textAlign = TextAlign.start,
    this.fontWeight = FontWeight.normal,
    this.fontFamily,
    this.isSp = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
        textAlign: textAlign,
        softWrap: true,
        text: TextSpan(
          style: TextStyle(
              color: AppColor.COLOR_BLACK,
              height: linespacing,
              fontFamily: fontFamily,
              fontWeight: fontWeight,
              fontSize: isSp ? AppSizer.getFontSize(fontSize) : fontSize),
          children: spans,
        ));
  }
}

class CustomSpan extends TextSpan {
  CustomSpan(
      {String text = "",
        Color fontColor = AppColor.COLOR_BLACK,
        FontWeight? fontWeight})
      : super(
      text: text,
      style: TextStyle(
        color: fontColor,
        fontWeight: fontWeight,
      ));
}

class DottedContainer extends StatelessWidget {

  final double dashlength,dashspacing;
  final Widget? child;
  final double? width,height;
  final double borderWidth;
  final double radius;
  final Color color;
  const DottedContainer({Key? key,this.dashlength=4,this.dashspacing=8,
    this.width,this.height,this.borderWidth=1,this.radius=0,
    this.color=AppColor.COLOR_BLACK,
    this.child,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(width: width,
      // height: height,
      child: DottedBorder(
        radius: Radius.circular(radius),
        color: color,
        strokeWidth: borderWidth,borderType: BorderType.RRect,
        borderPadding: EdgeInsets.zero,
        padding: EdgeInsets.symmetric(vertical: height??0,),
        strokeCap: StrokeCap.butt,
        dashPattern:[dashlength,dashspacing],
/*              customPath: (size){
                  print("size is: $size");
                  var path=Path();
                  path.moveTo(0, size.height);
                  path.lineTo(10, size.height);
                  return path;
                },*/
        child: child??Container(),
      ),
    );
  }
}

class NotFoundText extends StatelessWidget {
  const NotFoundText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: CustomText(text: AppString.TEXT_OBJECT_NOT_FOUND,fontsize: 13,),);
  }
}
