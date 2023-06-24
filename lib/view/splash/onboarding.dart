import 'package:flutter/material.dart';
import 'package:ycsh/service/image_chooser.dart';
import 'package:ycsh/utils/asset_path.dart';
import 'package:ycsh/utils/constants.dart';
import 'package:ycsh/utils/sizer.dart';
import 'package:ycsh/utils/strings.dart';
import 'package:ycsh/widget/background.dart';
import 'package:ycsh/widget/button.dart';
import 'package:ycsh/widget/common.dart';
import 'package:ycsh/widget/icons.dart';
import 'package:ycsh/widget/splash_items.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {

  final PageController controller=PageController();

  int selected=0;

  @override
  void initState() {
    controller.addListener(() {
      setState(() {

      });
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const int count=3;
    const double paddingHorz=10;
    final double conWith=AppSizer.getWidth(230);
    final double btnVertPadd=AppSizer.getHeight(10);
    return SplashBackground(child: Scaffold(
      backgroundColor: AppColor.COLOR_TRANSPARENT,
      body: Container(
        child: Stack(children: [
          Container(height: AppSizer.getPerHeight(0.5),width: AppSizer.getPerWidth(1),
            child: const CustomImage(image: AssetPath.ONBOARDING_BG,fit: BoxFit.cover,
              imageType: ImageType.TYPE_ASSET,),),

          Positioned.fill(
            child: Container(child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: PageView.builder(
                    controller:controller,
                    onPageChanged: (val){
                      selected=val;
                    },
                    itemBuilder: (con,ind){
                      return Container(//color: Colors.green,
                        child: Stack(
                          children: [
                            Positioned.fill(
                            //  top:AppSizer.getPerHeight(0.3),
                              child: Container(alignment:Alignment.bottomCenter,
                                  //width: AppSizer.getWidth(1),
                                  //color:Colors.green,
                                  //width:AppSizer.getPerWidth(1),
                                  child: CustomImage(imageType: ImageType.TYPE_ASSET,
                                    fit: BoxFit.cover,
                                    image: "assets/images/onboarding_pic${selected+1}.png",),
                              ),
                            ),
                            Container(height: AppSizer.getPerHeight(0.4),
                             // color:Colors.red,
                           //   padding: EdgeInsets.only(top: AppSizer.getHeight(60)),
                              width: AppSizer.getPerWidth(1),
                              alignment:Alignment.bottomCenter,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                Row(mainAxisSize:MainAxisSize.min,
                               //   crossAxisAlignment:CrossAxisAlignment.stretch,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                        //bottom: AppSizer.getHeight(paddingVert),
                                          right: AppSizer.getWidth(paddingHorz)),
                                      child: buildIconButton(AssetPath.ICON_ARROW_BACK,
                                          enabled: (selected>0 && selected<=2),
                                          onTap: (){
                                            if(selected>0){
                                              goTo(--selected);
                                            }
                                          }),
                                    ),
                                    selected<2?OnboardingContainer(
                                        width: conWith,
                                        text1: selected==0?AppString.TEXT_FAST_CONVENIENT:selected==1?
                                        AppString.TEXT_FAVOURITE_FOOD:"",
                                        text2: selected==0?AppString.TEXT_ORDER_WAY:
                                        selected==1?AppString.TEXT_MUST_EXPLAIN:""):
                                    Container(
                                      width:conWith,
                                      child: Column(
                                        crossAxisAlignment:CrossAxisAlignment.stretch,
                                        children: [
                                          Center(child: AppLogo(width: conWith*0.8,
                                            height: AppSizer.getHeight(120),)),
                                         //  Spacer(),
                                          SizedBox(height: AppSizer.getHeight(35),),
                                          CustomButton(text: AppString.TEXT_SIGNUP,
                                            padding: EdgeInsets.symmetric(vertical: btnVertPadd),),
                                          SizedBox(height: AppSizer.getHeight(15),),
                                          CustomButton(text: AppString.TEXT_LOGIN,
                                            bgColor: AppColor.COLOR_WHITE,
                                            padding: EdgeInsets.symmetric(vertical: btnVertPadd),
                                            border: const BorderSide(width: 1,color: AppColor.THEME_COLOR_PRIMARY1),),
                                        ],),),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        //bottom: AppSizer.getHeight(paddingVert),
                                          left: AppSizer.getWidth(paddingHorz)),
                                      child: buildIconButton(AssetPath.ICON_ARROW_FORWARD,
                                          enabled: selected>=0 && selected<2,
                                          onTap: (){
                                            if(selected<2) {
                                              goTo(++selected);
                                            }
                                          }),
                                    ),
                                  ],
                                ),
                                Visibility(
                                  visible:selected==0,
                                  child: Padding(
                                    padding: EdgeInsets.only(top: AppSizer.getHeight(30)),
                                    child: CustomButton(text: AppString.TEXT_ENABLE_LOCATION,
                                      radius: AppSizer.getRadius(20),
                                      fontsize: 14, padding: EdgeInsets.symmetric(
                                          vertical: btnVertPadd,
                                          horizontal: AppSizer.getWidth(33)),),
                                  ),
                                ),
                              ],),
                            ),
                          ],
                        ),
                      );
                  },itemCount: count,),
                ),
              ],
            ),),
          ),
          Align(
            alignment: const FractionalOffset(0.5,0.45),
            child: Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(count, (index) {
            return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: buildDot(selected: index==selected,));
          }),),),
          selected<2?Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: EdgeInsets.only(top: AppSizer.getHeight(15),
                    right: AppSizer.getHeight(15)),
                child: CustomButton(text: AppString.TEXT_SKIP,fontWeight: FontWeight.normal,
                  fontsize: 12,radius: AppSizer.getRadius(6),
                  textColor: AppColor.COLOR_WHITE,padding: EdgeInsets.symmetric(
                      horizontal: AppSizer.getWidth(11),
                      vertical: AppSizer.getHeight(5)),
                  bgColor: AppColor.COLOR_BLACK,),
              )):Container(),
        ],),
      ),
    ),);
  }

  Widget buildIconButton(String icon,{void Function()? onTap,bool enabled=true,}){
    return CustomIconButton(icon: CustomMonoIcon(icon:icon,size: AppSizer.getHeight(20),
      color: enabled?AppColor.COLOR_RED1:AppColor.COLOR_TRANSPARENT,),
        onTap:enabled?onTap:null);
  }

  final double diameter=AppSizer.getHeight(8);

  Widget buildDot({bool selected=false}){
    //final double diameter=AppSizer.getHeight(20);
   // const double diameter=10;
    final double diam=!selected?diameter:diameter*1.7;
    return Container(width: diam,height: diam,
    decoration: BoxDecoration(color: selected?AppColor.COLOR_TRANSPARENT:
    AppColor.COLOR_BLACK,shape: BoxShape.circle,
        border: selected?Border.all(width: 1,color: AppColor.THEME_COLOR_PRIMARY1):
        const Border()),);
  }

  void goTo(int index){
    controller.animateToPage(index, duration: const Duration(milliseconds: AppInteger.SWIPE_DURATION_MILLI),
        curve: Curves.linear);
  }
}


class OnboardingContainer extends StatelessWidget {

  final String text1,text2;
  final double? width;
  const OnboardingContainer({Key? key,required this.text1,required this.text2,
    this.width,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(//color: Colors.red,
      width: AppSizer.getWidth(230),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
      CustomText(text: text1,fontsize: 30,fontweight: FontWeight.w900,
        textAlign: TextAlign.center,line_spacing: 1,),
      SizedBox(height: AppSizer.getHeight(15),),
          CustomText(text: text2,fontsize: 13,textAlign: TextAlign.center,),
    ],),);
  }
}
