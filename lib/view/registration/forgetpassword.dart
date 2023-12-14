import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ycsh/utils/actions.dart';
import 'package:ycsh/utils/strings.dart';
import 'package:ycsh/view/registration/login.dart';
import 'package:ycsh/widget/button.dart';
import 'package:ycsh/widget/common.dart';
import 'package:ycsh/widget/textfield.dart';

class ForgerPassword extends LoginScreen {
  const ForgerPassword({Key? key}) : super(key: key);

  @override
  LoginScreenState createState() => _ForgerPasswordState();
}

class _ForgerPasswordState extends LoginScreenState {
  TextEditingController otp = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  @override
  String get title => AppString.TEXT_FORGET_PASSWORD;

  @override
  Widget buildForm(double spacing) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        buildField(
          AppString.TEXT_EMAIL,
          CustomField(
            controller: email,
            keyboardType: TextInputType.emailAddress,
            hinttext: AppString.TEXT_EMAIL,
            onValidate: (val) {
              return FormValidator.validateEmail(val!);
            },
          ),
        ),
        SizedBox(
          height: spacing,
        ),
        CustomButton(
          text: AppString.TEXT_FORGET_PASSWORD,
          onTap: () async {
            if (FormValidator.validateForm(validatorKey)) {
              bool data = await authController.forgetPassword(email.text);
              if (data) {
                Get.bottomSheet(Container(
                  color: Colors.white,
                  height: 600,
                  padding: EdgeInsets.all(10),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        CustomText(
                          text: AppString.TEXT_RESET_PASSWORD,
                          fontweight: FontWeight.bold,
                          fontsize: 20,
                        ),
                        SizedBox(
                          height: spacing,
                        ),
                        buildField(
                          AppString.TEXT_OTP,
                          CustomField(
                            controller: otp,
                            keyboardType: TextInputType.emailAddress,
                            hinttext: AppString.TEXT_OTP,
                            onValidate: (val) {
                              return FormValidator.validateEmpty(val!);
                            },
                          ),
                        ),
                        SizedBox(
                          height: spacing,
                        ),
                        buildField(
                          AppString.TEXT_PASSWORD,
                          CustomPasswordField(
                              //key: passkey,
                              controller: password,
                              hinttext: AppString.TEXT_PASSWORD,
                              onValidate: (val) {
                                return FormValidator.validatePassword(val!);
                              }),
                        ),
                        SizedBox(
                          height: spacing,
                        ),
                        buildField(
                          AppString.TEXT_CONFIRM_PASSWORD,
                          CustomPasswordField(
                              //key: passkey,
                              controller: confirmPassword,
                              hinttext: AppString.TEXT_CONFIRM_PASSWORD,
                              onValidate: (val) {
                                return FormValidator.validateConfirmPassword(
                                    val!, password.text);
                              }),
                        ),
                        SizedBox(
                          height: spacing,
                        ),
                        CustomButton(
                          padding: EdgeInsets.all(20),
                          text: AppString.TEXT_RESET_PASSWORD,
                          onTap: () async {
                            if (FormValidator.validateForm(validatorKey)) {
                              bool data = await authController.changePassword(
                                  email.text,
                                  otp.text,
                                  password.text,
                                  confirmPassword.text);
                              if (data) {
                                Get.back();
                                Get.back();
                              }
                            }
                          },
                        )
                      ],
                    ),
                  ),
                ));
              }
            }
          },
        ),
      ],
    );
  }

  @override
  Widget buildBottom() {
    return Container();
  }
}
