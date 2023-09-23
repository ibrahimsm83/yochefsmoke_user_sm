import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ycsh/controller/user/controllers.dart';
import 'package:ycsh/model/payment.dart';
import 'package:ycsh/utils/actions.dart';
import 'package:ycsh/utils/asset_path.dart';
import 'package:ycsh/utils/constants.dart';
import 'package:ycsh/utils/navigation.dart';
import 'package:ycsh/utils/sizer.dart';
import 'package:ycsh/utils/strings.dart';
import 'package:ycsh/view/dashboard/payment/add_card.dart';
import 'package:ycsh/widget/app_bar.dart';
import 'package:ycsh/widget/background.dart';
import 'package:ycsh/widget/button.dart';
import 'package:ycsh/widget/common.dart';
import 'package:ycsh/widget/loader.dart';
import 'package:ycsh/widget/payment_items.dart';

class CardScreen extends StatefulWidget {
  const CardScreen({Key? key}) : super(key: key);

  @override
  State<CardScreen> createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  final PaymentController paymentController = Get.find<PaymentController>();

  @override
  void initState() {
    paymentController.loadAllCards();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double diameter = AppSizer.getHeight(50);
    return CustomBackground(
        child: Scaffold(
      floatingActionButton: CircularButton(
        icon: AssetPath.ICON_PLUS,
        bgColor: AppColor.THEME_COLOR_PRIMARY1,
        diameter: diameter,
        onTap: () {
          AppNavigator.navigateTo(AddCardScreen());
        },
      ),
      appBar: DashboardAppbar(
        text: AppString.TEXT_CARDS,
        leading: ButtonBack(
          onTap: () {
            AppNavigator.pop();
          },
        ),
      ),
      body: GetBuilder<PaymentController>(builder: (cont) {
        final List<CreditCard>? list = cont.cards;
        return list != null
            ? (list.isNotEmpty
                ? ListView.separated(
                    padding: EdgeInsets.symmetric(
                        vertical: AppDimen.SCROLL_OFFSET_PADDING_VERT,
                        horizontal:
                            AppSizer.getWidth(AppDimen.DASHBOARD_PADDING_HORZ)),
                    itemCount: list.length,
                    itemBuilder: (con, ind) {
                      var add = list[ind];
                      bool isDefault=add.id == cont.defaultCard?.id;
                      return CardContainer(
                          card: add,
                          selected: isDefault,
                          onDelete: () {
                            if(!isDefault){
                              cont.deleteCard(add);
                            }
                            else{
                              AppMessage.showMessage("Default card cannot be deleted");
                            }
                          },
                          onTap: (selected) {
                            if (!selected) {
                              cont.setDefaultCard(add);
                            }
                          });
                    },
                    separatorBuilder: (con, ind) {
                      return SizedBox(
                        height: AppSizer.getHeight(15),
                      );
                    },
                  )
                : const NotFoundText())
            : const ContentLoading();
      }),
    ));
  }
}
