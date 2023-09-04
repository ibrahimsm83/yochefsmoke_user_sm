import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:ycsh/widget/common.dart';
import 'package:ycsh/widget/loader.dart';
import 'package:ycsh/widget/pagenation/paged_view.dart';

class PaginatedListView<T> extends PagedView<T> {
  const PaginatedListView({
    Key? key,
    required super.itemBuilder,
    required super.onFetchPage,
    super.shrinkWrap = false,
    super.onDispose,
    super.initialItems,
    super.initialCall = true,
    super.physics = const AlwaysScrollableScrollPhysics(),
    super.padding = EdgeInsets.zero,
  }) : super(key: key);

  @override
  _PagedListViewState<T> createState() => _PagedListViewState<T>();
}

class _PagedListViewState<T> extends PagedViewState<T> {
  @override
  Widget build(BuildContext context) {
    return PagedListView(
      pagingController: pagingController,
      padding: widget.padding,
      shrinkWrap: widget.shrinkWrap,
      physics: widget.physics,
      builderDelegate: PagedChildBuilderDelegate<T>(
          firstPageProgressIndicatorBuilder: (con) {
        return const ContentLoading();
      }, noItemsFoundIndicatorBuilder: (con) {
        return const NotFoundText();
      }, itemBuilder: (context, dynamic item, index) {
        return widget.itemBuilder(index, item);
      }),
    );
  }
}
