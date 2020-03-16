import 'package:cw_proj/Model/aqi.dart';
class EntityFactory {
  static T generateOBJ<T>(json) {
    if (1 == 0) {
      return null;
    } else if (T.toString() == 'AQI') {
      return AQI.fromJson(json) as T;
    } else {
      return null;
    }
  }
}