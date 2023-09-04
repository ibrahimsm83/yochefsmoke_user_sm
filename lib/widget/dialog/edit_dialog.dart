import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ycsh/utils/constants.dart';
import 'package:ycsh/utils/navigation.dart';
import 'package:ycsh/utils/sizer.dart';
import 'package:ycsh/utils/strings.dart';
import 'package:ycsh/widget/button.dart';
import 'package:ycsh/widget/common.dart';
import 'package:ycsh/widget/textfield.dart';

class EditDialog extends StatefulWidget {

  final void Function(String val)? onSave;
  final String field,value;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  const EditDialog({Key? key,required this.field,this.onSave,this.inputFormatters,
    this.keyboardType=TextInputType.text, required this.value}) : super(key: key);

  @override
  State<EditDialog> createState() => _EditDialogState();
}

class _EditDialogState extends State<EditDialog> {

  late TextEditingController controller;


  @override
  void initState() {
    controller=TextEditingController(text:widget.value);
    super.initState();
  }

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
        CustomText(text: "Editing ${widget.field}",fontsize: 13,),
            SizedBox(height: AppSizer.getHeight(5),),
        CustomField(controller: controller,hinttext: widget.field,autofocus: true,
          keyboardType: widget.keyboardType,inputFormatters: widget.inputFormatters,),
          SizedBox(height: AppSizer.getHeight(15),),
        CustomButton(text: AppString.TEXT_SAVE,onTap: (){
          widget.onSave?.call(controller.text);
        },),
          SizedBox(height: AppSizer.getHeight(15),),
      ],),),

    ],),);
  }
}
