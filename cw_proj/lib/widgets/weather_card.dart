import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cw_proj/util/theme_utils.dart';
import 'package:cw_proj/Model/condition.dart';

class WeatherInfo extends StatefulWidget {
  final Condition condition;

  WeatherInfo({
    @required this.condition
  });

  @override
  _WeatherInfoState createState() => _WeatherInfoState();
}

class _WeatherInfoState extends State<WeatherInfo> {
  

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
                child: realTimeWeather(width, isDark, widget.condition, "苏州"),
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