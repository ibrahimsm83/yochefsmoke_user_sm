import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ycsh/utils/asset_path.dart';
import 'package:ycsh/utils/constants.dart';
import 'package:ycsh/utils/sizer.dart';
import 'package:ycsh/widget/common.dart';
import 'package:ycsh/widget/icons.dart';

mixin LoginFieldProps {
  TextEditingController? controller;
  late double radius,elevation;
  late String hinttext;
  String? prefixIcon;
  Widget? suffixIcon;
  String? Function(String? val)? onValidate;
  late bool hidden;
  List<TextInputFormatter>? inputFormatters;
  TextInputType? keyboardType;
  late Color bgColor,hintColor,textColor,focusedBorderColor,errorColor;
  int? maxLength;
  late bool expands;
  late TextAlign textAlign;
  TextAlignVertical? textAlignVertical;
  late BorderSide border;
  late double fontsize;
  late bool readOnly,autofocus;
  TextInputAction? textInputAction;
  void Function()? onTap;
  ValueChanged<String>? onSubmit;
  void Function(String val)? onChange;
  FocusNode? focusNode;


  void initialize({TextEditingController? controller,double radius=AppDimen.LOGIN_FIELD_RADIUS,
    String hinttext="",String? prefixIcon,String? Function(String? val)? onValidate,
    bool hidden=false,
    List<TextInputFormatter>? inputFormatters,TextInputType? keyboardType,
    Color bgColor=AppColor.COLOR_WHITE, Color hintColor=AppColor.COLOR_GREY1,
    Color textColor=AppColor.COLOR_BLACK,
    int? maxLength,bool expands=false,
    double fontsize=AppDimen.FONT_TEXT_FIELD,bool readOnly=false,TextInputAction? textInputAction,
    TextAlign textAlign=TextAlign.start,TextAlignVertical? textAlignVertical,
    Widget? suffixIcon,void Function()? onTap,double elevation=0,
    Function(String val)? onChange,FocusNode? focusNode,bool autofocus=false,
    ValueChanged<String>? onSubmit,Color focusedBorderColor=AppColor.THEME_COLOR_PRIMARY1,
    Color errorColor=AppColor.COLOR_RED1,
    BorderSide border= const BorderSide(width: 0,color: AppColor.COLOR_TRANSPARENT),}){
    this.controller=controller;
    this.radius=radius;
    this.hinttext=hinttext;
    this.prefixIcon=prefixIcon;
    this.onValidate=onValidate;
    this.hidden=hidden;
    this.inputFormatters=inputFormatters;
    this.keyboardType=keyboardType;
    this.bgColor=bgColor;
    this.hintColor=hintColor;
    this.textColor=textColor;
    this.maxLength=maxLength;
    this.expands=expands;
    this.fontsize=fontsize;
    this.readOnly=readOnly;
    this.textInputAction=textInputAction;
    this.textAlign=textAlign;
    this.textAlignVertical=textAlignVertical;
    this.suffixIcon=suffixIcon;
    this.border=border;
    this.onTap=onTap;
    this.elevation=elevation;
    this.onChange=onChange;
    this.focusNode=focusNode;
    this.autofocus=autofocus;
    this.onSubmit=onSubmit;
    this.focusedBorderColor=focusedBorderColor;
    this.errorColor=errorColor;
  }


}


class CustomField extends StatelessWidget with LoginFieldProps{

  //static const errorColor=AppColor.COLOR_RED1;

  CustomField({Key? key,TextEditingController? controller,
    double radius=AppDimen.LOGIN_FIELD_RADIUS,
    String hinttext="",String? prefixIcon,String? Function(String? val)? onValidate,
    bool hidden=false,
    Color iconColor=AppColor.THEME_COLOR_PRIMARY1,
    Color focusedBorderColor=AppColor.THEME_COLOR_PRIMARY1,
    Color errorColor=AppColor.COLOR_RED1,
    List<TextInputFormatter>? inputFormatters,TextInputType? keyboardType,
    Color bgColor=AppColor.COLOR_GREY1, int? maxLength,bool expands=false,
    bool autofocus=false,FocusNode? focusNode,ValueChanged<String>? onSubmit,
    double fontsize=AppDimen.FONT_TEXT_FIELD,
    bool readOnly=false,TextInputAction? textInputAction,
    TextAlign textAlign=TextAlign.start,
    Color textColor=AppColor.COLOR_BLACK,
    TextAlignVertical textAlignVertical=TextAlignVertical.center,
    Widget? suffixIcon,void Function()? onTap,double elevation=0,
    Color hintColor=AppColor.COLOR_GREY2,
    void Function(String val)? onChange,
    BorderSide border=BorderSide.none,}):
        super(key: key){
    initialize(controller: controller,radius: radius,hinttext: hinttext,prefixIcon: prefixIcon,
        onValidate: onValidate,hidden: hidden,inputFormatters: inputFormatters,keyboardType: keyboardType,
        bgColor: bgColor,maxLength: maxLength,expands: expands,fontsize: fontsize,readOnly: readOnly,
        textInputAction: textInputAction,
        autofocus:autofocus,focusNode: focusNode,
        textAlign: textAlign,textAlignVertical: textAlignVertical,
        onSubmit: onSubmit,textColor: textColor,
        suffixIcon: suffixIcon,border: border,onTap: onTap,
        onChange: onChange,errorColor: errorColor,
        focusedBorderColor:focusedBorderColor,
        hintColor: hintColor,elevation: elevation);
  }


  @override
  Widget build(BuildContext context) {
    return ShadowContainer(elevation: elevation,radius: radius,
      child: TextFormField(focusNode: focusNode,
        controller: controller,
        enabled: true,
        onChanged: onChange,
        onFieldSubmitted: onSubmit,
        onTap: onTap,autofocus: autofocus,
        textInputAction: textInputAction,
        readOnly: readOnly,
        validator: onValidate,
        maxLength: maxLength,
        obscureText: hidden,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        expands: expands,maxLines: expands?null:1,textAlign: textAlign,
        textAlignVertical: textAlignVertical,
        style: style,
        decoration: decoration,
      ),
    );
  }


  InputDecoration get decoration{
  //  final double font=AppSizer.getFontSize(fontsize);
    var border=enabledBorder;
    return InputDecoration(
        counterText: "",isCollapsed: false,
        isDense: true,
        contentPadding: contentPadding,
        border: border,
        enabledBorder: border,
        focusedBorder: focusedBorder,
        errorBorder: errorBorder,
        /*     focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
          borderSide: const BorderSide(width: width,color: AppColor.COLOR_RED1)
            ),*/
        filled: true,fillColor: bgColor,
        prefixIcon: prefixIcon!=null?buildPrefixIcon():null,
        suffixIcon: suffixIcon,
        suffixIconConstraints: const BoxConstraints(),
        prefixIconConstraints: const BoxConstraints(),
        hintText: hinttext,errorMaxLines: 4,
        hintStyle: hintstyle);
  }

  TextStyle get hintstyle{
    return TextStyle(fontSize: AppSizer.getFontSize(fontsize),
        // height: 1
        color: hintColor,
        fontFamily: FontFamily.PRIMARY
    );
  }

  TextStyle get style{
    return TextStyle(fontSize: AppSizer.getFontSize(fontsize),
        // height: 1
        color: textColor,
        fontFamily: FontFamily.PRIMARY
    );
  }

  InputBorder? get enabledBorder{
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius),
        borderSide: border);
  }

  InputBorder? get focusedBorder{
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius),
        borderSide: BorderSide(width: 2,color: focusedBorderColor));
  }

  InputBorder? get errorBorder{
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius),
        borderSide: BorderSide(width: 2,color: errorColor));
  }


  Widget buildPrefixIcon(){
    final double iconsize=AppSizer.getFontSize(fontsize+8);
  //  final double iconsize=AppSizer.getHeight(20);
    return Container(
      width: iconsize,height: iconsize,
      padding: EdgeInsets.symmetric(
        horizontal: AppSizer.getWidth(AppDimen.LOGINFIELD_ICON_HORZ_PADDING),),
      child: Center(
        child: CustomMonoIcon(icon: prefixIcon!,color: focusedBorderColor,
          size: iconsize,),
      ),
    );
  }

  EdgeInsets get contentPadding => EdgeInsets.symmetric(
      horizontal: prefixIcon!=null?0: AppSizer.getWidth(AppDimen.LOGINFIELD_HORZ_PADDING),
      vertical: AppSizer.getHeight(AppDimen.CUSTOMFIELD_VERT_PADDING)
  );


}


class LineField extends CustomField{
  LineField({TextEditingController? controller,String hinttext="",
    BorderSide border=const BorderSide(width: 2,color: AppColor.COLOR_BLACK),}):
        super(controller: controller,hinttext: hinttext,bgColor: AppColor.COLOR_TRANSPARENT,
          border: border,
          radius: 0);

  @override
  InputBorder? get enabledBorder{
    return UnderlineInputBorder(
        borderSide: border);
  }

  @override
  InputBorder? get focusedBorder {
    return UnderlineInputBorder(
        borderSide: BorderSide(width: 2,
            color: focusedBorderColor));
  }

  @override
  InputBorder? get errorBorder {
    return UnderlineInputBorder(
        borderSide: BorderSide(width: 2,
            color: errorColor));
  }

}

class CustomPasswordField extends StatefulWidget with LoginFieldProps{


  CustomPasswordField({TextEditingController? controller,String? prefixIcon,
    String? Function(String? val)? onValidate,Color bgColor=AppColor.COLOR_GREY1,
    String hinttext="",
    Color focusedBorderColor=AppColor.THEME_COLOR_PRIMARY1,
    BorderSide border= BorderSide.none,}){
    initialize(controller: controller,prefixIcon: prefixIcon,
        bgColor: bgColor,focusedBorderColor: focusedBorderColor,
        hinttext: hinttext,hidden: true,border: border,onValidate: onValidate);
  }

  @override
  State<StatefulWidget> createState() {
    return _CustomPasswordFieldState();
  }

}

class _CustomPasswordFieldState extends State<CustomPasswordField>{

  late bool hidden;

  @override
  void initState() {
    hidden=widget.hidden;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomField(controller: widget.controller,prefixIcon: widget.prefixIcon,
      hidden: hidden,border: widget.border,bgColor: widget.bgColor,
      focusedBorderColor: widget.focusedBorderColor,
      onValidate: widget.onValidate,
      hinttext: widget.hinttext,suffixIcon: buildSuffixIcon(),
    );
  }

  Widget buildSuffixIcon(){
   // final double iconsize=AppSizer.getFontSize((widget.fontsize+8));
    final double iconsize=AppSizer.getHeight(16);
    return GestureDetector(onTap: toggleHidden,
        child:Container(color: AppColor.COLOR_TRANSPARENT,
          padding: EdgeInsets.symmetric(
            horizontal: AppSizer.getWidth(AppDimen.LOGINFIELD_ICON_HORZ_PADDING),),
          child: SizedBox(
              width: iconsize,height: iconsize,
              child: Center(
                child: CustomMonoIcon(
            icon: hidden?AssetPath.ICON_EYE:AssetPath.ICON_EYE_CROSS,
            color: AppColor.COLOR_BLACK,size: iconsize,),
              )),
        )
    );
  }

  void toggleHidden(){
    setState(() {
      hidden=!hidden;
    });
  }

}