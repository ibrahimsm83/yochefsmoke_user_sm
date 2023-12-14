import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:ycsh/model/payment.dart';
import 'package:ycsh/service/image_chooser.dart';
import 'package:ycsh/utils/asset_path.dart';
import 'package:ycsh/utils/constants.dart';
import 'package:ycsh/utils/sizer.dart';
import 'package:ycsh/utils/strings.dart';
import 'package:ycsh/widget/button.dart';
import 'package:ycsh/widget/common.dart';
import 'package:ycsh/widget/icons.dart';

class PaymentContainer extends StatelessWidget {
  final bool selected;
  final void Function()? onTap;
  final String text1;
  final String? text2;
  final String icon;
  const PaymentContainer(
      {Key? key,
      this.selected = false,
      this.onTap,
      this.text1 = "",
      required this.icon,
      this.text2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double radius = AppSizer.getRadius(AppDimen.ADDRESS_CON_RADIUS);
    final double diameter = AppSizer.getHeight(27);
    final double imgHeight = AppSizer.getHeight(60);
    final double padd = AppSizer.getHeight(15);
    return GestureDetector(
      onTap: onTap,
      child: ShadowContainer(
        radius: radius,
        child: Container(
          padding: EdgeInsets.symmetric(
              vertical: AppSizer.getHeight(10),
              horizontal: AppSizer.getWidth(10)),
          decoration: const BoxDecoration(color: AppColor.COLOR_WHITE),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(padd),
                width: imgHeight,
                height: imgHeight,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(radius),
                    color: AppColor.COLOR_GREY9),
                child: CustomImage(
                  image: icon,
                  imageType: ImageType.TYPE_ASSET,
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(
                width: AppSizer.getWidth(18),
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CustomText(
                    text: text1,
                    fontsize: 14,
                    fontweight: FontWeight.bold,
                  ),
                  SizedBox(
                    height: AppSizer.getHeight(5),
                  ),
                  Visibility(
                    visible: text2 != null,
                    child: CustomText(
                      text: text2 ?? "",
                      fontsize: 11,
                      fontcolor: AppColor.COLOR_GREY4,
                    ),
                  ),
                ],
              )),
              CircularButton(
                diameter: diameter,
                icon: selected ? AssetPath.ICON_TICK : null,
                color: AppColor.COLOR_RED1,
                border: const BorderSide(width: 1, color: AppColor.COLOR_GREY8),
                bgColor: AppColor.COLOR_TRANSPARENT,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CardContainer extends StatelessWidget {
  final void Function(bool selected)? onTap;
  final void Function()? onDelete;
  final CreditCard card;
  final bool selected;
  const CardContainer({
    Key? key,
    this.onDelete,
    this.onTap,
    required this.card,
    this.selected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double radius = AppSizer.getRadius(AppDimen.FOOD_CON_RADIUS);
    final double imgHeight = AppSizer.getHeight(60);
    final double padd = AppSizer.getHeight(15);
    return Slidable(
        endActionPane: ActionPane(
          //closeThreshold: 0.3,openThreshold: 0.1,
          dragDismissible: false,
          children: [],
          extentRatio: 0.20,
          //extentRatio: 0.5,
          motion: Padding(
            padding: EdgeInsets.only(left: AppSizer.getWidth(15)),
            child: Container(
              decoration: BoxDecoration(
                  color: AppColor.COLOR_RED_LIGHT,
                  borderRadius: BorderRadius.circular(radius)),
              alignment: Alignment.center,
              child: Builder(builder: (cont) {
                return CustomIconButton(
                  icon: IconDelete(
                    size: AppSizer.getHeight(20),
                    color: AppColor.COLOR_RED1,
                  ),
                  onTap: () {
                    onDelete?.call();
                    Slidable.of(cont)?.close();
                  },
                );
              }),
            ),
          ),
        ),
        child: GestureDetector(
          onTap: (){
            onTap?.call(selected);
          },
          child: ShadowContainer(
            radius: radius,
            child: Container(
              padding: EdgeInsets.symmetric(
                  vertical: AppSizer.getHeight(10),
                  horizontal: AppSizer.getWidth(10)),
              decoration: BoxDecoration(
                  color: selected?AppColor.THEME_COLOR_PRIMARY1
                  :AppColor.COLOR_WHITE),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(padd),
                    width: imgHeight,
                    height: imgHeight,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(radius),
                        color: AppColor.COLOR_GREY9),
                    child: const CustomImage(
                      image: AssetPath.ICON_CARD,
                      imageType: ImageType.TYPE_ASSET,
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(
                    width: AppSizer.getWidth(18),
                  ),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      CustomText(
                        text: card.type!,
                        fontsize: 14,
                        fontweight: FontWeight.bold,
                      ),
                      SizedBox(
                        height: AppSizer.getHeight(5),
                      ),
                      CustomText(
                        text: card.maskedNumber,
                        fontsize: 11,
                        fontcolor: AppColor.COLOR_GREY4,
                      ),
                /*      Visibility(
                        visible: text2 != null,
                        child: CustomText(
                          text: text2 ?? "",
                          fontsize: 11,
                          fontcolor: AppColor.COLOR_GREY4,
                        ),
                      ),*/
                    ],
                  )),
    /*              CircularButton(
                    diameter: diameter,
                    icon: selected ? AssetPath.ICON_TICK : null,
                    color: AppColor.COLOR_RED1,
                    border:
                        const BorderSide(width: 1, color: AppColor.COLOR_GREY8),
                    bgColor: AppColor.COLOR_TRANSPARENT,
                  ),*/
                ],
              ),
            ),
          ),
        ));
  }
}

class AddVoucherButton extends CustomButton {
  AddVoucherButton({
    Function()? onTap,
  }) : super(
            fontsize: 15,
            bgColor: AppColor.COLOR_GREY1,
            radius: AppSizer.getRadius(10),
            text: AppString.TEXT_ADD_VOUCHER,
            onTap: onTap,
            fontWeight: FontWeight.w600,
            textColor: AppColor.COLOR_RED1);

  @override
  Widget build(BuildContext context) {
    return DottedContainer(
        radius: radius!,
        color: AppColor.COLOR_GREY8,
        dashlength: 10,
        borderWidth: 2,
        child: super.build(context));
  }

  @override
  Widget get child {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconVoucher(
          size: AppSizer.getHeight(25),
        ),
        SizedBox(
          width: AppSizer.getWidth(10),
        ),
        super.child,
      ],
    );
  }
}
