import 'package:flutter/services.dart';
import 'dart:convert';
import 'dart:async';
import 'package:cw_proj/Model/city.dart';

Future<String> _loadCityJson() async{
  return await rootBundle.loadString('assets/Config/Locations.json');
}

Future<City> decodeCity() async{
  String cityJson = await _loadCityJson();

  final jsonMap = json.decode(cityJson);

  City city = City.formJson(jsonMap);

  return city;
}
