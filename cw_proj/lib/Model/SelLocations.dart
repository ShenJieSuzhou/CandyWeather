import 'package:cw_proj/Model/City.dart';

class SelLocations {
  List<City> citys;

  SelLocations({this.citys});

  SelLocations.fromJson(Map<String, dynamic> json) {
    if (json['Citys'] != null) {
      citys = new List<City>();
      json['Citys'].forEach((v) {
        citys.add(new City.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.citys != null) {
      data['Citys'] = this.citys.map((v) => v.toJson()).toList();
    }
    return data;
  }
}