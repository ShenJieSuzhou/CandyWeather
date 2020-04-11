import 'package:cw_proj/Model/daily.dart';
import 'package:cw_proj/Model/aqi.dart';
import 'package:cw_proj/Model/hours.dart';
import 'package:cw_proj/Model/live.dart';
import 'package:cw_proj/Model/condition.dart';

class HomeEntity {
  String cityName;
  Condition condition;
  AQI aqi;
  Hours hour;
  Daily daily;
  Live live;

  HomeEntity({
    this.cityName,
    this.condition,
    this.aqi,
    this.hour,
    this.daily,
    this.live
  });

} 