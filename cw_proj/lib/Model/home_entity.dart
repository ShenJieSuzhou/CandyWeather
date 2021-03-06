import 'package:cw_proj/Model/daily.dart';
import 'package:cw_proj/Model/aqi.dart';
import 'package:cw_proj/Model/hours.dart';
import 'package:cw_proj/Model/live.dart';
import 'package:cw_proj/Model/condition.dart';
import 'package:flutter/material.dart';

class HomeEntity {
  String cityName;
  Condition condition;
  AQI aqi;
  Hours hour;
  Daily daily;
  Live live;
  Map<String, String> jiTang;

  HomeEntity({
    this.cityName,
    this.condition,
    this.aqi,
    this.hour,
    this.daily,
    this.live,
    this.jiTang
  });

} 


class BingModel with ChangeNotifier{
  bool _isPageChanged = false;
  bool get change => _isPageChanged;

  void pageChanged(bool flag) {
    _isPageChanged = flag;
    notifyListeners();
  }
}