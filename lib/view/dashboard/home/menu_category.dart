import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ycsh/controller/user/controllers.dart';
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

class MenuCategoryScreen extends StatefulWidget {
  const MenuCategoryScreen({Key? key}) : super(key: key);

  @override
  State<MenuCategoryScreen> createState() => _MenuCategoryScreenState();
}

class _MenuCategoryScreenState extends State<MenuCategoryScreen> {
  int selected = 0;

  final ProductController productController = Get.find<ProductController>();
  final CartController cartController=Get.find<CartController>();

  final TextEditingController searchController=TextEditingController();

  final GlobalKey<PagedViewState> pageKey=GlobalKey();

  @override
  void initState() {
    productController.loadAllFoodCategories().then((value) {
      if(productController.getProducts(getSelectedCategory(selected)?.id)==null) {
        pageKey.currentState?.refresh();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double paddHorz = AppSizer.getWidth(AppDimen.DASHBOARD_PADDING_HORZ);
    final double gridSpacing = AppSizer.getHeight(15);
    return CustomBackground(
        child: Scaffold(
      appBar: LogoAppbar(
        leading: ButtonBack(
          onTap: () {
            AppNavigator.pop();
          },
        ),
      ),
      body: Column(
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
          Container(
            height: AppSizer.getHeight(50),
            child: GetBuilder<ProductController>(builder: (cont) {
              final List<FoodCategory>? list = cont.categories;
              return list != null
                  ? (list.isNotEmpty
                      ? ListView.separated(
                          padding: EdgeInsets.symmetric(horizontal: paddHorz),
                          itemCount: list.length,
                          separatorBuilder: (con, ind) {
                            return SizedBox(
                              width: AppSizer.getWidth(30),
                            );
                          },
                          itemBuilder: (con, ind) {
                            var menu = list[ind];
                            return Center(
                                child: MenuCategoryContainer(
                              category: menu,
                              selected: selected == ind,
                              onTap: () {
                                int old=selected;
                                setState(() {
                                  selected = ind;
                                });
                                pageKey.currentState?.clearSaveList(
                                        (val){
                                      productController.setProducts(getSelectedCategory(old)?.id,
                                          val as PageModel<Product>);
                                    },newPage: productController.getProducts(getSelectedCategory(ind)?.id),);
                                //   productController.loadCategoryProducts(menu.id!);
                              },
                            ));
                          },
                          scrollDirection: Axis.horizontal,
                        )
                      : const NotFoundText())
                  : const NotFoundText();
            }),
          ),
          Expanded(
              child: RefreshIndicator(
                onRefresh: () async{
                  pageKey.currentState?.refresh();
                },
                child: PaginatedGridView<Product>(
                  key: pageKey,
                  initialCall: (productController.categories!=null &&
                      productController.categories!.isNotEmpty),
                  padding: EdgeInsets.symmetric(horizontal: paddHorz),
                  initialItems: productController.getProducts(getSelectedCategory(selected)?.id),
                  onDispose: (list){
                    print("list on dispose 2: ${list?.total_page} "
                        "${getSelectedCategory(selected)?.id} ${ (list as PageModel<Product>).data}");
                    productController.setProducts(getSelectedCategory(selected)?.id,
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
                  },onCartTap: (){
                  cartController.addProductToCart(item, 1);
                },
                );
            },
            onFetchPage: (int page) {
                return productController.loadCategoryProducts(page,
                    cat_id: getSelectedCategory(selected)?.id,
                    search: searchController.text);
            },
          ),
              )),
/*          Expanded(
            child: GetBuilder<ProductController>(builder: (cont) {
              final List<Product>? list =
                  cont.getCategoryProducts(getSelectedCategory()?.id);
              return list != null
                  ? (list.isNotEmpty
                      ? GridView.builder(
                          padding: EdgeInsets.symmetric(horizontal: paddHorz),
                          //shrinkWrap: true,
                          // physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: gridSpacing,
                                  crossAxisSpacing: gridSpacing,
                                  childAspectRatio: 0.7),
                          itemCount: list.length,
                          itemBuilder: (con, ind) {
                            var prod = list[ind];
                            return FoodContainer(
                              product: prod,
                              onTap: () {
                                AppNavigator.navigateTo(ProductDetailScreen(
                                  product: prod,
                                ));
                              },
                            );
                          },
                        )
                      : const NotFoundText())
                  : const ContentLoading();
            }),
          ),*/
        ],
      ),
    ));
  }

  FoodCategory? getSelectedCategory(int index) {
    return (productController.categories != null &&
            productController.categories!.isNotEmpty)
        ? productController.categories![index]
        : null;
  }
}
