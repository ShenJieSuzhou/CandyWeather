import 'package:flutter/services.dart';
import 'dart:convert';
import 'dart:async';
import 'package:cw_proj/Model/SelLocations.dart';

Future<SelLocations> fetchCity() async{
  final result =  await rootBundle.loadString('assets/Config/Locations.json');
  return SelLocations.fromJson(json.decode(result));
}

// Future<SelLocations> fetchMyCity() async{ 
  // String cityJson = await _loadCityJson();

  // Map<String, dynamic> jsonMap = json.decode(cityJson);
  
  // SelLocations citys = SelLocations.fromJson(jsonMap);

//   return null;
// }
