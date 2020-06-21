import 'dart:math';
import 'dart:typed_data';

import 'package:cw_proj/Model/home_entity.dart';
import 'package:cw_proj/res/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cw_proj/util/theme_utils.dart';
import 'package:cw_proj/Model/condition.dart';
import 'package:loading/loading.dart';
import 'package:cw_proj/widgets/HeaderContentView.dart';
import 'package:cw_proj/widgets/air_quality.dart';
import 'package:cw_proj/widgets/forecast_day.dart';
import 'package:cw_proj/widgets/forecast_hours.dart';
import 'package:cw_proj/widgets/live_index.dart';
import 'package:provider/provider.dart';
import 'dart:ui' as ui;

class WeatherInfoView extends StatefulWidget {
  final HomeEntity homeEntity;

  WeatherInfoView({Key key, this.homeEntity}) : super(key: key);

  @override
  WeatherInfoState createState() => WeatherInfoState();
}

class WeatherInfoState extends State<WeatherInfoView> {
  bool isShowLoading = true;
  Loading loading = Loading();
  Random random = Random();

  // listView 滚动控制器 
  ScrollController _controller = new ScrollController();
  // 是否允许复位的标记
  bool allowJumpTo = false;
  // 复位高度
  double criticalH = 0.0;

  @override
  void initState() {
    super.initState();
    //监听滚动事件，打印滚动位置
    _controller.addListener(() {
      if (_controller.offset < 300 && allowJumpTo) {
        setState(() {
          allowJumpTo = false;
        });
        _controller.animateTo(.0, duration: Duration(milliseconds: 200), curve: Curves.ease);
      } else if (_controller.offset >= 150 && allowJumpTo == false) {
        setState(() {
          allowJumpTo = true;  
        });
        _controller.animateTo(criticalH, duration: Duration(milliseconds: 200), curve: Curves.ease);
      }
    });
 
    // // 获取 rootbundle
    // AssetBundle bundle = rootBundle;
    // // 加载天气图形
    // _loadAssets(bundle).then((_){
    //   setState(() {
    //     assetsLoaded = true;
    //     weatherWorld = new WeatherWorld();
    //   });
    // });   
  }

  @override
  void dispose(){
    _controller.dispose();
    super.dispose();
  }


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
                      color: isDark? Colours.text : Colours.dark_text
                    ),
                ),
                SizedBox(
                  width: ScreenUtil().setWidth(10.0),
                ),
                Icon(
                  Icons.location_on, 
                  size: ScreenUtil().setWidth(45.0),
                  color: isDark? Colours.text : Colours.dark_text,
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
                      color: isDark? Colours.text : Colours.dark_text
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
                      color: isDark? Colours.text : Colours.dark_text
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
                      color: isDark? Colours.text : Colours.dark_text
                    ),
              ),
          ),
        ],
      ),
    );
  }

  Widget bingDeskPic(double width, String picPath){
    return Builder(
      builder: (BuildContext context) {
        // var result = Provider.of<BingModel>(context).change;
        return Container(
          margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            child: FadeInImage.assetNetwork(
              placeholder: "assets/bingPlaceholder/placeholder${random.nextInt(14)}.png", 
              image: picPath,
              fit: BoxFit.cover,
            ),
          ),
        );
      },
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
                color: isDark? Colors.black : Colors.white
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
                            color: isDark? Colours.text : Colours.dark_text
                          ),
                    ),
                    Align(
                      alignment: FractionalOffset.centerRight,
                      child: Text('- ${jitang["name"]}',
                          style: TextStyle(
                            fontSize: ScreenUtil().setSp(30),
                            color: isDark? Colours.text : Colours.dark_text
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

  // 截图boundary，并且返回图片的二进制数据。
  Future<Uint8List> _capturePng(GlobalKey globalKey) async {
    print("call the capturePng");
    RenderRepaintBoundary boundary = globalKey.currentContext.findRenderObject();
    ui.Image image = await boundary.toImage();
    // 注意：png是压缩后格式，如果需要图片的原始像素数据，请使用rawRgba
    ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List pngBytes = byteData.buffer.asUint8List();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text('Dialog'),
            content: Image.memory(pngBytes),
            actions: <Widget>[
              new FlatButton(
                child: new Text("取消"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              new FlatButton(
                child: new Text("确定"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ));
    return pngBytes;
  }


  @override
  Widget build(BuildContext context) {
    bool isDark = ThemeUtils.isDark(context);
    double width = MediaQuery.of(context).size.width;
    final size = MediaQuery.of(context).size;
    double screenHeight = size.height;
    double statusBarHeight = MediaQuery.of(context).padding.top;
    double appBarHeight = AppBar().preferredSize.height;
    criticalH = screenHeight - appBarHeight - statusBarHeight - 50;

    GlobalKey globalKey = new GlobalKey();
    return Column(
      children: <Widget>[
        Expanded(
          child: ListView.builder(
            itemCount: 1,
            controller: _controller,
            itemBuilder: (context, index) {
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
                  RepaintBoundary(
                    key: globalKey,
                    child: Padding(
                    padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(60), 0, ScreenUtil().setWidth(60), 0),
                    child: InkWell(
                      child: Container(
                        decoration: BoxDecoration(
                        shape: BoxShape.rectangle, 
                        color: isDark?Color(0xFFf5f5f5) : Color(0xFF1c1c1e),
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
                              child: bingDeskPic(width, "https://bing.ioliu.cn/v1/rand/?d=1&w=640&h=480"),
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
                      onLongPress: () {
                        print("[weather card tap]");
                        _capturePng(globalKey);

                        
                        // Uint8List imgByte = await _capturePng(globalKey);
                        // showDialog(
                        //   context: context,
                        //   builder: (_) {
                        //     return Padding(
                        //         padding: EdgeInsets.all(16),
                        //         child: Container(
                        //           child: Text('Custom Dialog',
                        //                   style: TextStyle(
                        //                     fontSize: 16,
                        //                     decoration: TextDecoration.none),
                        //             ),
                        //         ),
                        //     );
                        //   }
                        // );
                      },
                      ),
                    ),
                  ),
                    SizedBox(
                      height: ScreenUtil().setHeight(40),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                          30.0, 10.0, 30.0, 10.0),
                      child: Container(
                          height: 400.0,
                          width: ScreenUtil.screenWidth,
                          decoration: BoxDecoration(
                            color: isDark?Color(0xFFf5f5f5) : Color(0xFF1c1c1e),
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.all(
                                Radius.circular(8)),
                          ),
                          child: ForcastDay(weatherResult: widget.homeEntity.daily,)
                      ),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(20),
                    ),
                    ForcastHours(hours: widget.homeEntity.hour,),
                    SizedBox(
                      height: ScreenUtil().setHeight(30),
                    ),
                    AirQuality(aqi: widget.homeEntity.aqi,),
                    SizedBox(
                      height: ScreenUtil().setHeight(30),
                    ),
                    LiveIndex(live: widget.homeEntity.live),
                  ],
                );
              }
            ) 
          )
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