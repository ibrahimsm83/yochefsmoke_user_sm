class PageModel<T>{
  final List<T>? data;
  final int total_page,current_page,total_items;
  PageModel({required this.data, required this.total_page,this.current_page=0,
    this.total_items=0,});
}