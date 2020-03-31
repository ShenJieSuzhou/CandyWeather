import 'package:cw_proj/Model/data_key_bean.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cw_proj/util/dio_utils.dart';
import 'package:cw_proj/Model/aqi.dart';
import 'package:cw_proj/util/network_util.dart';
import 'package:cw_proj/util/cityidlist.dart';
import 'package:cw_proj/Model/base_entity.dart';

void main() {

    Map<String, String> bodys = Map();
    bodys['cityId'] = '2';
    bodys['token'] = '8b36edf8e3444047812be3a59d27bab9';
    test('hours weather', () async{
      print('11111111111');
      List<Record> records = CityListUtil.getSearchResults("北京市");
      records.forEach((item){
        print(item.name);
        
      }
      );
      
      


        // await DioUtils.instance.requestNetwork<AQI>(Method.post, 'aqi', onSuccess: (data){
        //   print(data.cityName);
        // },
        // onError:(_, __){
        //   print('$_, $__');
        // },
        // queryParameters: bodys,
        // );
        // Future.wait([fetchCondition('2')]).then((results){
        //   print('Condition:' + results[0].toString());
        // });
    });
}