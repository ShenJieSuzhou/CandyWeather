import 'package:flutter/material.dart';
import 'package:cw_proj/res/styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cw_proj/res/styles.dart';
import 'package:cw_proj/res/colors.dart';
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
      padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(40.0), ScreenUtil().setWidth(40.0), ScreenUtil().setWidth(40.0), 0.0),
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
            width: width - 60,
            height: ScreenUtil().setHeight(50),
            padding: EdgeInsets.fromLTRB(0, 0.0, 0, 0.0),
            child: Text("23°", 
                      style: TextStyle(
                      fontSize: ScreenUtil().setSp(50),
                    ),
                )
          ),
          Container(
            width: width - 60,
            height: ScreenUtil().setHeight(50),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text("晴间多云", 
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(36),
                    ),
                    ),
                ),
                Align(
                  alignment: FractionalOffset.centerRight,
                  child: Icon(Icons.bookmark, size: ScreenUtil().setWidth(80), color: isDark? Colors.white : Colors.black,),
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
          image: DecorationImage(
            image: AssetImage('assets/SpectralTarsiers_ZH-CN1108590907_1920x1080.jpg'),
            fit: BoxFit.fitHeight
          )
        ),
      ),
    );
  }

  Widget colorTheSoulWords(double width, bool isDark){
    return Container(
      color: Colors.transparent,
      margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
      width: width - 40,
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 5.0,
                height: ScreenUtil().setHeight(100),
                color: Colors.black,
              ),
              SizedBox(
                width: ScreenUtil().setWidth(10),
              ),
              Expanded(
                //child: Text('上面代码中，我们通过TextSpan实现了一个基础文本片段和一个链接片段，然后通过Text.rich 方法'),
                child: Column(
                  children: <Widget>[
                    Text('上面代码中，我们通过TextSpan实现了一个基础文本片段和一个链接片段，然后通过Text.rich 方法'),
                    Align(
                      alignment: FractionalOffset.centerRight,
                      child: Text('- 匿名'),
                    )
                  ],
                ),
              )

            ],
          )
        ],
      ),
      // child: Row(
      //   mainAxisAlignment: MainAxisAlignment.start,
      //   children: <Widget>[
      //       // Container(
      //       //   height: ScreenUtil().setHeight(150),
      //       //   width: ScreenUtil().setWidth(10),
      //       //   color: Color(0xFF31363c),
      //       // ),
      //       // SizedBox(
      //       //   width: 10,
      //       // ),
      //       Column(
      //         children: <Widget>[
      //           Expanded(
      //             child: RichText(
      //               text: TextSpan(
      //                 text: '有许多事,在你还不懂得珍惜之前已成旧事。有许多事,在你还不懂得珍惜之前已成旧事。',
      //                 style: TextStyle(
      //                   color: Colors.black,
      //                 ),
      //               ),
      //             )
      //           ),
      //           Text('-匿名'),
      //         ],
      //       )
      //     ],
      // ),
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
           borderRadius: BorderRadius.all(Radius.circular(20)),
          //  boxShadow: [
          //   BoxShadow(color: Colors.grey[400],offset: Offset(1, 1),blurRadius: 5,),
          //   BoxShadow(color: Colors.grey[300], offset: Offset(-1, -1), blurRadius: 5),
          //   BoxShadow(color: Colors.grey[300], offset: Offset(1, -1), blurRadius: 5),
          //   BoxShadow(color: Colors.grey[400], offset: Offset(-1, 1), blurRadius: 5,)
          //   ]
         ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: ScreenUtil().setHeight(280),
                child: realTimeWeather(width, isDark),
              ),
              SizedBox(
                height: ScreenUtil().setWidth(10),
              ),
              Container(
                height: ScreenUtil().setHeight(350),
                child: bingDeskPic(width),
              ),
              SizedBox(
                height: ScreenUtil().setWidth(10),
              ),
              Container(
                height: ScreenUtil().setHeight(200),
                child: colorTheSoulWords(width, isDark),
                // color: Colors.white,
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