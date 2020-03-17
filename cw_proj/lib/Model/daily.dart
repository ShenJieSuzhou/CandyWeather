class Daily {
  List<Forecast> forecast;

  Daily({this.forecast});

  Daily.fromJson(Map<String, dynamic> json) {
    if (json['forecast'] != null) {
      forecast = new List<Forecast>();
      json['forecast'].forEach((v) {
        forecast.add(new Forecast.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.forecast != null) {
      data['forecast'] = this.forecast.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Forecast {
  String conditionDay;
  String conditionIdDay;
  String conditionIdNight;
  String conditionNight;
  String moonphase;
  String moonrise;
  String moonset;
  String predictDate;
  String sunrise;
  String sunset;
  String tempDay;
  String tempNight;
  String updatetime;
  String windDirDay;
  String windDirNight;
  String windLevelDay;
  String windLevelNight;
  String windSpeedDay;
  String windSpeedNight;

  Forecast(
      {this.conditionDay,
      this.conditionIdDay,
      this.conditionIdNight,
      this.conditionNight,
      this.moonphase,
      this.moonrise,
      this.moonset,
      this.predictDate,
      this.sunrise,
      this.sunset,
      this.tempDay,
      this.tempNight,
      this.updatetime,
      this.windDirDay,
      this.windDirNight,
      this.windLevelDay,
      this.windLevelNight,
      this.windSpeedDay,
      this.windSpeedNight});

  Forecast.fromJson(Map<String, dynamic> json) {
    conditionDay = json['conditionDay'];
    conditionIdDay = json['conditionIdDay'];
    conditionIdNight = json['conditionIdNight'];
    conditionNight = json['conditionNight'];
    moonphase = json['moonphase'];
    moonrise = json['moonrise'];
    moonset = json['moonset'];
    predictDate = json['predictDate'];
    sunrise = json['sunrise'];
    sunset = json['sunset'];
    tempDay = json['tempDay'];
    tempNight = json['tempNight'];
    updatetime = json['updatetime'];
    windDirDay = json['windDirDay'];
    windDirNight = json['windDirNight'];
    windLevelDay = json['windLevelDay'];
    windLevelNight = json['windLevelNight'];
    windSpeedDay = json['windSpeedDay'];
    windSpeedNight = json['windSpeedNight'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['conditionDay'] = this.conditionDay;
    data['conditionIdDay'] = this.conditionIdDay;
    data['conditionIdNight'] = this.conditionIdNight;
    data['conditionNight'] = this.conditionNight;
    data['moonphase'] = this.moonphase;
    data['moonrise'] = this.moonrise;
    data['moonset'] = this.moonset;
    data['predictDate'] = this.predictDate;
    data['sunrise'] = this.sunrise;
    data['sunset'] = this.sunset;
    data['tempDay'] = this.tempDay;
    data['tempNight'] = this.tempNight;
    data['updatetime'] = this.updatetime;
    data['windDirDay'] = this.windDirDay;
    data['windDirNight'] = this.windDirNight;
    data['windLevelDay'] = this.windLevelDay;
    data['windLevelNight'] = this.windLevelNight;
    data['windSpeedDay'] = this.windSpeedDay;
    data['windSpeedNight'] = this.windSpeedNight;
    return data;
  }
}