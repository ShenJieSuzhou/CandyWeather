import 'package:flutter/material.dart';
import 'package:cw_proj/Model/aqi.dart';
import 'package:cw_proj/util/theme_utils.dart';

class AirQuality extends StatefulWidget {
  AQI aqi;
  AirQuality({this.aqi});

  @override
  _AirQualityState createState() => _AirQualityState();
}

class _AirQualityState extends State<AirQuality> {
  @override
  Widget build(BuildContext context) {
    Map<String, Map> map = widget.aqi.toJson();
    Map<String, String> nmap = map["aqi"];
    List<Map<String, String>> items = List(nmap.keys.length);
    for(int i = 0; i < nmap.keys.length; i++){
      String key = nmap.keys.elementAt(i);
      String value = nmap.values.elementAt(i);
      Map<String, String> temp = Map();
      temp[key] = value;
      items.add(temp);
    }

    double screenW = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      child: Container(
        height:(screenW-40)/3*5, 
        width:screenW,
        child: GridView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 1.0,
          ),
          itemCount: 15,
          itemBuilder: (context, index){
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
              child: cube('空气质量', '良', '99'),
            );
          },
      ),
      ),
    );
  }


  Widget cube(String title, String value ,String extend){
    bool isDark = ThemeUtils.isDark(context);
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.all(Radius.circular(8)),
        color: isDark?Color(0xFF1c1c1e) : Color(0xFFf5f5f5),
      ),
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 10.0,
            left: 20.0,
            child: Text('$title'),
          ),
          Align(
            alignment: Alignment.center,
            child: Text('$value')
          ),
          Positioned(
            left: 20.0,
            bottom: 10.0,
            child: Text('$extend'),
          ),
        ],
      ),
    );
  }
}