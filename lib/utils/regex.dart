class ValidationRegex{

  static const String EMAIL_VALIDATION =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  static const String PASSWORD_VALIDATE = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';// to uncomment
  // static const String PASSWORD_VALIDATE = r'^([0-9]){2,4}$';
  // static const String PASSWORD_VALIDATE = r'^[0-9]+$';
  //static const String PASSWORD_VALIDATE = r'^[0-9].*$';// there is difference b/w * and .* and also + works which is e.* or e+
  //static const String PASSWORD_VALIDATE = r'^(([0-9]+)([a-z]+))|(([a-z]+)([0-9]+))$';
//  static const String PASSWORD_VALIDATE = r'^d+?$';
  // static const String PASSWORD_VALIDATE = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{1,}$';
  // static const String PASSWORD_VALIDATE = r'^\w+(?=[+])$';
  //static const String PHONE_VALIDATE = "^([0-9]{10,${AppInteger.PHONE_LENGTH}})\$";
  //static const String PHONE_VALIDATE = "^(\+([0-9]))\$";
  static const String PHONE_VALIDATE_SINGLE = r'^[0-9]$';
   static const String PHONE_FORMAT="+##############";
  //static const PHONE_FORMAT="+#(###)###-####";
  static const String CREDIT_CARD_FORMAT="#### #### #### ####";
  static const String CARD_DATE_FORMAT="##/####";
  //static const String TIME_DURATION_FORMAT="##:##:##";

}