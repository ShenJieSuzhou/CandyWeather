import 'package:flutter/material.dart';
import 'dart:math';

class WeatherInfo extends StatefulWidget {
  final String tempture, condition, humidity, icon, pressure, 
  realFeel, sunRise, sunSet, uvi, windDir, windLevel, windSpeed;

  WeatherInfo({
    @required this.tempture,
    @required this.condition,
    @required this.humidity,
    @required this.icon,
    @required this.pressure,
    @required this.realFeel,
    @required this.sunRise,
    @required this.sunSet,
    @required this.uvi,
    @required this.windDir,
    @required this.windLevel,
    @required this.windSpeed,
  });

  @override
  _WeatherInfoState createState() => _WeatherInfoState();
}

class _WeatherInfoState extends State<WeatherInfo> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(30, 80, 30, 150),
      child: InkWell(
        child: Container(
         decoration: BoxDecoration(
           shape: BoxShape.rectangle,
           color: Colors.blueAccent,
           borderRadius: BorderRadius.all(Radius.circular(20)),
           boxShadow: [
            BoxShadow(color: Colors.grey[400],offset: Offset(1, 1),blurRadius: 5,),
            BoxShadow(color: Colors.grey[300], offset: Offset(-1, -1), blurRadius: 5),
            BoxShadow(color: Colors.grey[300], offset: Offset(1, -1), blurRadius: 5),
            BoxShadow(color: Colors.grey[400], offset: Offset(-1, 1), blurRadius: 5,)
            ]
         ),
        ),
        onTap: (){

        },
      ),
    );
  }
}
