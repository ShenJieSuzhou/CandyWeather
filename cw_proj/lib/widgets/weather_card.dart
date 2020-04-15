import 'package:cw_proj/Model/data_key_bean.dart';
import 'package:cw_proj/Model/home_entity.dart';
import 'package:cw_proj/util/network_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cw_proj/util/theme_utils.dart';
import 'package:cw_proj/Model/condition.dart';
import 'package:loading/loading.dart';
import 'package:cw_proj/widgets/HeaderContentView.dart';
import 'package:cw_proj/widgets/air_quality.dart';
import 'package:cw_proj/widgets/forecast_day.dart';
import 'package:cw_proj/widgets/forecast_hours.dart';
import 'package:cw_proj/widgets/live_index.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';

class WeatherInfo extends StatefulWidget {
  final HomeEntity homeEntity;

  WeatherInfo({Key key, this.homeEntity}) : super(key: key);

  @override
  WeatherInfoState createState() => WeatherInfoState();
}

class WeatherInfoState extends State<WeatherInfo> {
  bool isShowLoading = true;
  Loading loading = Loading();
  
  Widget realTimeWeather(double width, bool isDark, Condition condition, String location){
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
                Text(location, 
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
            child: Text(condition.temp + "°",
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
                  child: Text(condition.condition,
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(40),
                    ),
                    ),
                ),
                Align(
                  alignment: FractionalOffset.centerRight,
                  //child: Icon(Ic size: ScreenUtil().setWidth(60), color: isDark? Colors.white : Colors.black,),
                  child: Image.asset("assets/weatherIcons/W" + condition.icon + ".png",width: ScreenUtil().setWidth(60),)
                ),
              ],
            )
          ),
          SizedBox(
            height: ScreenUtil().setHeight(20),
          ),
          Expanded(
            child: Text(condition.tips, 
                      style: TextStyle(
                      fontSize: ScreenUtil().setSp(32),
                    ),
              ),
          ),
        ],
      ),
    );
  }

  Widget bingDeskPic(double width, String picPath){
    return Container(
      margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(8)),
          image: DecorationImage(
            image: AssetImage(picPath),
            fit: BoxFit.fitHeight
          )
        ),
      ),
    );
  }

  Widget colorTheSoulWords(Map<String, String> jitang, bool isDark){
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
                child: Column(
                  children: <Widget>[
                    Text(jitang["data"],
                        style: TextStyle(
                            fontSize: ScreenUtil().setSp(30),
                          ),
                    ),
                    Align(
                      alignment: FractionalOffset.centerRight,
                      child: Text('- ${jitang["name"]}',
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

  @override
  Widget build(BuildContext context) {
    bool isDark = ThemeUtils.isDark(context);
    double width = MediaQuery.of(context).size.width;
    return Column(
      children: <Widget>[
      Container(
          color: Colors.transparent,
          width: ScreenUtil.screenWidth,
          height: ScreenUtil().setHeight(180),
          child: HeaderContentView()
      ),
      SizedBox(
        height: ScreenUtil().setHeight(10),
      ),
      Padding(
        padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(60), 0, ScreenUtil().setWidth(60), 0),
        child: InkWell(
          child: Container(
            decoration: BoxDecoration(
            shape: BoxShape.rectangle, color: isDark?Color(0xFF1c1c1e) : Color(0xFFf5f5f5),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
                Container(
                  height: ScreenUtil().setHeight(310),
                  child: realTimeWeather(width, isDark, widget.homeEntity.condition, widget.homeEntity.cityName),
                ),
                SizedBox(
                  height: ScreenUtil().setWidth(10),
                ),
                Container(
                  height: ScreenUtil().setHeight(420),
                  child: bingDeskPic(width, "assets/SpectralTarsiers_ZH-CN1108590907_1920x1080.jpg"),
                ),
                SizedBox(
                  height: ScreenUtil().setWidth(10),
                ),
                Container(
                  height: ScreenUtil().setHeight(200),
                  child: colorTheSoulWords(widget.homeEntity.jiTang ,isDark),
                ),
              ],
            ),
          ) ,
          onTap: (){
            print("[weather card tap]");
          },
          onLongPress: (){
            print("[weather card onLongPress]");
          },
          ),
        ),
        SizedBox(
          height: ScreenUtil().setHeight(10),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(
              30.0, 10.0, 30.0, 10.0),
          child: Container(
              height: 350.0,
              width: ScreenUtil.screenWidth,
              decoration: BoxDecoration(
                color: isDark ? Color(0xFF1c1c1e) : Color(
                    0xFFf5f5f5),
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.all(
                    Radius.circular(8)),
              ),
              child: ForcastDay(weatherResult: widget.homeEntity.daily,)
          ),
        ),
        ForcastHours(hours: widget.homeEntity.hour,),
        AirQuality(aqi: widget.homeEntity.aqi,),
        LiveIndex(live: widget.homeEntity.live),
      ],
    );






//    return FutureBuilder(
//        future: fetchCondition(cityId),
//        builder: (BuildContext context, AsyncSnapshot snapshot) {
//          // 请求已结束
//          if (snapshot.connectionState == ConnectionState.done) {
//            if (snapshot.hasError) {
//              // 请求失败，显示错误
//              return Text("Error: ${snapshot.error}");
//            } else {
//              // 请求成功，显示数据
//              Condition condition = snapshot.data;
//              return Padding(
//                padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(60), 0, ScreenUtil().setWidth(60), 0),
//                child: InkWell(
//                  child: Container(
//                    decoration: BoxDecoration(
//                      shape: BoxShape.rectangle,
//                      color: isDark?Color(0xFF1c1c1e) : Color(0xFFf5f5f5),
//                      borderRadius: BorderRadius.all(Radius.circular(10)),
//                    ),
//                    child: Column(
//                      crossAxisAlignment: CrossAxisAlignment.start,
//                      children: <Widget>[
//                        Container(
//                          height: ScreenUtil().setHeight(310),
//                          child: realTimeWeather(width, isDark, condition, widget.record.name),
//                        ),
//                        SizedBox(
//                          height: ScreenUtil().setWidth(10),
//                        ),
//                        Container(
//                          height: ScreenUtil().setHeight(420),
//                          child: bingDeskPic(width, "assets/SpectralTarsiers_ZH-CN1108590907_1920x1080.jpg"),
//                        ),
//                        SizedBox(
//                          height: ScreenUtil().setWidth(10),
//                        ),
//                        Container(
//                          height: ScreenUtil().setHeight(200),
//                          child: colorTheSoulWords(isDark),
//                        ),
//                      ],
//                    ),
//                  ),
//                  onTap: (){
//                    print("[weather card tap]");
//                  },
//                  onLongPress: (){
//                    print("[weather card onLongPress]");
//                  },
//                ),
//              );
//            }
//          } else {
//            // 请求未结束，显示loading
//            return Center(
//              child: Loading(
//                indicator: BallPulseIndicator(),
//                size: 30.0,
//                color: isDark? Colors.white : Colors.black,
//              ),
//            );
//          }
//        });
  }
} 