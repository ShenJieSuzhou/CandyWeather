class Hours {
  List<Hourly> hourly;

  Hours({this.hourly});

  Hours.fromJson(Map<String, dynamic> json) {
    if (json['hourly'] != null) {
      hourly = new List<Hourly>();
      json['hourly'].forEach((v) {
        hourly.add(new Hourly.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.hourly != null) {
      data['hourly'] = this.hourly.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Hourly {
  String condition;
  String conditionId;
  String date;
  String hour;
  String humidity;
  String iconDay;
  String iconNight;
  String pop;
  String pressure;
  String qpf;
  String realFeel;
  String snow;
  String temp;
  String updatetime;
  String uvi;
  String windDegrees;
  String windDir;
  String windSpeed;
  String windlevel;

  Hourly(
      {this.condition,
      this.conditionId,
      this.date,
      this.hour,
      this.humidity,
      this.iconDay,
      this.iconNight,
      this.pop,
      this.pressure,
      this.qpf,
      this.realFeel,
      this.snow,
      this.temp,
      this.updatetime,
      this.uvi,
      this.windDegrees,
      this.windDir,
      this.windSpeed,
      this.windlevel});

  Hourly.fromJson(Map<String, dynamic> json) {
    condition = json['condition'];
    conditionId = json['conditionId'];
    date = json['date'];
    hour = json['hour'];
    humidity = json['humidity'];
    iconDay = json['iconDay'];
    iconNight = json['iconNight'];
    pop = json['pop'];
    pressure = json['pressure'];
    qpf = json['qpf'];
    realFeel = json['realFeel'];
    snow = json['snow'];
    temp = json['temp'];
    updatetime = json['updatetime'];
    uvi = json['uvi'];
    windDegrees = json['windDegrees'];
    windDir = json['windDir'];
    windSpeed = json['windSpeed'];
    windlevel = json['windlevel'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['condition'] = this.condition;
    data['conditionId'] = this.conditionId;
    data['date'] = this.date;
    data['hour'] = this.hour;
    data['humidity'] = this.humidity;
    data['iconDay'] = this.iconDay;
    data['iconNight'] = this.iconNight;
    data['pop'] = this.pop;
    data['pressure'] = this.pressure;
    data['qpf'] = this.qpf;
    data['realFeel'] = this.realFeel;
    data['snow'] = this.snow;
    data['temp'] = this.temp;
    data['updatetime'] = this.updatetime;
    data['uvi'] = this.uvi;
    data['windDegrees'] = this.windDegrees;
    data['windDir'] = this.windDir;
    data['windSpeed'] = this.windSpeed;
    data['windlevel'] = this.windlevel;
    return data;
  }
}