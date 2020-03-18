class Condition {
  String condition;
  String conditionId;
  String humidity;
  String icon;
  String pressure;
  String realFeel;
  String sunRise;
  String sunSet;
  String temp;
  String tips;
  String updatetime;
  String uvi;
  String windDir;
  String windLevel;
  String windSpeed;

  Condition(
      {this.condition,
      this.conditionId,
      this.humidity,
      this.icon,
      this.pressure,
      this.realFeel,
      this.sunRise,
      this.sunSet,
      this.temp,
      this.tips,
      this.updatetime,
      this.uvi,
      this.windDir,
      this.windLevel,
      this.windSpeed});

  Condition.fromJson(Map<String, dynamic> mJSON) {
    Map<String, dynamic> json = mJSON['condition'];
    condition = json['condition'];
    conditionId = json['conditionId'];
    humidity = json['humidity'];
    icon = json['icon'];
    pressure = json['pressure'];
    realFeel = json['realFeel'];
    sunRise = json['sunRise'];
    sunSet = json['sunSet'];
    temp = json['temp'];
    tips = json['tips'];
    updatetime = json['updatetime'];
    uvi = json['uvi'];
    windDir = json['windDir'];
    windLevel = json['windLevel'];
    windSpeed = json['windSpeed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> condition = Map<String, dynamic>();
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['condition'] = this.condition;
    data['conditionId'] = this.conditionId;
    data['humidity'] = this.humidity;
    data['icon'] = this.icon;
    data['pressure'] = this.pressure;
    data['realFeel'] = this.realFeel;
    data['sunRise'] = this.sunRise;
    data['sunSet'] = this.sunSet;
    data['temp'] = this.temp;
    data['tips'] = this.tips;
    data['updatetime'] = this.updatetime;
    data['uvi'] = this.uvi;
    data['windDir'] = this.windDir;
    data['windLevel'] = this.windLevel;
    data['windSpeed'] = this.windSpeed;
    condition['condition'] = data;
    return condition;
  }
}