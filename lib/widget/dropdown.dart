import 'package:flutter/material.dart';
import 'package:ycsh/model/interface.dart';
import 'package:ycsh/utils/constants.dart';
import 'package:ycsh/utils/sizer.dart';
import 'package:ycsh/widget/common.dart';
import 'package:ycsh/widget/icons.dart';

class CustomDropdown extends StatelessWidget {
  final String hint;
  final List<DropDownItem>? items;
  final Function(DropDownItem? t) onValueChanged;
  final DropDownItem? selected_value;
  final double fontsize, elevation;
  late double _radius;
  final Color hintcolor;
  CustomDropdown(
      {this.hint = "",
        this.items,
        required this.onValueChanged,
        this.selected_value,
        this.hintcolor = AppColor.COLOR_GREY8,
        //    this.default_value,
        this.fontsize = AppDimen.FONT_TEXT_FIELD,
        this.elevation = 0,
        double? radius}) {
    _radius = radius ?? AppSizer.getRadius(AppDimen.LOGIN_FIELD_RADIUS);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: elevation),
      child: buildContainer(
        DropdownButtonHideUnderline(
            child: DropdownButton<DropDownItem>(
              //menuMaxHeight: 40,
              icon: buildArrow(),
              iconSize: iconsize,
              isDense: true,
              isExpanded: true, //alignment: Alignment.center,
              dropdownColor: dropdownColor,
              hint: CustomText(
                text: hint,
                fontsize: fontsize,
                fontcolor: hintcolor,
              ),
              value: selected_value,
              // isExpanded: true,
              // icon: Expanded(child:Container(child:Text("a"))),
              items: items != null
                  ? items!.map<DropdownMenuItem<DropDownItem>>((DropDownItem it) {
                return DropdownMenuItem(
                  value: it,
                  child: buildItem(
                    it.getText(),
                  ),
                );
              }).toList()
                  : [
                /*    DropdownMenuItem(
                  child: Center(child: const ContentLoading()),
                )*/
              ],
              onChanged: onValueChanged,
            )),
      ),
    );
  }

  final double iconsize=AppSizer.getHeight(18);

  Color get dropdownColor => AppColor.COLOR_WHITE;

  Widget buildItem(String it) {
    return CustomText(
      text: it,
      fontsize: fontsize,
      fontcolor: const Color(0xFF333333),
      //fontColor: AppColors.THEME_COLOR_WHITE,
    );
  }

  Widget buildContainer(Widget child) {
    return Container(
      //height: 20,
      padding: contentPadding,
      decoration: BoxDecoration(
          color: AppColor.COLOR_GREY1,
          borderRadius: BorderRadius.circular(_radius)),
      child: child,
    );
  }

  Widget buildArrow() {
    return IconDropdown(
      color: AppColor.COLOR_BLACK,
      size: iconsize,
    );
  }

  EdgeInsets get contentPadding => EdgeInsets.symmetric(
      horizontal: AppSizer.getWidth(AppDimen.LOGINFIELD_HORZ_PADDING),
      vertical: AppSizer.getHeight(AppDimen.DROPDOWN_VERT_PADDING));
}