import 'package:cw_proj/Model/aqi.dart';
import 'package:cw_proj/Model/condition.dart';
import 'package:cw_proj/Model/daily.dart';
import 'package:cw_proj/Model/hours.dart';
import 'package:cw_proj/Model/live.dart';
class EntityFactory {
  static T generateOBJ<T>(json) {
    if (1 == 0) {
      return null;
    } else if (T.toString() == 'AQI') {
      return AQI.fromJson(json) as T;
    } else if (T.toString() == 'Condition'){
      return Condition.fromJson(json) as T;
    } else if (T.toString() == 'Daily') {
      return Daily.fromJson(json) as T;
    } else if (T.toString() == 'Hours') {
      return Hours.fromJson(json) as T;
    } else if (T.toString() == 'Live') {
      Live.fromJson(json);
    } else {
      return null;
    }
  }
}