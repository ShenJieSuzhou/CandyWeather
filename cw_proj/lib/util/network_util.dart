import 'package:dio/dio.dart';
import 'intercept.dart';
import 'package:cw_proj/common/common.dart';

class NetWorkUtil{

   static final NetWorkUtil _singleton = NetWorkUtil._internal();

  static NetWorkUtil get instance => NetWorkUtil();

  factory NetWorkUtil() {
    return _singleton;
  }

  static Dio _dio;

  Dio getDio(){
    return _dio;
  }
  
  NetWorkUtil._internal(){
    BaseOptions options = BaseOptions(
      connectTimeout: 5000,
      receiveTimeout: 3000,
      responseType: ResponseType.plain,
      validateStatus: (status){
        // 不使用http状态码判断状态，使用AdapterInterceptor来处理（适用于标准REST风格）
        return true;
      },
      baseUrl: "http://aliv18.data.moji.com/whapi/json/alicityweather/",
//      contentType: ContentType('application', 'x-www-form-urlencoded', charset: 'utf-8'),
    );
    _dio = Dio(options);
    /// 打印Log(生产模式去除)
    if (!Constant.inProduction){
      _dio.interceptors.add(LoggingInterceptor());
    }
    /// 适配数据(根据自己的数据结构，可自行选择添加)
    _dio.interceptors.add(AdapterInterceptor());
  }

}