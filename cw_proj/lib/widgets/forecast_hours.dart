import 'package:flutter/material.dart';
import 'package:cw_proj/Model/weather_hour.dart';
import 'package:cw_proj/util/theme_utils.dart';

class ForcastHours extends StatefulWidget {
  @override
  _ForcastHoursState createState() => _ForcastHoursState();
}

class _ForcastHoursState extends State<ForcastHours> {
  @override
  Widget build(BuildContext context) {
    bool isDark = ThemeUtils.isDark(context);

    List<Widget> widgets = [];
    for(int i = 0; i < 12; i++){
      widgets.add(_getHourItem(null));
    }

    return Container(
      height: 150,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
        child: Container(
          decoration: BoxDecoration(
            color: isDark?Color(0xFF1c1c1e) : Color(0xFFf5f5f5),
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: widgets,
            ),
          ),
        )
      ),
    );
  }

  //小时天气的item
Widget _getHourItem(WeatherHour hourly) {
  return Container(
    height: 130,
    width: 60,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          "14:00",
          style: TextStyle(color: Colors.black, fontSize: 12),
        ),
        SizedBox(
          height: 20,
        ),
        Image(
          image:
              AssetImage("assets/weatherIcons/W0.png"),
          height: 30,
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          "12℃",
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
      ],
    ),
  );
}
}