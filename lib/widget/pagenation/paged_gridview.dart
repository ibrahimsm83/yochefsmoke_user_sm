import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:ycsh/model/page_model.dart';
import 'package:ycsh/model/product.dart';
import 'package:ycsh/widget/common.dart';
import 'package:ycsh/widget/home_items.dart';
import 'package:ycsh/widget/loader.dart';
import 'package:ycsh/widget/pagenation/paged_view.dart';


class PaginatedGridView<T> extends PagedView<T> {

  final double mainAxisSpacing,crossAxisSpacing;
  final double childAspectRatio;
  final int crossAxisCount;

  //final List? initialItems;
  //final void Function(List? items)? onDispose;
  const PaginatedGridView({Key? key,required super.itemBuilder,
    required super.onFetchPage,required this.childAspectRatio,super.shrinkWrap=false,
    this.mainAxisSpacing=0,this.crossAxisSpacing=0,super.onDispose,
    super.initialItems,
    super.physics=const AlwaysScrollableScrollPhysics(),
    super.padding=EdgeInsets.zero,required this.crossAxisCount}) : super(key: key);

  @override
  _PaginatedGridViewState<T> createState() => _PaginatedGridViewState<T>();
}

class _PaginatedGridViewState<T> extends PagedViewState<T> {


  @override
  PaginatedGridView get widget => super.widget as PaginatedGridView;

  @override
  Widget build(BuildContext context) {
    return PagedGridView<int, T>(
      pagingController: pagingController,
      padding: widget.padding,
      shrinkWrap: widget.shrinkWrap,physics: widget.physics,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: widget.crossAxisCount,
          mainAxisSpacing: widget.mainAxisSpacing,crossAxisSpacing: widget.crossAxisSpacing,
          childAspectRatio: widget.childAspectRatio),
      builderDelegate: PagedChildBuilderDelegate<T>(
        firstPageProgressIndicatorBuilder: (con){
          return const ContentLoading();
        },
          noItemsFoundIndicatorBuilder: (con){
            return const NotFoundText();
          },
          itemBuilder: (context, dynamic item, index){
            return widget.itemBuilder(index,item);
          }
      ),
    );
  }


}
