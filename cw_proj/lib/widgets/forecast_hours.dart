import 'package:flutter/material.dart';
import 'package:cw_proj/Model/hours.dart';
import 'package:cw_proj/util/theme_utils.dart';
import 'package:cw_proj/res/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ForcastHours extends StatefulWidget {
  final Hours hours;
  const ForcastHours({Key key, this.hours}) : super(key: key);

  @override
  ForcastHoursState createState() => ForcastHoursState();
}

class ForcastHoursState extends State<ForcastHours> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = ThemeUtils.isDark(context);

    List<Widget> widgetlist = [];
    for(int i = 0; i < widget.hours.hourly.length; i++){
      Hourly hourly = widget.hours.hourly[i];
      widgetlist.add(_getHourItem(hourly));
    }

    return Container(
            width: MediaQuery.of(context).size.width - 60,
            decoration: BoxDecoration(
              color: isDark?Color(0xFFf5f5f5) : Color(0xFF1c1c1e),
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
            child: Column(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width - 60,
                  child: Text('24小时预报',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(30),
                      color: isDark? Colours.text : Colours.dark_text
                    )
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.all(0),
                  child: Row(
                    children: widgetlist,
                  ),
                ),
              ],
            ),
      );
  }

  //小时天气的item
Widget _getHourItem(Hourly hourly) {
  return Container(
    height: 130,
    width: 60,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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