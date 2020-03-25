import 'package:cw_proj/Model/daily.dart';
import 'package:cw_proj/util/dio_utils.dart';
import 'package:cw_proj/Model/aqi.dart';
import 'package:cw_proj/Model/condition.dart';
import 'package:cw_proj/Model/hours.dart';
import 'package:cw_proj/Model/live.dart';
import 'package:cw_proj/Model/base_entity.dart';
// import 'package:cw_proj/common/common.dart';
// import 'package:flutter/foundation.dart';
// import 'package:cw_proj/Model/error_handle.dart';

  // 天气实况
  Future fetchCondition<T>(String cityID) async{
    Map<String, String> bodys = Map();
    bodys['cityId'] = cityID;
    bodys['token'] = '50b53ff8dd7d9fa320d3d3ca32cf8ed1';  
    BaseEntity<Condition> result = await DioUtils.instance.requestMJData<Condition>(Method.post, "condition",queryParameters: bodys);
    return result.data;
  }

  // AQI 
  Future fetchAQI<T>(String cityID) async {
    Map<String, String> bodys = Map();
    bodys['cityId'] = cityID;
    bodys['token'] = '8b36edf8e3444047812be3a59d27bab9';

    BaseEntity<AQI> result = await DioUtils.instance.requestMJData<AQI>(Method.post, "aqi",queryParameters: bodys);
    return result.data;
  }

  // 天气预报24小时
  Future fetchHours(String cityID) async {
    Map<String, String> bodys = Map();
    bodys['cityId'] = cityID;
    bodys['token'] = '008d2ad9197090c5dddc76f583616606';

    BaseEntity<Hours> result = await DioUtils.instance.requestMJData<Hours>(Method.post, "forecast24hours",queryParameters: bodys);
    return result.data;
    // return await DioUtils.instance.requestNetwork<Hours>(Method.post, 'forecast24hours', onSuccess: (data){
    //       print(data.toString());
    //     },
    //     onError:(_, __){
    //       print('$_, $__');
    //     },
    //     queryParameters: bodys,
    // );
  } 

  // 天气预报15天
  Future fetchDailys(String cityID) async {
    Map<String, String> bodys = Map();
    bodys['cityId'] = cityID;
    bodys['token'] = 'f9f212e1996e79e0e602b08ea297ffb0';

    BaseEntity<Daily> result = await DioUtils.instance.requestMJData<Daily>(Method.post, "forecast15days",queryParameters: bodys);
    return result.data;
    // return await DioUtils.instance.requestNetwork<Daily>(Method.post, 'forecast15days', onSuccess: (data){
    //       print(data.toString());
    //     },
    //     onError:(_, __){
    //       print('$_, $__');
    //     },
    //     queryParameters: bodys,
    // );
  } 
  
  // 天气指数
  Future fetchLiveIndex(String cityID) async {
    Map<String, String> bodys = Map();
    bodys['cityId'] = cityID;
    bodys['token'] = '5944a84ec4a071359cc4f6928b797f91';


    BaseEntity<Live> result = await DioUtils.instance.requestMJData<Live>(Method.post, "index", queryParameters: bodys);
    return result.data;
    // return await DioUtils.instance.requestNetwork<Live>(Method.post, 'index', onSuccess: (data){
    //       print(data.toString());
    //     },
    //     onError:(_, __){
    //       print('$_, $__');
    //     },
    //     queryParameters: bodys,
    // );
  } 

// class NetWorkUtil{

//    static final NetWorkUtil _singleton = NetWorkUtil._internal();

//   static NetWorkUtil get instance => NetWorkUtil();

//   factory NetWorkUtil() {
//     return _singleton;
//   }

//   static Dio _dio;

//   Dio getDio(){
//     return _dio;
//   }
  
//   NetWorkUtil._internal(){
//     BaseOptions options = BaseOptions(
//       connectTimeout: 5000,
//       receiveTimeout: 3000,
//       responseType: ResponseType.plain,
//       validateStatus: (status){
//         // 不使用http状态码判断状态，使用AdapterInterceptor来处理（适用于标准REST风格）
//         return true;
//       },
//       baseUrl: "http://aliv18.data.moji.com/whapi/json/alicityweather/",
// //      contentType: ContentType('application', 'x-www-form-urlencoded', charset: 'utf-8'),
//     );
//     _dio = Dio(options);
//     /// 打印Log(生产模式去除)
//     if (!Constant.inProduction){
//       _dio.interceptors.add(LoggingInterceptor());
//     }
//     /// 适配数据(根据自己的数据结构，可自行选择添加)
//     _dio.interceptors.add(AdapterInterceptor());
//   }

// }