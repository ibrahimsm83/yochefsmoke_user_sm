import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:ycsh/controller/user/controllers.dart';
import 'package:ycsh/model/location.dart';
import 'package:ycsh/utils/actions.dart';
import 'package:ycsh/utils/asset_path.dart';
import 'package:ycsh/utils/constants.dart';
import 'package:ycsh/utils/navigation.dart';
import 'package:ycsh/utils/regex.dart';
import 'package:ycsh/utils/sizer.dart';
import 'package:ycsh/utils/strings.dart';
import 'package:ycsh/view/common/address_selection.dart';
import 'package:ycsh/widget/app_bar.dart';
import 'package:ycsh/widget/background.dart';
import 'package:ycsh/widget/button.dart';
import 'package:ycsh/widget/common.dart';
import 'package:ycsh/widget/login_items.dart';
import 'package:ycsh/widget/textfield.dart';

class AddCardScreen extends StatefulWidget {
  const AddCardScreen({Key? key}) : super(key: key);

  @override
  State<AddCardScreen> createState() => AddCardScreenState();
}

class AddCardScreenState extends State<AddCardScreen> {

  final GlobalKey<FormState> validatorKey=GlobalKey();

  final TextEditingController card_num=TextEditingController(),
      card_expiry=TextEditingController(),
      card_cvv=TextEditingController();

  final MaskTextInputFormatter cardFormattor=MaskTextInputFormatter(
      mask: ValidationRegex.CREDIT_CARD_FORMAT),cardDateFormattor=MaskTextInputFormatter(
      mask: ValidationRegex.CARD_DATE_FORMAT);

  Location? location;

  final PaymentController paymentController=Get.find<PaymentController>();

  String get btnText => AppString.TEXT_SAVE_CARD;

  String get screenTitle => AppString.TEXT_ADD_CARD;

  @override
  void initState() {
    onInit();
    super.initState();
  }

  void onInit(){

  }

  @override
  Widget build(BuildContext context) {
    final double spacing=AppSizer.getHeight(22);
    return CustomBackground(child: Scaffold(
      appBar: DashboardAppbar(text: screenTitle,
        leading: ButtonBack(onTap: (){
          AppNavigator.pop();
        },),),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
            horizontal: AppSizer.getWidth(AppDimen.DASHBOARD_PADDING_HORZ),
            vertical: AppSizer.getHeight(AppDimen.SCROLL_OFFSET_PADDING_VERT)
        ),
        child: Form(
          key: validatorKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              buildField(AppString.TEXT_CARD_NUMBER, CustomField(
                controller: card_num,
                keyboardType: TextInputType.number,
                hinttext: AppString.TEXT_CARD_NUMBER,
                inputFormatters: [
                  cardFormattor,
                ],
                onValidate: (val){
                  return FormValidator.validateCreditCard(val!);
                },)),
              SizedBox(height: spacing,),
              Row(
                children: [
                  Expanded(
                    child: buildField(AppString.TEXT_CARD_EXPIRY, CustomField(
                      controller: card_expiry,
                      inputFormatters: [
                        cardDateFormattor,
                      ],
                      keyboardType: TextInputType.number,
                      hinttext: AppString.TEXT_CARD_EXPIRY,
                      onValidate: (val){
                        return FormValidator.validateEmpty(val!);
                      },)),
                  ),
                  SizedBox(width: AppSizer.getWidth(15),),
                  Expanded(
                    child: buildField(AppString.TEXT_CVV, CustomField(
                      controller: card_cvv,
                      keyboardType: TextInputType.number,
                      hinttext: AppString.TEXT_CVV,
                      maxLength: 4,
                      onValidate: (val){
                        return FormValidator.validateEmpty(val!);
                      },)),
                  ),
                ],
              ),
              SizedBox(height: AppSizer.getHeight(35),),
              CustomButton(text: btnText,onTap: (){
                if(FormValidator.validateForm(validatorKey)){
                  submit();
                }
              },),
            ],),
        ),),
    ));
  }

  void submit(){
    try {
      final List<String> expiry = card_expiry.text.split("/");
      final card_numm=cardFormattor.unmaskText(card_num.text);
      paymentController.createCard(card_numm, expiry[0], expiry[1],
          card_cvv.text);
    }
    catch(ex){
      AppMessage.showMessage("Invalid Card Format");
    }
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

}
