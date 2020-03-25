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
  String pressure;
  String realFeel;
  String temp;
  String uvi;
  String windDir;
  String windSpeed;

  Hourly(
      {this.condition,
      this.conditionId,
      this.date,
      this.hour,
      this.humidity,
      this.iconDay,
      this.iconNight,
      this.pressure,
      this.realFeel,
      this.temp,
      this.uvi,
      this.windDir,
      this.windSpeed});

  Hourly.fromJson(Map<String, dynamic> json) {
    condition = json['condition'];
    conditionId = json['conditionId'];
    date = json['date'];
    hour = json['hour'];
    humidity = json['humidity'];
    iconDay = json['iconDay'];
    iconNight = json['iconNight'];
    pressure = json['pressure'];
    realFeel = json['realFeel'];
    temp = json['temp'];
    uvi = json['uvi'];
    windDir = json['windDir'];
    windSpeed = json['windSpeed'];
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
    data['pressure'] = this.pressure;
    data['realFeel'] = this.realFeel;
    data['temp'] = this.temp;
    data['uvi'] = this.uvi;
    data['windDir'] = this.windDir;
    data['windSpeed'] = this.windSpeed;
    return data;
  }
}