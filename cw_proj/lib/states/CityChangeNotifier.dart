
import 'package:cw_proj/Model/home_entity.dart';
import 'package:flutter/material.dart';
import 'package:cw_proj/common/global.dart';
class SelCityChangeNotifier extends ChangeNotifier {
  List<HomeEntity> get locationList => Global.homeEntityList;

  @override
  void notifyListeners() {
    // Global.saveLocations(); //保存Profile变更
    super.notifyListeners(); //通知依赖的Widget更新
  }
}