import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ycsh/controller/user/controllers.dart';
import 'package:ycsh/model/interface.dart';
import 'package:ycsh/model/product.dart';
import 'package:ycsh/service/image_chooser.dart';
import 'package:ycsh/utils/actions.dart';
import 'package:ycsh/utils/asset_path.dart';
import 'package:ycsh/utils/constants.dart';
import 'package:ycsh/utils/navigation.dart';
import 'package:ycsh/utils/sizer.dart';
import 'package:ycsh/utils/strings.dart';
import 'package:ycsh/widget/app_bar.dart';
import 'package:ycsh/widget/background.dart';
import 'package:ycsh/widget/button.dart';
import 'package:ycsh/widget/common.dart';
import 'package:ycsh/widget/dropdown.dart';
import 'package:ycsh/widget/icons.dart';
import 'package:ycsh/widget/loader.dart';
import 'package:ycsh/widget/rating_items.dart';

class ProductDetailScreen extends StatefulWidget {

  final Product product;
  const ProductDetailScreen({Key? key,required this.product,}) : super(key: key);

  @override
  State<ProductDetailScreen> createState() => ProductDetailScreenState();
}

class ProductDetailScreenState extends State<ProductDetailScreen> {

  final ProductController productController=Get.find<ProductController>();

  late Rx<bool> isFavourite;

  final Map<String,ProductSideline> sidelines={};
  final Map<String,ProductVariant> varients={};

  final CartController cartController=Get.find<CartController>();

  int count=1;

  @override
  void initState() {
    isFavourite=widget.product.isFavourite.obs;
    productController.loadProductDetail(widget.product);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomBackground(child: Scaffold(extendBodyBehindAppBar: true,
      appBar: TransparentAppbar(leading: ButtonBack(color: AppColor.COLOR_WHITE,
        onTap: (){
          AppNavigator.pop();
        },
      ),),
      body: Container(child: Stack(children: [
        Positioned.fill(child: CustomImage(image: widget.product.image,
          fit: BoxFit.cover,imageType: ImageType.TYPE_NETWORK,)),
        Align(
            alignment: Alignment.bottomCenter,
            child: buildBottom()),
      ],),),
    ));
  }

  Widget buildBottom(){
    final double diameter=AppSizer.getHeight(40);
    final double iconsize=AppSizer.getHeight(18);
    final double spacing=AppSizer.getHeight(10);

    return Container(
      height: AppSizer.getPerHeight(0.52),
      padding: EdgeInsets.symmetric(
        horizontal: AppSizer.getWidth(22),vertical: AppSizer.getHeight(24)),
      decoration: BoxDecoration(color: AppColor.COLOR_WHITE),
      child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
        CustomText(text: "${widget.product.name}",fontsize: 20,fontweight: FontWeight.w600,),
        SizedBox(height: AppSizer.getHeight(3),),
        CustomText(text: "${widget.product.cook_type}",fontsize: 11,
        fontcolor: AppColor.COLOR_BLACK3,),
        SizedBox(height: AppSizer.getHeight(12),),
/*        Row(
          children: [
            StarRating(size: AppSizer.getHeight(15),),
            SizedBox(width: AppSizer.getWidth(6),),
            CustomText(text: "123 ${AppString.TEXT_REVIEWS}",
              fontcolor: AppColor.COLOR_GREY4,fontsize: 10,line_spacing: 1.4,)
          ],
        ),
        SizedBox(height: AppSizer.getHeight(18),),*/
        CustomText(text: "${widget.product.description}",
          fontcolor: AppColor.COLOR_GREY4,fontsize: 13,),

        GetBuilder<ProductController>(builder: (cont){
          final List<ProductSideline>? sidelines=cont.getSideLines(widget.product.id!);
          final List<ProductVariant>? varients=cont.getVarients(widget.product.id!);
          return (sidelines!=null || varients!=null)?Column(children: [
            Visibility(
              visible: sidelines?.isNotEmpty??false,
              child: Padding(
                padding: EdgeInsets.only(top: AppSizer.getHeight(15)),
                child: CustomDropdown(hint: AppString.TEXT_SIDELINE,
                  items: sidelines,//selected_value: sideline,
                  onValueChanged: (val){
                    addSideline(val as ProductSideline);
                  },),
              ),
            ),
            Visibility(
                visible: this.sidelines.isNotEmpty,
                child: Builder(
                    builder: (context) {
                      final List<ProductSideline> list=this.sidelines.values.toList();
                      return ListView.separated(
                          padding: EdgeInsets.only(top: spacing),
                          shrinkWrap: true,physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (con,ind){
                            var item=list[ind];
                            return buildCounter(item.getText(),
                                item.quantity,onTap: (val){
                                  setItemCount(this.sidelines,item.id!, val);
                                },onRemove: (){
                                  removeItem(this.sidelines, item.id!);
                                });
                          }, separatorBuilder: (con,ind){
                        return SizedBox(height: spacing,);
                      }, itemCount: list.length);
                    }
                )),

            Visibility(
              visible: varients?.isNotEmpty??false,
              child: Padding(
                padding: EdgeInsets.only(top: AppSizer.getHeight(15)),
                child: CustomDropdown(hint: AppString.TEXT_VARIANT,
                  items: varients,//selected_value: sideline,
                  onValueChanged: (val){
                    addVarient(val as ProductVariant);
                  },),
              ),
            ),
            Visibility(
                visible: this.varients.isNotEmpty,
                child: Builder(
                    builder: (context) {
                      final List<ProductVariant> list=this.varients.values.toList();
                      return ListView.separated(
                          padding: EdgeInsets.only(top: spacing),
                          shrinkWrap: true,physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (con,ind){
                            var item=list[ind];
                            return buildCounter(item.getText(),
                                item.quantity,onTap: (val){
                                  setItemCount(this.varients,item.id!, val);
                                },onRemove: (){
                                  removeItem(this.varients, item.id!);
                                });
                          }, separatorBuilder: (con,ind){
                        return SizedBox(height: spacing,);
                      }, itemCount: list.length);
                    }
                )),
          ],):const ContentLoading();
        }),
   /*
        Visibility(
          visible: widget.product.sidelines.isNotEmpty,
          child: Padding(
            padding: EdgeInsets.only(top: AppSizer.getHeight(15)),
            child: CustomDropdown(hint: "Sideline",
              items: widget.product.sidelines,//selected_value: sideline,
              onValueChanged: (val){
                addSideline(val as ProductSideline);
              },),
          ),
        ),

          Visibility(
              visible: sidelines.isNotEmpty,
              child: Builder(
            builder: (context) {
              final List<ProductSideline> list=sidelines.values.toList();
              return ListView.separated(
                  padding: EdgeInsets.only(top: spacing),
                  shrinkWrap: true,physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (con,ind){
                var item=list[ind];
                return buildCounter(item.getText(),
                    item.quantity,onTap: (val){
                      setItemCount(sidelines,item.id!, val);
                    },onRemove: (){
                      removeItem(sidelines, item.id!);
                    });
              }, separatorBuilder: (con,ind){
                return SizedBox(height: spacing,);
              }, itemCount: list.length);
            }
          )),

          Visibility(
            visible: widget.product.varients.isNotEmpty,
            child: Padding(
              padding: EdgeInsets.only(top: AppSizer.getHeight(15)),
              child: CustomDropdown(hint: "Variant",
                items: widget.product.varients,//selected_value: sideline,
                onValueChanged: (val){
                  addVarient(val as ProductVariant);
                },),
            ),
          ),
          Visibility(
              visible: varients.isNotEmpty,
              child: Builder(
                  builder: (context) {
                    final List<ProductVariant> list=varients.values.toList();
                    return ListView.separated(
                        padding: EdgeInsets.only(top: spacing),
                        shrinkWrap: true,physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (con,ind){
                          var item=list[ind];
                          return buildCounter(item.getText(),
                              item.quantity,onTap: (val){
                                setItemCount(varients,item.id!, val);
                              },onRemove: (){
                                removeItem(varients, item.id!);
                              });
                        }, separatorBuilder: (con,ind){
                      return SizedBox(height: spacing,);
                    }, itemCount: list.length);
                  }
              )),*/
          SizedBox(height: AppSizer.getHeight(18),),
        Row(children: [
          Expanded(child: CustomText(text: "\$${widget.product.price}",
            fontsize: 23,fontweight: FontWeight.bold,)),
          Row(children: [
            buildButton(AssetPath.ICON_MINUS,iconsize,onTap: (){
              setCount(-1);
            }),
            Container(alignment: Alignment.center,
                width: diameter,height: diameter,
                decoration: const BoxDecoration(shape: BoxShape.circle,
                      color: AppColor.THEME_COLOR_PRIMARY1),
                child: CustomText(text: "${count}",line_spacing: 1.4,
                  fontsize: 16,
                  fontweight: FontWeight.w600,)),
            buildButton(AssetPath.ICON_PLUS,iconsize,onTap: (){
              setCount(1);
            }),
          ],)
        ],),
        SizedBox(height: AppSizer.getHeight(25),),
        buildRow(),
      ],),
    ),);
  }

  Widget buildRow(){
    return Row(children: [
      Obx(
            () => CustomIconButton(
            onTap: (){
              addFavourite();
            },
            icon: CustomMonoIcon(icon: isFavourite.value?
            AssetPath.ICON_HEART_FILLED:AssetPath.ICON_HEART,
              size: AppSizer.getHeight(25),color: AppColor.COLOR_RED1,)),
      ),
      SizedBox(width: AppSizer.getWidth(10),),
      Expanded(child: CustomButton(text: AppString.TEXT_ADD_TO_CART,
        onTap: (){
          cartController.addProductToCart(widget.product, count,
              sidelines: sidelines.values.toList(),
              varients: varients.values.toList()).then((value) {
            if(value){
              AppNavigator.pop();
            }
          });
        },))
    ],);
  }

  void removeItem(Map map,String key){
    setState(() {
      map.remove(key);
    });
  }

  Widget buildCounter(String name,int count,{Function(int val)? onTap,
    Function()? onRemove,}){
    final double diameter=AppSizer.getHeight(22);
    final double iconsize=AppSizer.getHeight(12);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
      Expanded(child: CustomText(text: name,fontsize: 16,fontweight: FontWeight.w600,)),
      Row(children: [
        buildButton(AssetPath.ICON_MINUS,iconsize,onTap: (){
          onTap?.call(-1);
        }),
        Container(alignment: Alignment.center,
            width: diameter,height: diameter,
            decoration: const BoxDecoration(shape: BoxShape.circle,
                color: AppColor.THEME_COLOR_PRIMARY1),
            child: CustomText(text: "${count}",line_spacing: 1.5,
              fontsize: 12,
              fontweight: FontWeight.w600,)),
        buildButton(AssetPath.ICON_PLUS,iconsize,onTap: (){
          onTap?.call(1);
        }),
      ],),
      SizedBox(width: AppSizer.getWidth(10),),
      ButtonClose(onTap: onRemove,color: AppColor.COLOR_BLACK,ratio: 0.6,),
    ],);
  }


  void setCount(int val){
    int c=count+val;
    if(c>=1) {
      setState(() {
        count=c;
      });
    }
  }

  void setItemCount(Map map,String key,int val){
    var list=map[key];
    int count=list.quantity;
    int c=count+val;
    if(c>=1) {
      setState(() {
        list.quantity=c;
      });
    }
  }

  void addFavourite(){
    isFavourite.value=!isFavourite.value;
    productController.addFavouriteProduct(widget.product,isFavourite);
  }

  Widget buildButton(String icon,double iconsize,{Function()? onTap,}){
    return CustomIconButton(icon: CustomMonoIcon(icon: icon,size: iconsize,
      color: AppColor.COLOR_BLACK,),onTap:onTap,);
  }

  void addSideline(ProductSideline sideline){
    if(!sidelines.containsKey(sideline.id)){
      setState(() {
        sidelines[sideline.id!]=sideline..quantity=1;
      });
    }
    else{
      AppMessage.showMessage("Already added");
    }
  }

  void addVarient(ProductVariant varient){
    if(!varients.containsKey(varient.id)){
      setState(() {
        varients[varient.id!]=varient..quantity=1;
      });
    }
    else{
      AppMessage.showMessage("Already added");
    }
  }

}
