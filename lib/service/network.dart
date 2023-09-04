import 'dart:convert';
import 'package:ycsh/utils/actions.dart';
import 'package:http/http.dart' as http;

class Network{

  static const TIMEOUT_DURATION_SEC=30;
  static const int STATUS_OK=200,STATUS_BAD_REQUEST=400,STATUS_UNAUTHORIZED=401,
      STATUS_NOTFOUND=404;

  static Network? _instance;

  Network._();

  factory Network() {
    return _instance??=Network._();
  }

  Future<http.Response?> _request(Future<http.Response?> request,
  {void Function(String response)? onSuccess,void Function(dynamic ex)? onError}){
    return request.then((value) {
      if(_checkStatus(value)) {
        onSuccess?.call(value!.body);
      }
      else{
        _handleError(Exception("Invalid Api Error"),onError);
      }
    }).catchError((ex){
      _handleError(ex, onError);
    });
  }

  void _handleError(dynamic ex,void Function(dynamic ex)? onError){
    if(onError!=null){
      onError.call(ex);
    }
    else{
      AppMessage.showMessage(ex.toString());
      //throw ex;
    }
  }

  Future<void> post(String url,dynamic body,{Map<String, String>? headers,
  void Function(String response)? onSuccess,void Function(dynamic ex)? onError})
    async{
    final Uri uri=Uri.parse(url);
    await _request(http.post(uri, body: body, headers: headers,),onSuccess: onSuccess,
        onError: onError);
  }

  Future<void> get(String url,{Map<String, String>? headers,
    void Function(String response)? onSuccess,void Function(dynamic ex)? onError})
    async{
    final Uri uri=Uri.parse(url);
    await _request(http.get(uri,headers: headers,),onSuccess: onSuccess,
        onError: onError);
  }

  Future<void> multipartPost(
      String url,Map<String,String> fields,{Map<String,String> headers=const {},
    List<http.MultipartFile> files=const [],
        void Function(String response)? onSuccess,void Function(dynamic ex)? onError}) async{
    var postUri = Uri.parse(url);
    var request = http.MultipartRequest("POST", postUri);
    request.headers.addAll(headers);
    request.fields.addAll(fields);
    request.files.addAll(files);
    await request.send().then((value) async{
      if(_checkStatus(value)) {
        Stream stream = value.stream.transform(const Utf8Decoder());
        String body = await stream.first;
        onSuccess?.call(body);
      }
      else{
        _handleError(Exception("Invalid Api Error"),onError);
      }
    }).catchError((ex){
      _handleError(ex, onError);
    });
  }

  bool _checkStatus(http.BaseResponse? response){
    // bool ok=response.isOk;
    bool ok=false;
    if(response!=null) {
      print("response code: ${response.statusCode}");
      // print("response body: ${(response as dynamic).body}");
      ok = (response.statusCode == 200 || response.statusCode == 400
          || response.statusCode==401 || response.statusCode==424);
    }
    return ok;
  }
}