
import 'package:flutter/material.dart';

class KeyBean {
  List<HotCitys> hotCitys;

  KeyBean({this.hotCitys});

  KeyBean.fromJson(Map<String, dynamic> json) {
    if (json['HotCitys'] != null) {
      hotCitys = new List<HotCitys>();
      json['HotCitys'].forEach((v) {
        hotCitys.add(new HotCitys.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.hotCitys != null) {
      data['HotCitys'] = this.hotCitys.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class HotCitys {
  String id;
  String name;

  HotCitys({this.id, this.name});

  HotCitys.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}


class HomeBean {
  List<Record> record;

  HomeBean({this.record});

  HomeBean.fromJson(Map<String, dynamic> json) {
    if (json['Record'] != null) {
      record = new List<Record>();
      json['Record'].forEach((v) {
        record.add(new Record.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.record != null) {
      data['Record'] = this.record.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Record {
  String fid;
  String name;
  String nameEn;
  String namePy;
  String fProvinceCn;
  String fWeathercn;

  Record(
      {this.fid,
      this.name,
      this.nameEn,
      this.namePy,
      this.fProvinceCn,
      this.fWeathercn});

  Record.fromJson(Map<String, dynamic> json) {
    fid = json['fid'];
    name = json['name'];
    nameEn = json['name_en'];
    namePy = json['name_py'];
    fProvinceCn = json['f_province_cn'];
    fWeathercn = json['f_weathercn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fid'] = this.fid;
    data['name'] = this.name;
    data['name_en'] = this.nameEn;
    data['name_py'] = this.namePy;
    data['f_province_cn'] = this.fProvinceCn;
    data['f_weathercn'] = this.fWeathercn;
    return data;
  }
}