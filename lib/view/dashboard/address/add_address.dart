import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ycsh/controller/user/controllers.dart';
import 'package:ycsh/model/location.dart';
import 'package:ycsh/utils/actions.dart';
import 'package:ycsh/utils/asset_path.dart';
import 'package:ycsh/utils/constants.dart';
import 'package:ycsh/utils/navigation.dart';
import 'package:ycsh/utils/sizer.dart';
import 'package:ycsh/utils/strings.dart';
import 'package:ycsh/view/common/address_selection.dart';
import 'package:ycsh/widget/app_bar.dart';
import 'package:ycsh/widget/background.dart';
import 'package:ycsh/widget/button.dart';
import 'package:ycsh/widget/common.dart';
import 'package:ycsh/widget/login_items.dart';
import 'package:ycsh/widget/textfield.dart';

class AddAddressScreen extends StatefulWidget {
  const AddAddressScreen({Key? key}) : super(key: key);

  @override
  State<AddAddressScreen> createState() => AddAddressScreenState();
}

class AddAddressScreenState extends State<AddAddressScreen> {

  final GlobalKey<FormState> validatorKey=GlobalKey();

  final TextEditingController title=TextEditingController(),
      postal_code=TextEditingController(),city=TextEditingController(),
      state=TextEditingController(),country=TextEditingController();

  Location? location;

  final AddressController addressController=Get.find<AddressController>();

  String get btnText => AppString.TEXT_CREATE_ADDRESS;

  String get screenTitle => AppString.TEXT_ADD_ADDRESS;

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
          buildField(AppString.TEXT_TITLE, CustomField(
            controller: title,
            hinttext: AppString.TEXT_TITLE,
            onValidate: (val){
              return FormValidator.validateEmpty(val!);
            },)),
          SizedBox(height: spacing,),
          buildField(AppString.TEXT_CITY, CustomField(
            controller: city,
            hinttext: AppString.TEXT_CITY,
            onValidate: (val){
              return FormValidator.validateEmpty(val!);
            },)),
          SizedBox(height: spacing,),
          buildField(AppString.TEXT_STATE, CustomField(
            controller: state,
            hinttext: AppString.TEXT_STATE,
            onValidate: (val){
              return FormValidator.validateEmpty(val!);
            },)),
          SizedBox(height: spacing,),
          buildField(AppString.TEXT_COUNTRY, CustomField(
            controller: country,
            hinttext: AppString.TEXT_COUNTRY,
            onValidate: (val){
              return FormValidator.validateEmpty(val!);
            },)),
              SizedBox(height: spacing,),
              buildField(AppString.TEXT_POSTAL_CODE, CustomField(
                controller: postal_code,
                hinttext: AppString.TEXT_POSTAL_CODE,
                keyboardType: TextInputType.number,
             /*   onValidate: (val){
                  return FormValidator.validateEmpty(val!);
                },*/)),
              SizedBox(height: spacing,),
              buildField(AppString.TEXT_PRIMARY_LOCATION,LocationField(
                onTap: (){
                  AppNavigator.navigateTo(AddressSelectionScreen(
                    initial: location,
                    onLocationSelected: setLocation,));
                },
                hinttext: location!=null?location!.name:AppString.TEXT_ADD_LOCATION,
              ),),
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
    addressController.createAddress(title.text, city.text,
        state.text, country.text, postal_code.text,location: location);
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

  void setLocation(Location loc){
    print("loc name: ${loc.name}");
    setState(() {
      location=loc;
      postal_code.text=loc.postalCode;
      city.text=loc.city;
      state.text=loc.state;
      country.text=loc.country;
    });
  }
}
