import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cw_proj/util/theme_utils.dart';

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
  

  Widget realTimeWeather(double width, bool isDark){
    return Padding(
      padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(40.0), ScreenUtil().setWidth(40.0), ScreenUtil().setWidth(40.0), 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: ScreenUtil().setHeight(50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text("苏州", 
                  style: TextStyle(
                      fontSize: ScreenUtil().setSp(50),
                    ),
                ),
                SizedBox(
                  width: ScreenUtil().setWidth(10.0),
                ),
                Icon(
                  Icons.location_on, 
                  color: isDark? Colors.white : Colors.black,
                  size: ScreenUtil().setWidth(45.0),
                ),
              ],
            ),
          ),
          SizedBox(
            height: ScreenUtil().setWidth(20.0),
          ),
          Container(
            height: ScreenUtil().setHeight(50),
            child: Text("23°", 
                      style: TextStyle(
                      fontSize: ScreenUtil().setSp(50),
                    ),
                )
          ),
           SizedBox(
            height: ScreenUtil().setWidth(20.0),
          ),
          Container(
            height: ScreenUtil().setHeight(50),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text("晴间多云", 
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(40),
                    ),
                    ),
                ),
                Align(
                  alignment: FractionalOffset.centerRight,
                  child: Icon(Icons.bookmark, size: ScreenUtil().setWidth(60), color: isDark? Colors.white : Colors.black,),
                ),
              ],
            )
          ),
          SizedBox(
            height: ScreenUtil().setHeight(20),
          ),
          Expanded(
            child: Text("12小时内不会下雨，请放心出门", 
                      style: TextStyle(
                      fontSize: ScreenUtil().setSp(32),
                    ),
              ),
          ),
        ],
      ),
    );
  }

  Widget bingDeskPic(double width){
    return Container(
      margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(8)),
          image: DecorationImage(
            image: AssetImage('assets/SpectralTarsiers_ZH-CN1108590907_1920x1080.jpg'),
            fit: BoxFit.fitHeight
          )
        ),
      ),
    );
  }

  Widget colorTheSoulWords(bool isDark){
    return Container(
      color: Colors.transparent,
      padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 5.0,
                height: ScreenUtil().setHeight(120),
                color: Colors.black,
              ),
              SizedBox(
                width: ScreenUtil().setWidth(20),
              ),
              Expanded(
                //child: Text('上面代码中，我们通过TextSpan实现了一个基础文本片段和一个链接片段，然后通过Text.rich 方法'),
                child: Column(
                  children: <Widget>[
                    Text('有许多事,在你还不懂得珍惜之前已成旧事。有许多事,在你还不懂得珍惜之前已成旧事。',
                        style: TextStyle(
                            fontSize: ScreenUtil().setSp(30),
                          ),
                    ),
                    Align(
                      alignment: FractionalOffset.centerRight,
                      child: Text('- 匿名',
                          style: TextStyle(
                            fontSize: ScreenUtil().setSp(30),
                          ),
                        ),
                    )
                  ],
                ),
              )

            ],
          )
        ],
      ),
    );
  }

  // Widget futureWeather(double height){
  //   return Container(
  //     decoration: BoxDecoration(
        
  //     ),
  //     height: height,
  //     padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
  //     child: ListView.builder(
  //       primary: false,
  //       shrinkWrap: true,
  //       itemExtent: 50,
  //       itemCount: 5,
  //       itemBuilder: (BuildContext context, int index){
  //         return ListTile(title: Text("今天"), 
  //         subtitle: Text("晴间多云"),
  //         trailing: Icon(Icons.face),
  //         contentPadding: EdgeInsets.all(0),);
  //       },
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    bool isDark = ThemeUtils.isDark(context);
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(60), 0, ScreenUtil().setWidth(60), 0),
      child: InkWell(
        child: Container(
         decoration: BoxDecoration(
           shape: BoxShape.rectangle,
           color: isDark?Color(0xFF1c1c1e) : Color(0xFFf5f5f5),
           borderRadius: BorderRadius.all(Radius.circular(10)),
         ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: ScreenUtil().setHeight(310),
                child: realTimeWeather(width, isDark),
              ),
              SizedBox(
                height: ScreenUtil().setWidth(10),
              ),
              Container(
                height: ScreenUtil().setHeight(420),
                child: bingDeskPic(width),
              ),
              SizedBox(
                height: ScreenUtil().setWidth(10),
              ),
              Container(
                height: ScreenUtil().setHeight(200),
                child: colorTheSoulWords(isDark),
              ),
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