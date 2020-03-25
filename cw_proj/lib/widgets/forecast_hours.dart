import 'package:flutter/material.dart';
import 'package:cw_proj/Model/hours.dart';
import 'package:cw_proj/util/theme_utils.dart';

class ForcastHours extends StatefulWidget {
  final Hours hours;
  const ForcastHours({Key key, this.hours}) : super(key: key);

  @override
  _ForcastHoursState createState() => _ForcastHoursState();
}

class _ForcastHoursState extends State<ForcastHours> {
  @override
  Widget build(BuildContext context) {
    bool isDark = ThemeUtils.isDark(context);

    List<Widget> widgetlist = [];
    for(int i = 0; i < widget.hours.hourly.length; i++){
      Hourly hourly = widget.hours.hourly[i];
      widgetlist.add(_getHourItem(hourly));
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
              children: widgetlist,
            ),
          ),
        )
      ),
    );
  }

  //小时天气的item
Widget _getHourItem(Hourly hourly) {
  return Container(
    height: 130,
    width: 60,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          hourly.hour + ":00",
          style: TextStyle(color: Colors.black, fontSize: 12),
        ),
        SizedBox(
          height: 20,
        ),
        Image(
          image:
                isDayTime(int.parse(hourly.hour)) ? AssetImage("assets/weatherIcons/W" + hourly.iconDay + ".png"):AssetImage("assets/weatherIcons/W" + hourly.iconNight + ".png"),
          height: 30,
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          hourly.temp + "℃",
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
      ],
    ),
  );
}

  bool isDayTime(int hour){
    if(hour >= 6 && hour <= 24){
      return true;
    }

    return false;
  }
}