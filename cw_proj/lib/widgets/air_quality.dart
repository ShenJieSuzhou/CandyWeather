import 'package:flutter/material.dart';
import 'package:cw_proj/Model/aqi.dart';
import 'package:cw_proj/util/theme_utils.dart';
import 'package:cw_proj/res/colors.dart';

class AirQuality extends StatefulWidget {
  AQI aqi;

  AirQuality({Key key, this.aqi}) : super(key: key);

  @override
  AirQualityState createState() => AirQualityState();
}

class AirQualityState extends State<AirQuality> {
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> map = widget.aqi.toJson();
    Map<String, String> nmap = map["aqi"];
    List<Map<String, String>> items = [];
    for(int i = 0; i < nmap.keys.length; i++){
      String key = nmap.keys.elementAt(i);
      if((key == "pubtime") || (key == "rank") || (key == "so2C")){
        continue;
      }
      String value = nmap.values.elementAt(i);
      Map<String, String> temp = Map();
      temp[key] = value;
      items.add(temp);
    }

    double screenW = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      child: Container(
        height:(screenW-40)/3*4, 
        width:screenW,
        child: GridView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 1.0,
          ),
          itemCount: 12,//items.length,
          itemBuilder: (context, index){
            if(items[index].containsKey("value")){
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
                child: cube('空气质量', '良', items[index]["value"]),
              );
            }else if(items[index].containsKey("co")){
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
                child: cube('一氧化碳', 'co', items[index]["co"]),
              );
            }else if(items[index].containsKey("no2")){
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
                child: cube('二氧化氮', 'no2', items[index]["no2"]),
              );
            }else if(items[index].containsKey("o3")){
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
                child: cube('臭氧', 'o3', items[index]["o3"]),
              );
            }else if(items[index].containsKey("pm10")){
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
                child: cube('PM10指数', 'pm10', items[index]["pm10"]),
              );
            }else if(items[index].containsKey("pm25")){
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
                child: cube('PM2.5指数', 'pm25', items[index]["pm25"]),
              );
            }else if(items[index].containsKey("so2")){
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
                child: cube('二氧化硫', 'so2', items[index]["so2"]),
              );
            }else if(items[index].containsKey("pm25C")){
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
                child: cube('PM2.5浓度', 'pm25C', items[index]["pm25C"]),
              );
            }else if(items[index].containsKey("coC")){
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
                child: cube('一氧化碳浓度', 'coC', items[index]["coC"]),
              );
            }else if(items[index].containsKey("no2C")){
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
                child: cube('二氧化氮浓度', 'no2C', items[index]["no2C"]),
              );
            }else if(items[index].containsKey("o3C")){
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
                child: cube('臭氧浓度', 'o3C', items[index]["o3C"]),
              );
            }else if(items[index].containsKey("pm10C")){
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
                child: cube('PM10浓度', 'pm10C', items[index]["pm10C"]),
              );
            }
            // else if(items[index].containsKey("so2C")){
            //   return Padding(
            //     padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
            //     child: cube('二氧化硫浓度', 'so2C', items[index]["so2C"]),
            //   );
            // }
            return SizedBox(
              height: 0,
            );
          },
      ),
      ),
    );
  }

  Widget cube(String title, String extend, String value){
    bool isDark = ThemeUtils.isDark(context);
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.all(Radius.circular(8)),
        color: isDark?Color(0xFFf5f5f5) : Color(0xFF1c1c1e),
      ),
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 10.0,
            left: 20.0,
            child: Text('$title', 
              style: TextStyle(
                      color: isDark? Colours.text : Colours.dark_text
                    ),
              ),
          ),
          Align(
            alignment: Alignment.center,
            child: Text('$value',
              style: TextStyle(
                      color: isDark? Colours.text : Colours.dark_text
                    ),
            )
          ),
          Positioned(
            left: 20.0,
            bottom: 10.0,
            child: Text('$extend',
              style: TextStyle(
                      color: isDark? Colours.text : Colours.dark_text
                    ),
            ),
          ),
        ],
      ),
    );
  }

  void refreshAQI(AQI result){
    widget.aqi = result;
    setState(() {

    });
  }
}