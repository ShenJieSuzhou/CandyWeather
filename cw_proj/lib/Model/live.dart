import 'package:common_utils/common_utils.dart';

class Live {
  List<LiveIndex> liveIndex;
  Map<String, dynamic> indexs;

  Live({this.indexs});

  Live.fromJson(Map<String, dynamic> json) {
    if (json['liveIndex'] != null) {
      indexs = json['liveIndex'];
      String date = DateUtil.formatDateTime(DateTime.now().toString(), DateFormat.YEAR_MONTH_DAY, '-', '');
      liveIndex = new List<LiveIndex>();
      indexs[date].forEach((v) {
        liveIndex.add(new LiveIndex.fromJson(v));
      });
    }
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   if (this.liveIndex != null) {
  //     data['liveIndex'] = this.liveIndex.map((v) => v.toJson()).toList();
  //   }
  //   return data;
  // }
}

class LiveIndex {
  String day;
  String desc;
  String name;
  String status;

  LiveIndex({this.day, this.desc, this.name, this.status});

  LiveIndex.fromJson(Map<String, dynamic> json) {
    day = json['day'];
    desc = json['desc'];
    name = json['name'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['day'] = this.day;
    data['desc'] = this.desc;
    data['name'] = this.name;
    data['status'] = this.status;
    return data;
  }
}