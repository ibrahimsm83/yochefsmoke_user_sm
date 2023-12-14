import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ycsh/controller/user/controllers.dart';
import 'package:ycsh/model/page_model.dart';
import 'package:ycsh/model/product.dart';
import 'package:ycsh/utils/constants.dart';
import 'package:ycsh/utils/navigation.dart';
import 'package:ycsh/utils/sizer.dart';
import 'package:ycsh/utils/strings.dart';
import 'package:ycsh/view/dashboard/Profile/profile.dart';
import 'package:ycsh/view/dashboard/home/menu_category.dart';
import 'package:ycsh/widget/app_bar.dart';
import 'package:ycsh/widget/button.dart';
import 'package:ycsh/widget/common.dart';
import 'package:ycsh/widget/home_items.dart';
import 'package:ycsh/widget/loader.dart';
import 'package:ycsh/widget/pagenation/paged_gridview.dart';
import 'package:ycsh/widget/pagenation/paged_view.dart';
import 'package:ycsh/widget/profile_items.dart';

import 'product_detail.dart';

class HomeScreen extends StatefulWidget {
  final void Function()? onOpenDrawer;
  const HomeScreen({Key? key,this.onOpenDrawer,}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final double paddHorz=AppSizer.getHeight(AppDimen.DASHBOARD_PADDING_HORZ);

  final DashboardController controller=Get.find<DashboardController>();

  final ProductController productController=Get.find<ProductController>();
  final CartController cartController=Get.find<CartController>();

  final TextEditingController searchController=TextEditingController();

  final GlobalKey<PagedViewState> pageKey=GlobalKey();

  @override
  void initState() {
    productController.loadAllFoodCategories();
    //productController.loadRecentProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final double spacing=AppSizer.getHeight(20);
    final double gridSpacing=AppSizer.getHeight(15);
    return Scaffold(appBar: LogoAppbar(leading: ButtonDrawer(onTap: widget.onOpenDrawer,),
      action: GestureDetector(
          onTap: (){
            AppNavigator.navigateTo(ProfileScreen());
          },
          child: CircularPic(image: controller.user.image,
              diameter: AppSizer.getHeight(AppDimen.APPBAR_PROF_PIC_SIZE,))),),
    body: Column(children: [
      Padding(padding: EdgeInsets.symmetric(horizontal: paddHorz),
        child: SearchField(hinttext: AppString.TEXT_SEARCH_FOOD,
          controller: searchController,onSubmit: (val){
           // print("aaaa ");
            pageKey.currentState?.refresh();
          },),),
      Expanded(
        child: RefreshIndicator(
          onRefresh: () async{
            pageKey.currentState?.refresh();
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.only(top: AppDimen.SCROLL_OFFSET_PADDING_VERT,
                bottom: AppDimen.SCROLL_OFFSET_PADDING_VERT+
                    AppSizer.getHeight(AppDimen.DASHBOARD_NAVIGATION_BAR_HEIGHT)),
            child: Column(children: [
   /*         Container(height: AppSizer.getHeight(115),
                child: ListView.separated(
                    padding: EdgeInsets.symmetric(horizontal: paddHorz,),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (con,ind){
                  return SpecialContainer(onTap: (){
                    AppNavigator.navigateTo(EventScreen());
                  },);
                }, separatorBuilder: (con,ind){
                  return SizedBox(width: AppSizer.getWidth(18),);
                }, itemCount: 5),),
              SizedBox(height: spacing,),*/
              buildFieldValue(AppString.TEXT_MENU,Container(height: AppSizer.getHeight(100),
                child: GetBuilder<ProductController>(
                  builder: (cont) {
                    final List<FoodCategory>? list=cont.categories;
                    return list!=null?(list.isNotEmpty?ListView.separated(
                        padding: EdgeInsets.symmetric(horizontal: paddHorz,),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (con,ind){
                          var menu=list[ind];
                          return MenuContainer(category:menu,onTap: (){
                            AppNavigator.navigateTo(MenuCategoryScreen());
                          },);
                        }, separatorBuilder: (con,ind){
                      return SizedBox(width: AppSizer.getWidth(10),);
                    }, itemCount: list.length):const NotFoundText()):const ContentLoading();
                  }
                ),),),
              SizedBox(height: spacing,),
              buildFieldValue(AppString.TEXT_FOD_OF_DAY,
                  PaginatedGridView<Product>(
                    key: pageKey,
                    initialItems: productController.recentProducts,
                    onDispose: (list){
                      print("list on dispose: ${list?.total_page}");
                      productController.recentProducts=list as PageModel<Product>;
                     // productController.recentProducts=list?.cast<Product>();
                    },
                    onFetchPage: (int page){
                      return productController.loadProducts(page,
                          search: searchController.text);
                    },
                    padding: EdgeInsets.symmetric(horizontal: paddHorz),
                    shrinkWrap: true,physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,mainAxisSpacing: gridSpacing,childAspectRatio: 0.7,
                    crossAxisSpacing: gridSpacing,
                    itemBuilder: (ind,item){
                      return FoodContainer(product:item,onTap: (){
                        AppNavigator.navigateTo(ProductDetailScreen(product: item,));
                      },onCartTap: (){
                        cartController.addProductToCart(item, 1);
                      },);
                    },
              ))


/*            buildFieldValue(AppString.TEXT_FOD_OF_DAY,GetBuilder<ProductController>(
                builder: (cont) {
                  final List<Product>? list=cont.recentProducts;
                  return list!=null?(list.isNotEmpty?GridView.builder(
                    padding: EdgeInsets.symmetric(horizontal: paddHorz),
                    shrinkWrap: true,physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
                        mainAxisSpacing: gridSpacing,crossAxisSpacing: gridSpacing,
                        childAspectRatio: 0.7),
                    itemCount: list.length,itemBuilder: (con,ind){
                      var product=list[ind];
                    return FoodContainer(product:product,onTap: (){
                      AppNavigator.navigateTo(ProductDetailScreen(product: product,));
                    },);
                  },
                  ):const NotFoundText()):const ContentLoading();
                }
              ),),*/



          ],),),
        ),
      )
    ],),
    );
  }

  Widget buildFieldValue(String field,Widget value){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
      Padding(
        padding: EdgeInsets.symmetric(horizontal: paddHorz),
        child: buildHeading(field),
      ),
      SizedBox(height: AppSizer.getHeight(4),),
      value,
    ],);
  }

  Widget buildHeading(String text){
    return CustomText(text: text,fontcolor: AppColor.COLOR_BLACK,
      fontweight: FontWeight.w600,fontsize: 20,);
  }

}
