import 'package:flutter/material.dart';
import 'package:cw_proj/Model/weather_hour.dart';

class ForcastHours extends StatefulWidget {
  @override
  _ForcastHoursState createState() => _ForcastHoursState();
}

class _ForcastHoursState extends State<ForcastHours> {
  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [];
    for(int i = 0; i < 12; i++){
      widgets.add(_getHourItem(null));
    }

    return Container(
      height: 150,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: widgets,
          ),
        )
      ),
    );
  }

  //小时天气的item
Widget _getHourItem(WeatherHour hourly) {
  return Container(
    height: 110,
    width: 80,
    padding: EdgeInsets.all(10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          "14:00",
          style: TextStyle(color: Colors.white, fontSize: 12),
        ),
        SizedBox(
          height: 10,
        ),
        Image(
          image:
              AssetImage("assets/weatherIcons/W0.png"),
          height: 30,
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          "12℃",
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ],
    ),
  );
}
}