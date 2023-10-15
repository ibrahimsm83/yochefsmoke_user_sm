import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:ycsh/controller/user/profile_controller.dart';
import 'package:ycsh/controller/user/dashboard_controller.dart';
import 'package:ycsh/model/address.dart';
import 'package:ycsh/model/location.dart';
import 'package:ycsh/service/image_chooser.dart';
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
import 'package:ycsh/widget/dialog/edit_dialog.dart';
import 'package:ycsh/widget/icons.dart';
import 'package:ycsh/widget/profile_items.dart';

class ProfileScreen extends StatefulWidget {

  final bool back_enabled;
  const ProfileScreen({Key? key,this.back_enabled=true,}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  late TextEditingController fullname,mobile;

  final DashboardController controller=Get.find<DashboardController>();

  final ProfileController addressController=Get.find<ProfileController>();

  final MaskTextInputFormatter phoneFormattor=MaskTextInputFormatter(
      mask: ValidationRegex.PHONE_FORMAT);

  String? image;
  ImageType imageType=ImageType.TYPE_NETWORK;

  Address? location;

  @override
  void initState() {
    fullname=TextEditingController(text: controller.user.fullname);
    mobile=TextEditingController(text: controller.user.phone);
    image=controller.user.image;
    location=controller.user.address;
    addressController.loadOrderCount();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return CustomBackground(safe: false,
      child: Scaffold(extendBodyBehindAppBar: true,
        appBar: DashboardAppbar(text: AppString.TEXT_PROFILE,
          leading: widget.back_enabled?ButtonBack(onTap: (){
          AppNavigator.pop();
        },):null,),
        body: LayoutBuilder(
          builder: (con,cons) {
            var size=cons.biggest;
            final double height=AppSizer.getHeight(265);
            final double padd=height-AppSizer.getHeight(15);
            final double height2=size.height-padd;
            return Container(//color: Colors.green,
              child: SingleChildScrollView(
                child: Container(width: AppSizer.getPerWidth(1),
                  child: Stack(
                    //crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(height:height,
                        child: Stack(
                          children: [
                            Positioned.fill(
                              child: Container(child: const CustomImage(
                                image:AssetPath.PROFILE_BG,
                                fit: BoxFit.cover,),),
                            ),
                            Positioned.fill(
                              top:AppSizer.getHeight(AppDimen.DASHBOARD_APPBAR_HEIGHT),
                              child: Column(children: [
                                SizedBox(height: AppSizer.getHeight(10),),
                                EditProfilePicture(image:image,imageType:imageType,
                                  onEdit: (){
                                  ImageChooser().pickImage(context,(path,type) {
                                    setState(() {
                                      image=path;
                                      imageType=ImageType.TYPE_FILE;
                                    });
                                    controller.editProfile(fullname.text,mobile.text,
                                        image: image,location: location,).then((value) {
                                      setState(() {
                                        image=controller.user.image;
                                        imageType=ImageType.TYPE_NETWORK;
                                      });
                                    });
                                  },);
                                },),
                                SizedBox(height: AppSizer.getHeight(12),),
                                CustomText(text: "${controller.user.fullname}",
                                  fontcolor: AppColor.COLOR_BLACK,
                                  fontweight: FontWeight.bold,fontsize: 16,)
                              ],),
                            ),
                          ],
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(
                          top: padd),
                          child: buildBottom(height2)),
                    ],),
                ),),
            );
          }
        ),
      ),
    );
  }

  Widget buildStats(){
    final double radius=AppSizer.getRadius(12);
    return GetBuilder<ProfileController>(
      builder: (cont) {
        return ShadowContainer(radius: radius,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: AppSizer.getHeight(5)),
            color: AppColor.COLOR_WHITE,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
             //   buildStatContainer(AppString.TEXT_RATING, 4.5),
                buildStatContainer(AppString.TEXT_ORDER, cont.orderCount,border: false),
              //  buildStatContainer(AppString.TEXT_FOLLOWERS, 80,border: false),
              ],),
          ),);
      }
    );
  }

  Widget buildBottom(double height){
    final double radius=AppSizer.getRadius(AppDimen.BOTTOM_PANEL_RADIUS);
    final double horzPadd= AppSizer.getWidth(AppDimen.DASHBOARD_PADDING_HORZ),
        vertPadd=AppSizer.getHeight(AppDimen.DASHBOARD_NAVIGATION_BAR_HEIGHT);
    final double spacing=AppSizer.getHeight(20);
    return Container(
      child: Stack(
        children: [
          Padding(padding: EdgeInsets.only(top: AppSizer.getHeight(22),),
            child: Container(
              height: height,
              padding: EdgeInsets.fromLTRB(horzPadd,AppSizer.getHeight(40),
                  horzPadd,vertPadd),
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: AppColor.COLOR_GREY5,
                //color: Colors.blue,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(radius),topRight: Radius.circular(radius)),),
              child: Column(
                mainAxisSize: MainAxisSize.min,crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  buildFieldValue(AppString.TEXT_NAME,
                    EditField(controller:fullname,hinttext: AppString.TEXT_NAME,onEditTap: (){
                      AppDialog.showDialog(EditDialog(onSave: (val){
                        controller.editProfile(val,mobile.text,location: location).then((value) {
                          fullname.text=controller.user.fullname!;
                        });
                      },field: AppString.TEXT_NAME,value: fullname.text,));
                    },),),
                  SizedBox(height: spacing,),
                  buildFieldValue(AppString.TEXT_PHONE_NUMBER,
                    EditField(controller:mobile,
                      hinttext: AppString.TEXT_PHONE_NUMBER,onEditTap: (){
                      AppDialog.showDialog(EditDialog(keyboardType:TextInputType.phone,
                      inputFormatters: [phoneFormattor],
                      onSave: (val){
                        controller.editProfile(fullname.text,val,location: location).then((value) {
                          mobile.text=controller.user.phone!;
                        });
                      },field: AppString.TEXT_PHONE_NUMBER,value: mobile.text,));
                    },),),
                  SizedBox(height: spacing,),
                  buildFieldValue(AppString.TEXT_ADDRESS, Container(child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomText(text: AppString.TEXT_HOME,fontsize: 15,
                        fontweight: FontWeight.bold,),
                      Row(
                        children: [
                          Expanded(
                            child: CustomText(text: "${location?.location?.name}",
                            fontsize: 12,line_spacing: 1.6,),),
                          GestureDetector(
                            onTap: (){
                              AppNavigator.navigateTo(AddressSelectionScreen(
                                initial: location?.location,
                                onLocationSelected: (loc){
                                  var address=Address.fromHome(loc);
                                  controller.editProfile(fullname.text,mobile.text,
                                      location: address)
                                      .then((value) {
                                    setState(() {
                                      location=address;
                                    });
                                  });

                                },));
                            },
                            child: Container(color: AppColor.COLOR_TRANSPARENT,
                              padding: EdgeInsets.symmetric(horizontal: AppSizer.getWidth(
                                  AppDimen.LOGINFIELD_ICON_HORZ_PADDING)),
                              child: IconEdit(size: AppSizer.getHeight(12),),
                            ),
                          ),
                        ],
                      ),
                    ],),),),
                ],),),
          ),
          Align(
              alignment: Alignment.topCenter,
              child: buildStats()),
        ],
      ),
    );

  }

  Widget buildStatContainer(String field,num value,{bool border=true,}){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: AppSizer.getWidth(20),
          vertical: AppSizer.getHeight(5)),
      decoration: BoxDecoration(
          border: border?const Border(right: BorderSide(width: 1,
              color: AppColor.COLOR_GREY2)):
              const Border()
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
      CustomText(text: field,fontweight: FontWeight.bold,fontsize: 14,),
      SizedBox(height: AppSizer.getHeight(2),),
      CustomText(text: "$value",fontsize: 9,fontcolor: AppColor.COLOR_BLACK3,
        fontweight: FontWeight.w500,),
    ],),);
  }

  Widget buildFieldValue(String field,Widget value){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
      CustomText(text:field,fontcolor: AppColor.COLOR_BLACK3,fontsize: 12,
        fontweight: FontWeight.w500,
      ),
      SizedBox(height: AppSizer.getHeight(10),),
      value,
    ],);
  }

}
