import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ycsh/utils/constants.dart';
import 'package:ycsh/utils/regex.dart';
import 'package:ycsh/utils/strings.dart';

class AppMessage{
  static void showMessage(String? message,{Toast length=Toast.LENGTH_LONG}){
    Fluttertoast.showToast(msg: message??"", toastLength: length,);
  }

  static void handleException(dynamic ex){
    print("new exception: $ex");
    showMessage(ex.toString());
  }

}

class FormValidator{

 /* static bool validateCustomForm(GlobalKey<CustomFormState> key,){
    bool value=key.currentState!.validate();
    return value;
  }*/

  static bool validateForm(GlobalKey<FormState> key,){
    bool value=key.currentState!.validate();
    return value;
  }

  static String? validateEmail(String value,){
    if(value.isEmpty)
    {
      return AppString.TEXT_EMAIL_EMPTY_ERROR;
    }
    else if(!RegExp(ValidationRegex.EMAIL_VALIDATION).hasMatch(value))
    {
      return AppString.TEXT_EMAIL_INVALID_ERROR;
    }
    return null;
  }

  static String? validatePassword(String value){
    if(value.isEmpty) {
      return AppString.TEXT_PASSWORD_EMPTY_ERROR;
    }
    else if(!RegExp(ValidationRegex.PASSWORD_VALIDATE).hasMatch(value)) {
      return AppString.TEXT_PASSWORD_INVALID_ERROR;
    }
    return null;
  }

  static String? validateConfirmPassword(String value,String password){
    if(value.isEmpty) {
      return AppString.TEXT_CONFIRM_PASSWORD_EMPTY_ERROR;
    }
    else if(value!=password) {
      return AppString.CONFIRM_PASSWORD_ERROR;
    }
    return null;
  }

  static String? validatePhone(String value){
    if(value.isEmpty) {
      return AppString.TEXT_PHONE_EMPTY_ERROR;
    }
    else if(value.length<AppInteger.PHONE_LENGTH) {
      return AppString.TEXT_PHONE_INVALID_ERROR;
    }
    return null;

  }

  static String? validateEmpty(String value,{String message=AppString.TEXT_FIELD_EMPTY_ERROR}){
    if(value.isEmpty) {
      return message;
    }
    return null;
  }

  static String? validateFieldEmpty(String value,String field){
    return validateEmpty(value,message: "$field can\'t be empty");
  }


  static String? validateOther(String text,{List<bool> conditions= const [],
    List<String> messages=const []}){
    for(int i=0;i<conditions.length;i++){
      if(!conditions[i]){
        return messages[i];
      }
    }
    return null;
  }

/* static String? validateConfirmPassword(String value,String pass){
    if(value.isEmpty) {
      return AppString.TEXT_CONFIRM_PASSWORD_EMPTY_ERROR;
    }
    else if(!RegExp(ValidationRegex.PASSWORD_VALIDATE).hasMatch(value))
    {
      return AppString.TEXT_CONFIRM_PASSWORD_INVALID_ERROR;
    }
    else if (value != pass) {
      return AppString.TEXT_PASSWORD_SAME_INVALID_ERROR;
    }
    return null;
  }*/
}