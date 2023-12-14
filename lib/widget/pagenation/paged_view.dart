import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:ycsh/model/page_model.dart';

abstract class PagedView<T> extends StatefulWidget {
  final PageModel<T>? initialItems;
  //final void Function(List? items)? onDispose;
  final void Function(PageModel items)? onDispose;
  final Future<PageModel<T>?> Function(int page) onFetchPage;
  // final bool initialCall;
  final Widget Function(int ind, dynamic item) itemBuilder;
  final EdgeInsets padding;
  final bool shrinkWrap;
  final ScrollPhysics physics;
  const PagedView({
    Key? key,
    required this.itemBuilder,
    this.shrinkWrap = false,
    this.physics = const AlwaysScrollableScrollPhysics(),
    required this.onFetchPage,
    this.onDispose,
    this.padding = EdgeInsets.zero,
    this.initialItems, //this.initialCall=true,
  }) : super(key: key);

  @override
  PagedViewState<T> createState();
}

abstract class PagedViewState<T> extends State<PagedView> {
  late PagingController<int, T> _pagingController;
  late int _page;

  PagingController<int, T> get pagingController => _pagingController;

  @override
  void initState() {
    _page = widget.initialItems?.total_page ?? 1;
    _pagingController = PagingController(firstPageKey: _page);
    _pagingController.itemList = widget.initialItems?.data as List<T>?;
    print("page list: ${_pagingController.itemList?.length} $_page");
    _pagingController.addPageRequestListener((pageKey) {
      fetchPage(pageKey);
    });
    super.initState();
  }

  @override
  void dispose() {
    widget.onDispose?.call(PageModel<T>(
        data: _pagingController.itemList?.toList(), total_page: _page));
    _pagingController.dispose();
    print("pagenation disposed");
    super.dispose();
  }

  Future<void> fetchPage(int pageKey) async {
    try {
      final PageModel<T>? model =
          await widget.onFetchPage(_page) as PageModel<T>?;
      print("data is: ${model?.data?.length}");
      if (model != null) {
        if (_page == 1) {
          _pagingController.itemList?.clear();
          print("clearing list");
        }
        final bool isNotLastPage = _page < model.total_page;
       // final bool isNotLastPage = _page+1 <= model.total_page;
        print("page key: $_page ${model.total_page}");

        if (!isNotLastPage) {
          // page is last
          _pagingController.appendLastPage(model.data!);
        } else {
           _page++;
          _pagingController.appendPage(model.data!, _page);
        }
       // _page++;
        print("page item count: ${_pagingController.itemList?.length}");
      }
    } catch (error) {
      print("pagenation error: $error");
    //  _pagingController.error = error;
    //  throw error;
    }
  }

  void clearSaveList(
    void Function(PageModel<T> model) onOldPage, {
    PageModel<T>? newPage,
  }) {
    print("new page data: ${newPage?.data}");
    onOldPage.call(
        PageModel<T>(data: _pagingController.itemList, total_page: _page));
    _page = newPage?.total_page ?? 1;
    _pagingController.itemList = newPage?.data;
  }

  void refresh() {
    _page = 1;
    if (_pagingController.itemList == null) {
      // fetchPage(_page);
      _pagingController.notifyPageRequestListeners(_page);
    } else {
      _pagingController.refresh();
    }
    // _pagingController.itemList=null;

    //
  }
}
