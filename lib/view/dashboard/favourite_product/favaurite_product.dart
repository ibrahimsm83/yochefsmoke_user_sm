import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ycsh/controller/user/product_controller.dart';
import 'package:ycsh/model/page_model.dart';
import 'package:ycsh/model/product.dart';
import 'package:ycsh/utils/constants.dart';
import 'package:ycsh/utils/navigation.dart';
import 'package:ycsh/utils/sizer.dart';
import 'package:ycsh/utils/strings.dart';
import 'package:ycsh/view/dashboard/home/product_detail.dart';
import 'package:ycsh/widget/app_bar.dart';
import 'package:ycsh/widget/background.dart';
import 'package:ycsh/widget/button.dart';
import 'package:ycsh/widget/common.dart';
import 'package:ycsh/widget/home_items.dart';
import 'package:ycsh/widget/loader.dart';
import 'package:ycsh/widget/menu_items.dart';
import 'package:ycsh/widget/pagenation/paged_gridview.dart';
import 'package:ycsh/widget/pagenation/paged_view.dart';

class FavouriteProductScreen extends StatefulWidget {
  final bool back_enabled;
  const FavouriteProductScreen({Key? key, this.back_enabled = true})
      : super(key: key);

  @override
  State<FavouriteProductScreen> createState() => _FavouriteProductScreenState();
}

class _FavouriteProductScreenState extends State<FavouriteProductScreen> {

  int selected=0;

  final ProductController productController=Get.find<ProductController>();

  final TextEditingController searchController=TextEditingController();

  final GlobalKey<PagedViewState> pageKey=GlobalKey();

  @override
  void initState() {
    print("favourite initilized");
    productController.loadAllFoodCategories().then((value) {
      if(productController.getFavProducts(getSelectedCategory(selected)?.id)==null) {
        pageKey.currentState?.refresh();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    print("favourite disposed");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double paddHorz=AppSizer.getWidth(AppDimen.DASHBOARD_PADDING_HORZ);
    final double gridSpacing=AppSizer.getHeight(15);
    return CustomBackground(safe: false,
        child: Scaffold(
            appBar: DashboardAppbar(
              text: AppString.TEXT_FAVOURITES,
              leading: widget.back_enabled
                  ? ButtonBack(
                      onTap: () {
                        AppNavigator.pop();
                      },
                    )
                  : null,
            ),
            body: Column( crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: paddHorz),
                  child: SearchField(
                    hinttext: AppString.TEXT_SEARCH_FOOD,
                    controller: searchController,
                    onSubmit: (val){
                      pageKey.currentState?.refresh();
                    },
                  ),
                ),
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async{
                      pageKey.currentState?.refresh();
                    },
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: EdgeInsets.symmetric(
                          vertical: AppDimen.SCROLL_OFFSET_PADDING_VERT),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                      Container(height: AppSizer.getHeight(100),
                        child: GetBuilder<ProductController>(
                          builder: (cont) {
                            final List<FoodCategory>? list=cont.categories;
                            return list!=null?(list.isNotEmpty?ListView.separated(
                            padding: EdgeInsets.symmetric(horizontal: paddHorz),
                            itemCount: list.length,
                            separatorBuilder: (con,ind){
                              return SizedBox(width: AppSizer.getWidth(30),);
                            },
                            itemBuilder:(con,ind){
                              var menu=list[ind];
                             // return CustomText(text: "${menu.name} dd",);
                              return MenuContainer2(
                                category: menu,
                                selected: selected==ind,
                                onTap: (){
                                  int old=selected;
                                  setState(() {
                                    selected=ind;
                                  });
                                  print("old selection: $old");
                                  pageKey.currentState?.clearSaveList(
                                          (val){
                                        productController.setFavProducts(getSelectedCategory(old)?.id,
                                            val as PageModel<Product>);
                                  },
                                    newPage:productController.getFavProducts(
                                        getSelectedCategory(ind)?.id,),
                                  );
                               //   productController.loadCategoryProducts(menu.id!);
                                },);
                            },
                            scrollDirection: Axis.horizontal,
                      ):const NotFoundText()):const ContentLoading();
                          }
                        ),),
                        PaginatedGridView<Product>(
                          key: pageKey,shrinkWrap: true,
                        /*  initialCall: (productController.categories!=null &&
                              productController.categories!.isNotEmpty),*/
                          physics: const NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.fromLTRB(paddHorz,AppSizer.getHeight(15),
                                paddHorz,AppSizer.getHeight(AppDimen.DASHBOARD_NAVIGATION_BAR_HEIGHT)),
                          initialItems: productController.getFavProducts(getSelectedCategory(selected)?.id),
                          onDispose: (list){
                            print("list on dispose 3: ${list?.total_page} "
                                "${getSelectedCategory(selected)?.id} ${ (list as PageModel<Product>).data}");
                            productController.setFavProducts(getSelectedCategory(selected)?.id,
                                list as PageModel<Product>);
                            // productController.recentProducts=list?.cast<Product>();
                          },
                          crossAxisCount: 2,
                          mainAxisSpacing: gridSpacing,
                          crossAxisSpacing: gridSpacing,
                          childAspectRatio: 0.7,
                          itemBuilder: (ind, item) {
                            return FoodContainer(
                              product: item,
                              onTap: () {
                                AppNavigator.navigateTo(ProductDetailScreen(
                                  product: item,
                                ));
                              },
                            );
                          },
                          onFetchPage: (int page) {
                            return productController.loadCategoryProducts(page,
                                cat_id: getSelectedCategory(selected)?.id,
                                isFavourite: true,search: searchController.text,);
                          },
                        ),
                    /*    GetBuilder<ProductController>(
                          builder: (cont) {
                            final List<Product>? list=cont.getCategoryProducts(getSelectedCategory()?.id);
                            return list!=null?(list.isNotEmpty?GridView.builder(
                              padding: EdgeInsets.fromLTRB(paddHorz,AppSizer.getHeight(15),
                                paddHorz,AppSizer.getHeight(AppDimen.DASHBOARD_NAVIGATION_BAR_HEIGHT)),
                              shrinkWrap: true,physics: const NeverScrollableScrollPhysics(),
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
                                  mainAxisSpacing: gridSpacing,crossAxisSpacing: gridSpacing,
                                  childAspectRatio: 0.7),
                              itemCount: list.length,itemBuilder: (con,ind){
                                var prod=list[ind];
                              return FoodContainer(product:prod,onTap: (){
                                AppNavigator.navigateTo(ProductDetailScreen(product: prod,));
                              },);
                            },
                            ):const NotFoundText()):const ContentLoading();
                          }
                        )*/
                    ],),),
                  ),
                )
              ],
            )));
  }

  FoodCategory? getSelectedCategory(int index){
    return (productController.categories!=null &&
        productController.categories!.isNotEmpty)?
    productController.categories![index]:null;
  }
}
