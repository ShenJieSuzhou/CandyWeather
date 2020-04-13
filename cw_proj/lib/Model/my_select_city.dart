import 'package:cw_proj/Model/home_entity.dart';
import 'package:cw_proj/common/global.dart';
import 'package:cw_proj/states/CityChangeNotifier.dart';
import 'package:flutter/material.dart';

class SelectedCityModel extends SelCityChangeNotifier{
  List<HomeEntity> get weathers => locationList;

  set weathers(List<HomeEntity> list) {
    Global.homeEntityList.clear();
    Global.homeEntityList = list;
    notifyListeners();
  }

  void add(HomeEntity weatherModel){
    weathers.add(weatherModel);
    notifyListeners();
  }

}

class Counter with ChangeNotifier {
  int _count = 0;
  int get count => _count;

  void increment() {
    _count++;
    notifyListeners();
  }
}