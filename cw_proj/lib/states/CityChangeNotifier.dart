import 'package:cw_proj/Model/data_key_bean.dart';
import 'package:flutter/material.dart';
import 'package:cw_proj/common/global.dart';
class CityChangeNotifier extends ChangeNotifier {
  HomeBean get _citys => Global.locations;

  @override
  void notifyListeners() {
    Global.saveLocations(); //保存Profile变更
    super.notifyListeners(); //通知依赖的Widget更新
  }
}