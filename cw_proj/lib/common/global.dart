
import 'dart:convert';

import 'package:cw_proj/Model/home_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cw_proj/util/configFile.dart';
import 'package:cw_proj/Model/data_key_bean.dart';


class Global{
  static SharedPreferences _prefs;
  static HomeBean locations = HomeBean();
  static List<HomeEntity> homeEntityList = [];
  
  // 是否为release版
  static bool get isRelease => bool.fromEnvironment("dart.vm.product");

  //初始化全局信息，会在APP启动时执行
  static Future init() async {
    _prefs = await SharedPreferences.getInstance();
    var _locations = _prefs.getString("locations");
    if (_locations != null) {
      try {
        locations = HomeBean.fromJson(jsonDecode(_locations));
      } catch(e){
        print(e);
      }
    } else {
      // 从文件中读取默认城市信息
      fetchCity().then((value){
        locations = value;
        saveLocations();
      });
    }
  }

  // 持久化Location信息
  static saveLocations () {
    _prefs.setString("locations", jsonEncode(locations.toJson()));
  }

  // 保存APP设置
  static saveEnterConfig () {
    _prefs.setString("isFirst", "1");
  }

  static savePositionConfig (String flag) {
    _prefs.setString("position", flag);
  }

  static saveNotiConfig (String flag) {
    _prefs.setString("notification", flag);
  }

  // 获取APP设置
  static bool isOpenPosition () {
    var flag = _prefs.getString("position");
    if (flag == "1"){
      return true;
    } else {
      return false;
    }
  }

  static bool isOpenNotification () {
    var flag = _prefs.getString("notification");
    if (flag == "1"){
      return true;
    } else {
      return false;
    }
  }

  // 是否第一次打开App
  static bool isFirst (){
    var first = _prefs.getString("isFirst");
    if (first == null) {
      return true;
    } else {
      if (first == "1") {
        return false;
      }
      return true;
    }
  }

}