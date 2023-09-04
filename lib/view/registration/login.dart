import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ycsh/controller/auth_controller.dart';
import 'package:ycsh/utils/actions.dart';
import 'package:ycsh/utils/asset_path.dart';
import 'package:ycsh/utils/constants.dart';
import 'package:ycsh/utils/navigation.dart';
import 'package:ycsh/utils/sizer.dart';
import 'package:ycsh/utils/strings.dart';
import 'package:ycsh/view/dashboard/dashboard.dart';
import 'package:ycsh/view/registration/signup.dart';
import 'package:ycsh/widget/app_bar.dart';
import 'package:ycsh/widget/background.dart';
import 'package:ycsh/widget/button.dart';
import 'package:ycsh/widget/common.dart';
import 'package:ycsh/widget/login_items.dart';
import 'package:ycsh/widget/textfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {

  bool _checked=false;

  String get title=>AppString.TEXT_SIGNIN;

  final TextEditingController email=TextEditingController(),
      pass=TextEditingController();

  final GlobalKey<FormState> validatorKey=GlobalKey();

  final AuthController authController=Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    var media=MediaQuery.of(context);
    final double spacing=AppSizer.getHeight(22);
    return CustomBackground(child: Scaffold(
      appBar: TransparentAppbar(leading: ButtonBack(onTap: (){
        AppNavigator.pop();
      },),),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: AppSizer.getWidth(AppDimen.LOGIN_PADDING_HORZ)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                    vertical: AppDimen.SCROLL_OFFSET_PADDING_VERT),
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                CustomText(text: title,fontweight: FontWeight.bold,fontsize: 20,),
                SizedBox(height: AppSizer.getHeight(45),),
                Form(
                    key: validatorKey,
                    child: buildForm(spacing,)),
              ],),),
            ),
            Visibility(
                visible: media.viewInsets.bottom == 0.0,
                child: buildBottom()),
          ],
        ),
      ),
    ));
  }

  Widget buildForm(double spacing){
    const double fontsize=12;
    final double space=AppSizer.getHeight(10);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        buildField(AppString.TEXT_EMAIL,CustomField(controller: email,
          keyboardType: TextInputType.emailAddress,
          hinttext: AppString.TEXT_EMAIL,
          onValidate: (val){
            return FormValidator.validateEmail(val!);
          },),),

      SizedBox(height: spacing,),
        buildField(AppString.TEXT_PASSWORD,CustomPasswordField(
          //key: passkey,
            controller: pass,
            hinttext: AppString.TEXT_PASSWORD,
            onValidate: (val){
              return FormValidator.validatePassword(val!);
            }),),
        SizedBox(height: AppSizer.getHeight(12),),
      Row(children: [
        Expanded(
          child: Row(children: [
            CustomCheckBox(value:_checked,onValueChanged: (val){
              _checked=val;
            }),
            SizedBox(width: AppSizer.getWidth(7),),
            Flexible(child: const CustomText(text: AppString.TEXT_REMEMBER_PASSWORD,
              fontsize: fontsize,fontcolor: AppColor.COLOR_GREY2,)),
          ],),
        ),
        TappableText(text: AppString.TEXT_FORGET_PASSWORD,fontsize:fontsize,
          fontcolor: AppColor.COLOR_BLACK2,
          onTap: (){
        },),
      ],),
        //SizedBox(height: AppSizer.getHeight(28),),
        SizedBox(height: AppSizer.getHeight(80),),
      CustomButton(text: AppString.TEXT_SIGNIN,onTap: (){
        if(FormValidator.validateForm(validatorKey)){
          authController.login(email.text, pass.text);
        }
      },),
     /*   SizedBox(height: AppSizer.getHeight(25),),
      Center(child: const CustomText(text: AppString.TEXT_OR,fontsize: 13,
        fontcolor: AppColor.COLOR_GREY2,)),
        SizedBox(height: AppSizer.getHeight(25),),
      SocialLoginButton(icon: AssetPath.ICON_GOOGLE,text: AppString.TEXT_LOGIN_GOOGLE,
        bgColor: AppColor.COLOR_BLUE1,),
        SizedBox(height: space,),
      SocialLoginButton(icon: AssetPath.ICON_FACEBOOK,text: AppString.TEXT_LOGIN_FACEBOOK,
      bgColor: AppColor.COLOR_BLUE2,),
        SizedBox(height: space,),
      SocialLoginButton(icon: AssetPath.ICON_APPLE,text: AppString.TEXT_LOGIN_APPLE,),*/
    ],);
  }

  Widget buildField(String field,Widget value){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
      CustomText(text: field,fontsize: 13,fontweight: FontWeight.w500,),
      const SizedBox(height: 5,),
      value,
    ],);
  }

  Widget buildBottom(){
    return LoginBottomField(
      text1: AppString.TEXT_DONT_HAVE_ACCOUNT,
      text2: AppString.TEXT_SIGNUP_NOW,
      onTap: () {
        AppNavigator.navigateTo(SignupScreen());
      },
    );
  }
}
