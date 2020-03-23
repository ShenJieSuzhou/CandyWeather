import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:cw_proj/common/common.dart';
import 'package:cw_proj/util/log_util.dart';
import 'package:rxdart/rxdart.dart';
import 'package:cw_proj/Model/base_entity.dart';
import 'package:cw_proj/Model/error_handle.dart';
import 'intercept.dart';


class DioUtils {

  static final DioUtils _singleton = DioUtils._internal();

  static DioUtils get instance => DioUtils();

  factory DioUtils() {
    return _singleton;
  }

  static Dio _dio;

  Dio getDio(){
    return _dio;
  }

  DioUtils._internal(){
    var appcode = '5a32c640b59b4858959764f2dac3218f';
    Map<String, String> headers = Map();
    headers['Authorization'] = 'APPCODE '+ appcode;
    var options = BaseOptions(
      connectTimeout: 5000,
      receiveTimeout: 3000,
      responseType: ResponseType.plain,
      validateStatus: (status){
        // 不使用http状态码判断状态，使用AdapterInterceptor来处理（适用于标准REST风格）
        return true;
      },
      baseUrl: "http://aliv18.data.moji.com/whapi/json/alicityweather/",
      contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
      headers: headers
    );
    _dio = Dio(options);
    // /// 打印Log(生产模式去除)
    if (!Constant.inProduction){
      _dio.interceptors.add(LoggingInterceptor());
    }
    // 适配数据(根据自己的数据结构，可自行选择添加)
    // _dio.interceptors.add(AdapterInterceptor());
  }

  // 数据返回格式统一，统一处理异常
  Future<BaseEntity<T>> mrequest<T>(String method, String url, {
    dynamic data, Map<String, dynamic> queryParameters,
    CancelToken cancelToken, Options options
  }) async {
    var response = await _dio.request(url, data: data, queryParameters: queryParameters, options: _checkOptions(method, options), cancelToken: cancelToken);
    try {
      /// 集成测试无法使用 isolate
      Map<String, dynamic> _map = Constant.isTest ? parseData(response.data.toString()) : await compute(parseData, response.data.toString());
      return BaseEntity.fromJson(_map);
    }catch(e){
      print(e);
      return BaseEntity(ExceptionHandle.parse_error, "数据解析错误", null);
    }
  }

  Future<BaseEntity<T>> requestMJData<T>(Method method, String url, {
    dynamic data, Map<String, dynamic> queryParameters,
    CancelToken cancelToken, Options options
  }) async {
    String m = _getRequestMethod(method);
    var response = await _dio.request(url, data: data, queryParameters: queryParameters, options: _checkOptions(m, options), cancelToken: cancelToken);
    try {
      /// 集成测试无法使用 isolate
      Map<String, dynamic> _map = Constant.isTest ? parseData(response.data.toString()) : await compute(parseData, response.data.toString());
      return BaseEntity.fromJson(_map);
    }catch(e){
      print(e);
      return BaseEntity(ExceptionHandle.parse_error, "数据解析错误", null);
    }
  }

  Options _checkOptions(method, options) {
    if (options == null) {
      options = new Options();
    }
    options.method = method;
    return options;
  }

  Future requestNetwork<T>(Method method, String url, {
        Function(T t) onSuccess, 
        Function(List<T> list) onSuccessList, 
        Function(int code, String msg) onError,
        dynamic params, Map<String, dynamic> queryParameters, 
        CancelToken cancelToken, Options options, bool isList : false
  }) async {
    String m = _getRequestMethod(method);
    return await mrequest<T>(m, url,
        data: params,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken).then((BaseEntity<T> result){
      if (result.code == 0){
        if (isList){
          if (onSuccessList != null){
            onSuccessList(result.listData);
          }
        }else{
          if (onSuccess != null){
            onSuccess(result.data);
          }
        }
      }else{
        _onError(result.code, result.message, onError);
      }
    }, onError: (e, _){
      _cancelLogPrint(e, url);
      NetError error = ExceptionHandle.handleException(e);
      _onError(error.code, error.msg, onError);
    });
  }

  /// 统一处理(onSuccess返回T对象，onSuccessList返回List<T>)
  asyncRequestNetwork<T>(Method method, String url, {
    Function(T t) onSuccess, 
    Function(List<T> list) onSuccessList, 
    Function(int code, String msg) onError,
    dynamic params, Map<String, dynamic> queryParameters, 
    CancelToken cancelToken, Options options, bool isList : false
  }){
    String m = _getRequestMethod(method);
    Observable.fromFuture(mrequest<T>(m, url, data: params, queryParameters: queryParameters, options: options, cancelToken: cancelToken))
        .asBroadcastStream()
        .listen((result){
      if (result.code == 0){
        if (isList){
          if (onSuccessList != null){
            onSuccessList(result.listData);
          }
        }else{
          if (onSuccess != null){
            onSuccess(result.data);
          }
        }
      }else{
        _onError(result.code, result.message, onError);
      }
    }, onError: (e){
      _cancelLogPrint(e, url);
      NetError error = ExceptionHandle.handleException(e);
      _onError(error.code, error.msg, onError);
    });
  }

  _cancelLogPrint(dynamic e, String url){
    if (e is DioError && CancelToken.isCancel(e)){
      Log.e("取消请求接口： $url");
    }
  }

  _onError(int code, String msg, Function(int code, String mag) onError){
    if (code == null){
      code = ExceptionHandle.unknown_error;
      msg = "未知异常";
    }
    Log.e("接口请求异常： code: $code, mag: $msg");
    if (onError != null) {
      onError(code, msg);
    }
  }

  String _getRequestMethod(Method method){
    String m;
    switch(method){
      case Method.get:
        m = "GET";
        break;
      case Method.post:
        m = "POST";
        break;
      case Method.put:
        m = "PUT";
        break;
      case Method.patch:
        m = "PATCH";
        break;
      case Method.delete:
        m = "DELETE";
        break;
      case Method.head:
        m = "HEAD";
        break;
    }
    return m;
  }
}

Map<String, dynamic> parseData(String data){
  return json.decode(data);
}

enum Method {
  get,
  post,
  put,
  patch,
  delete,
  head
}