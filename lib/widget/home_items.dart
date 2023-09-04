import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ycsh/model/product.dart';
import 'package:ycsh/service/image_chooser.dart';
import 'package:ycsh/utils/asset_path.dart';
import 'package:ycsh/utils/constants.dart';
import 'package:ycsh/utils/sizer.dart';
import 'package:ycsh/utils/strings.dart';
import 'package:ycsh/widget/button.dart';
import 'package:ycsh/widget/common.dart';
import 'package:ycsh/widget/textfield.dart';

class SearchField extends CustomField{
  SearchField({TextEditingController? controller,
    String hinttext="",void Function(String val)? onSubmit}):super(
      controller: controller,hinttext: hinttext,
    textInputAction: TextInputAction.search,
    prefixIcon: AssetPath.ICON_SEARCH,onSubmit: onSubmit,);
}


class CartButton extends CustomButton{
  CartButton({String text="",double horzPadd=0,void Function()? onTap,}):
        super(text: text,textColor: AppColor.COLOR_BLACK,
      fontsize: 11,padding: EdgeInsets.symmetric(vertical: AppSizer.getHeight(7),
          horizontal: horzPadd),onTap: onTap);
 /* @override
  EdgeInsets? get padding => EdgeInsets.symmetric(vertical: AppSizer.getHeight(7),);*/

}

class SpecialContainer extends StatelessWidget {

  final void Function()? onTap;
  const SpecialContainer({Key? key,this.onTap,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double radius=AppSizer.getRadius(AppDimen.FOOD_CON_RADIUS);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: AppSizer.getWidth(180),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(radius),
          color: AppColor.COLOR_TRANSPARENT,),
        clipBehavior: Clip.antiAlias,
        child: Stack(children: [
        Positioned.fill(/*child: ShaderMask(
          shaderCallback: (Rect bounds) {
            return LinearGradient(
              colors: [AppColor.COLOR_TRANSPARENT, AppColor.COLOR_BLACK.withOpacity(0.5)],
              begin: Alignment.center,
              end: Alignment.center,
            ).createShader(bounds);
*//*          return RadialGradient(
              center: Alignment.topLeft,
              radius: 1.0,
              colors: <Color>[AppColor.COLOR_BLACK, AppColor.COLOR_BLACK],
              tileMode: TileMode.mirror,
            ).createShader(bounds);*//*
          },blendMode: BlendMode.color,
          child:*/
          child:Container(
            child: CustomImage(image: AssetPath.IMAGE_SAMPLE2,
              fit: BoxFit.cover,),
          ),
        //)
        ),
        Positioned.fill(child: Container(
          color: AppColor.COLOR_BLACK.withOpacity(0.4),
        )),
        Container(padding: EdgeInsets.symmetric(
            horizontal: AppSizer.getWidth(20),vertical: AppSizer.getHeight(10)
        ),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            CustomText(text: "New Special Years",fontcolor: AppColor.COLOR_WHITE,
              fontweight: FontWeight.w500,fontsize: 16,),
            CartButton(text: AppString.TEXT_ORDER_NOW,horzPadd: AppSizer.getWidth(20)),
          ],),
        )
      ],),),
    );
  }
}

class MenuContainer extends StatelessWidget {

  final void Function()? onTap;
  final FoodCategory category;
  const MenuContainer({Key? key,this.onTap,required this.category,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double radius=AppSizer.getRadius(AppDimen.FOOD_CON_RADIUS);
    final double padd=AppSizer.getHeight(12);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: AppSizer.getWidth(130),
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(radius)),
        child: Stack(children: [
          Positioned.fill(child: CustomImage(image: category.image,
            fit: BoxFit.cover,imageType: ImageType.TYPE_NETWORK,)),
          Positioned.fill(child: Container(
            color: AppColor.COLOR_BLACK.withOpacity(0.1),
          )),
          Positioned(left: padd,bottom: padd,
            child: CustomText(text: "${category.name}",fontcolor: AppColor.COLOR_WHITE,
              fontweight: FontWeight.w600,fontsize: 14,),
          ),
        ],),
      ),
    );
  }
}


class FoodContainer extends StatelessWidget {

  final void Function()? onTap,onCartTap;
  final Product product;
  const FoodContainer({Key? key,this.onTap,required this.product,this.onCartTap,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double radius=AppSizer.getRadius(AppDimen.FOOD_CON_RADIUS);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(AppSizer.getHeight(10)),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(radius),
            color: AppColor.COLOR_GREY5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
          Expanded(
            child: Container(
              //height: AppSizer.getHeight(100),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(radius),
                  child:CustomImage(image: product.image,
                    fit: BoxFit.cover,imageType: ImageType.TYPE_NETWORK,)),),
          ),
          SizedBox(height: AppSizer.getHeight(10),),
          CustomText(text: "${product.name}",fontcolor: AppColor.COLOR_BLACK3,
            fontsize: 15,fontweight: FontWeight.bold,max_lines: 2,),
          SizedBox(height: AppSizer.getHeight(2),),
          CustomText(text: "${product.cook_type}",fontcolor: AppColor.COLOR_GREY4,max_lines: 1,
            fontsize: 10,),
          // Spacer(flex: 1,),
            SizedBox(height: AppSizer.getHeight(10),),
          Row(children: [
            CustomText(text: "\$${product.price}",fontcolor: AppColor.COLOR_BLACK3,
              fontweight: FontWeight.bold,fontsize: 15,),
            SizedBox(width: AppSizer.getWidth(25),),
            Expanded(child: CartButton(text: AppString.TEXT_ADD_TO_CART,onTap: onCartTap,)),
          ],),
        ],),
      ),
    );
  }
}
