import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:ycsh/model/location.dart';
import 'package:ycsh/utils/actions.dart';
import 'package:ycsh/utils/constants.dart';
import 'package:ycsh/utils/navigation.dart';
import 'package:ycsh/utils/regex.dart';
import 'package:ycsh/utils/sizer.dart';
import 'package:ycsh/utils/strings.dart';
import 'package:ycsh/view/common/address_selection.dart';
import 'package:ycsh/view/registration/login.dart';
import 'package:ycsh/widget/button.dart';
import 'package:ycsh/widget/common.dart';
import 'package:ycsh/widget/login_items.dart';
import 'package:ycsh/widget/textfield.dart';

class SignupScreen extends LoginScreen {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  LoginScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends LoginScreenState {


  final TextEditingController fullname=TextEditingController(),
      phone=TextEditingController(),c_pass=TextEditingController();

  final MaskTextInputFormatter phoneFormattor=MaskTextInputFormatter(
      mask: ValidationRegex.PHONE_FORMAT);

  Location? location;

  @override
  String get title => AppString.TEXT_SIGNUP;

  @override
  Widget buildForm(double spacing) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        buildField(AppString.TEXT_FULLNAME,CustomField(controller: fullname,
          hinttext: AppString.TEXT_FULLNAME,
          onValidate: (val){
            return FormValidator.validateEmpty(val!);
          },),),
        SizedBox(height: spacing,),
        buildField(AppString.TEXT_EMAIL,CustomField(controller: email,
          keyboardType: TextInputType.emailAddress,
          hinttext: AppString.TEXT_EMAIL,
          onValidate: (val){
            return FormValidator.validateEmail(val!);
          },),),
        SizedBox(height: spacing,),
        buildField(AppString.TEXT_MOBILE_PHONE,CustomField(controller: phone,
          inputFormatters: [phoneFormattor],
          hinttext: AppString.TEXT_MOBILE_PHONE,keyboardType: TextInputType.phone,
          onValidate: (val){
            return FormValidator.validatePhone(val!);
          },),),
        SizedBox(height: spacing,),
        buildField(AppString.TEXT_PASSWORD,CustomPasswordField(
          //key: passkey,
            controller: pass,
            hinttext: AppString.TEXT_PASSWORD,
            onValidate: (val){
              return FormValidator.validatePassword(val!);
            }),),
        SizedBox(height: spacing,),
        buildField(AppString.TEXT_CONFIRM_PASSWORD,CustomPasswordField(
          //key: passkey,
            controller: c_pass,
            hinttext: AppString.TEXT_CONFIRM_PASSWORD,
            onValidate: (val){
              return FormValidator.validateConfirmPassword(val!,pass.text);
            }),),
        SizedBox(height: spacing,),
        buildField(AppString.TEXT_PRIMARY_LOCATION,LocationField(
          onTap: (){
            AppNavigator.navigateTo(AddressSelectionScreen(
              initial: location,
              onLocationSelected: (loc){
              setState(() {
                location=loc;
              });
            },));
          },
          hinttext: location!=null?location!.name:AppString.TEXT_ADD_LOCATION,
        ),),
        SizedBox(height: AppSizer.getHeight(25),),
        const CustomText(text: AppString.TEXT_BY_SIGNING_UP,
          fontsize: 12,textAlign: TextAlign.center,
          fontcolor: AppColor.COLOR_GREY2,),
        SizedBox(height: AppSizer.getHeight(35),),
        CustomButton(text: AppString.TEXT_SIGNUP,onTap: (){
          if(FormValidator.validateForm(validatorKey)){
            authController.signUp(fullname.text,email.text, pass.text,phone.text,
                location: location);
          }
        },),
    ],);
  }

  @override
  Widget buildBottom(){
    return Container();
  }

}
