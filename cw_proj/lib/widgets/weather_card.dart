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

  Widget realTimeWeather(double width){
    return Padding(
      padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text("苏州", 
                  style: TextStyle(color: Colors.white, fontSize: 30),
                ),
                SizedBox(
                  width: 10.0,
                ),
                Icon(
                  Icons.location_on, 
                  color: Colors.white,
                  size: 30.0,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Container(
            width: width - 60,
            height: 30.0,
            padding: EdgeInsets.fromLTRB(0, 0.0, 0, 0.0),
            child: Text("23°", style: TextStyle(fontSize: 25, color: Colors.white),),
          ),
          SizedBox(
            height: 0.0,
          ),
          Container(
            width: width - 60,
            height: 45.0,
            child: Row(
              children: <Widget>[
                Container(
                  width: width - 60 - 45 - 40,
                  padding: EdgeInsets.only(left: 0,),
                  child: Text("晴间多云", style: TextStyle(fontSize: 20, color: Colors.white),),
                ),
                Container(
                  width: 45,
                  padding: EdgeInsets.only(right: 0),
                  child: Icon(Icons.bookmark, size: 45, color: Colors.white,),
                )
              ],
            )
          ),
          SizedBox(
            height: 0.0,
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0, 0.0, 0, 5.0),
            child: Text("12小时内不会下雨，请放心出门", style: TextStyle(fontSize: 14, color: Colors.white),),
          )
        ],
      ),
    );
  }

  Widget futureWeather(double height){
    return Container(
      decoration: BoxDecoration(
        
      ),
      height: height,
      padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
      child: ListView.builder(
        primary: false,
        shrinkWrap: true,
        itemExtent: 50,
        itemCount: 5,
        itemBuilder: (BuildContext context, int index){
          return ListTile(title: Text("今天"), 
          subtitle: Text("晴间多云"),
          trailing: Icon(Icons.face),
          contentPadding: EdgeInsets.all(0),);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: realTimeWeather(width),
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                child: futureWeather(220.0),
              )
            ],
          ),
        ),
        onTap: (){
          print("[weather card tap]");
        },
        onLongPress: (){
          print("[weather card onLongPress]");
        },
      ),
    );
  }


} 