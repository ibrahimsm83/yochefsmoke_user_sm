import 'package:get/get.dart';
import 'package:ycsh/controller/user/controllers.dart';
import 'package:ycsh/model/page_model.dart';
import 'package:ycsh/model/product.dart';
import 'package:ycsh/service/repositories/product_provider.dart';

class ProductController extends GetxController{

  final ProductProvider productProvider=ProductProvider();

  final DashboardController controller=Get.find<DashboardController>();

  List<FoodCategory>? _categories;

  final Map<String,List<ProductSideline>> _productSidelines={};
  final Map<String,List<ProductVariant>> _productVarients={};

  final Map<String,PageModel<Product>?> _products={},_favProducts={};//cat_id:products

  //List<Product>? _recentProducts;
  PageModel<Product>? _recentProducts;

  PageModel<Product>? getProducts(String? id){
    return _products[id];
  }

  void setProducts(String? key,PageModel<Product> model){
    if(key!=null) {
      _products[key] = model;
    }
  }

  PageModel<Product>? getFavProducts(String? id){
    return _favProducts[id];
  }

  void setFavProducts(String? key,PageModel<Product> model){
    if(key!=null) {
      _favProducts[key] = model;
    }
  }


  List<FoodCategory>? get categories => _categories;

  Future<void> loadAllFoodCategories() async{
    await productProvider.getAllFoodCategories(controller.user.accesstoken!,).then((list) {
      if (list != null) {
        _categories=list;
        update();
      }
    });
  }


 /* void loadCategoryProducts(String? cat_id){
    if(cat_id!=null) {
      productProvider.getProducts(controller.user.accesstoken!,
          cat_id: cat_id).then((list) {
        if (list != null) {
          _products[cat_id] = list;
          update();
        }
      });
    }
  }*/

  Future<PageModel<Product>?> loadCategoryProducts(int page,{String search="",
    String? cat_id,bool isFavourite=false}) {
    if(cat_id!=null) {
      return productProvider.getProducts(
          controller.user.accesstoken!, page: page,
          search: search, cat_id: cat_id, isFavourite: isFavourite);
    }
    else{
      return Future.value(null);
    }
  }

  Future<PageModel<Product>?> loadProducts(int page,{String search="",
    String? cat_id,bool isFavourite=false}){
    return productProvider.getProducts(controller.user.accesstoken!,page: page,
        search: search,cat_id: cat_id,isFavourite: isFavourite);
  }

/*  void loadRecentProducts(){
    productProvider.getCategoryProducts(controller.user.accesstoken!,).then((list) {
      if (list != null) {
        _recentProducts = list;
        update();
      }
    });
  }*/

  void addFavouriteProduct(Product product,Rx<bool> value) async{
    final bool status=await productProvider.addFavouriteProduct(controller.user.accesstoken!,
        product.id!);
    if(!status){
      value.value=!value.value;
    }
    else{
      product.isFavourite=value.value;
    }
  }

  PageModel<Product>? get recentProducts => _recentProducts;

  set recentProducts(PageModel<Product>? value) {
    _recentProducts = value;
  }

  List<ProductSideline>? getSideLines(String id){
    return _productSidelines[id];
  }

  List<ProductVariant>? getVarients(String id){
    return _productVarients[id];
  }

  Future<void> loadProductDetail(Product product) async{
    await productProvider.getProductDetail(controller.user.accesstoken!,product.id!)
        .then((list) {
      if (list != null) {
        _productSidelines[product.id!]=list.sidelines;
        _productVarients[product.id!]=list.varients;
        update();
      }
    });
  }
}