class AQI{
  String cityName;
  String co;
  String coC;
  String no2;
  String no2C;
  String o3;
  String o3C;
  String pm10;
  String pm10C;
  String pm25;
  String pm25C;
  String pubtime;
  String rank;
  String so2;
  String so2C;
  String value;

  AQI({
    this.cityName,
    this.co,
    this.coC,
    this.no2,
    this.no2C,
    this.o3,
    this.o3C,
    this.pm10,
    this.pm10C,
    this.pm25,
    this.pm25C,
    this.pubtime,
    this.rank,
    this.so2,
    this.so2C,
    this.value
  });

  AQI.fromJson(Map<String, dynamic> mJSON) {
    Map<String, dynamic> json = mJSON['aqi'];
    cityName = json['cityName'];
    co = json['co'];
    coC = json['coC'];
    no2 = json['no2'];
    no2C = json['no2C'];
    o3 = json['o3'];
    o3C = json['o3C'];
    pm10 = json['pm10'];
    pm10C = json['pm10C'];
    pm25 = json['pm25'];
    pm25C = json['pm25C'];
    pubtime = json['pubtime'];
    rank = json['rank'];
    so2 = json['so2'];
    so2C = json['so2C'];
    value = json['value'];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> aqi = Map<String, dynamic>();
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['co'] = this.co;
    data['coC'] = this.coC;
    data['no2'] = this.no2;
    data['no2C'] = this.no2C;
    data['o3'] = this.o3;
    data['o3C'] = this.o3C;
    data['pm10'] = this.pm10;
    data['pm10C'] = this.pm10C;
    data['pm25'] = this.pm25;
    data['pm25C'] = this.pm25C;
    data['pubtime'] = this.pubtime;
    data['rank'] = this.rank;
    data['so2'] = this.so2;
    data['so2C'] = this.so2C;
    data['value'] = this.value;

    aqi['aqi'] = data;
    return aqi;
  }
}