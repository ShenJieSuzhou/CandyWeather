
import 'package:flutter/material.dart';
import 'package:cw_proj/Model/daily.dart';
import 'dart:ui' as ui;
import 'package:cw_proj/util/time_util.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'dart:typed_data';
import 'package:cw_proj/res/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cw_proj/util/theme_utils.dart';

class ForcastDay extends StatefulWidget {
  final Daily weatherResult;
  const ForcastDay({Key key, this.weatherResult}) : super(key: key);
  

  @override
  ForcastDayState createState() => ForcastDayState();
}

class ForcastDayState extends State<ForcastDay> {
  
  List<Forecast> dailys = [];
  List<ui.Image> dayIcons = [];
  List<ui.Image> nightIcons = [];
  bool imageLoaded = false;

  @override
  void initState() {

    super.initState();
    for(int i = 0; i < 7; i++){
      Forecast forecast = widget.weatherResult.forecast[i];
      dailys.add(forecast);
    }

    Forecast forecast = widget.weatherResult.forecast[0];
    initDayImage("assets/weatherIcons/W" + forecast.conditionIdDay + ".png");
    initNightImage("assets/weatherIcons/W" +forecast.conditionIdNight + ".png"); 
  }

  @override
  Widget build(BuildContext context) {
    double screenW = MediaQuery.of(context).size.width;
    double itemWidth = (screenW - 60) / 7;
    bool isDark = ThemeUtils.isDark(context);
    if(imageLoaded){
      return Column(
        children: <Widget>[
          Container(
            width: screenW - 60,
            padding: EdgeInsets.fromLTRB(10, 10, 0, 10),
            child: Text('5天天气预报',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: ScreenUtil().setSp(30),
                color: isDark? Colours.text : Colours.dark_text
              )
            ),
          ),
          CustomPaint(
            painter: _futureWeatherPainter(dailys, dayIcons, nightIcons, itemWidth),
            size: Size(screenW - 60, 350),
          ),
        ],
      );
    }else{
      return Container(

      );
    }
  }

  Future <Null> initDayImage(String path) async {
    final ByteData data = await rootBundle.load(path);
    ui.Image image = await loadDayImage(new Uint8List.view(data.buffer));
    dayIcons.add(image);
    int length = dailys.length;
    if (dayIcons.length < length) {
      var dayNight = dailys[dayIcons.length].conditionIdDay;
      initDayImage("assets/weatherIcons/W" + dayNight + ".png");
    }else{
      if(dayIcons.length == length && dayIcons.length == length){
        setState(() {
          imageLoaded = true;
        });
      }
    }
  }

  //加载白天天气图片
  Future<ui.Image> loadDayImage(List<int> img) async {

    final Completer<ui.Image> completer = new Completer();
    ui.decodeImageFromList(img, (ui.Image img) {
      return completer.complete(img);
    });
    return completer.future;
  }

  Future <Null> initNightImage(String path) async {
    final ByteData data = await rootBundle.load(path);
    ui.Image image = await loadDayImage(new Uint8List.view(data.buffer));
    nightIcons.add(image);
    int length = dailys.length;
    if (nightIcons.length < length) {
      var dayNight = dailys[dayIcons.length].conditionIdNight;
      initNightImage("assets/weatherIcons/W" + dayNight + ".png");
    }else{
      if(nightIcons.length == length && dayIcons.length == length){
        setState(() {
          imageLoaded = true;
        });
      }
    }
  }

  //加载白天天气图片
  Future<ui.Image> loadNightImage(List<int> img) async {

    final Completer<ui.Image> completer = new Completer();
    ui.decodeImageFromList(img, (ui.Image img) {
      return completer.complete(img);
    });
    return completer.future;
  }

  void refresh(Daily w_result){
    dailys.clear();
    dayIcons.clear();
    nightIcons.clear();

    for(int i = 0; i < 7; i++){
      Forecast forecast = w_result.forecast[i];
      dailys.add(forecast);
    }

    Forecast forecast = w_result.forecast[0];
    initDayImage("assets/weatherIcons/W" + forecast.conditionIdDay + ".png");
    initNightImage("assets/weatherIcons/W" +forecast.conditionIdNight + ".png"); 
    setState(() {
      
    });
  }
}

class _futureWeatherPainter extends CustomPainter {
  _futureWeatherPainter(this.dailys, this.dayIcons, this.nightIcons, this.itemWidth, );
  final List<Forecast> dailys;
  final List<ui.Image> dayIcons;
  final List<ui.Image> nightIcons;
  final double itemWidth;
  final double textHeight = 130;
  final double temHeight = 80;
  int maxTem, minTem;

  @override
  void paint(Canvas canvas, Size size) {
    setMinMax();

    var maxPaint = new Paint()
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..color = Color(0xff1c1c1e)
      ..isAntiAlias = true
      ..strokeWidth = 2;

    var minPaint = new Paint()
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..color = Color(0xffb6b6b6)
      ..isAntiAlias = true
      ..strokeWidth = 2;

    var pointPaint = Paint()
      ..color = Color(0xff959498)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..isAntiAlias = true
      ..strokeWidth = 8;

    var linePaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 0.5
      ..style = PaintingStyle.stroke;

    var maxPath = new Path();
    var minPath = new Path();

    List<Offset> maxPoints = [];
    List<Offset> minPoints = [];
    double oneTemHeight = temHeight / (maxTem - minTem);

    for(int i = 0; i < dailys.length; i++){
      var daily = dailys[i];
      var dx = itemWidth/2 + itemWidth * i;
      var maxDy = textHeight + (maxTem - int.parse(daily.tempDay)) * oneTemHeight + 5;
      var minDy = textHeight + (maxTem - int.parse(daily.tempNight)) * oneTemHeight - 5;
      var maxOffset = Offset(dx, maxDy);
      var minOffset = Offset(dx, minDy);

      if(i == 0){
        maxPath.moveTo(dx, maxDy);
        minPath.moveTo(dx, minDy);
      }else {
        maxPath.lineTo(dx, maxDy);
        minPath.lineTo(dx, minDy);
      }
      maxPoints.add(maxOffset);
      minPoints.add(minOffset);

      // 绘制温度
      drawText(canvas, i, daily.tempDay + "°", maxDy - 20.0, fontSize: 10);
      drawText(canvas, i, daily.tempNight + "°", minDy + 10.0, fontSize: 10);

      var date;
      if(i == 0){
        date = "今天";
      }else if(i == 1){
        date = "明天";
      }else{
        date = TimeUtil.getWeatherDate(daily.predictDate);
      }
      //绘制日期
      drawText(canvas, i, date ,10, fontSize: 14);
      //绘制白天天气
      canvas.drawImageRect(dayIcons[i], Rect.fromLTWH(0, 0, dayIcons[i].width.toDouble(), dayIcons[i].height.toDouble()),
          Rect.fromLTWH(itemWidth/4 + itemWidth*i, 40, itemWidth/2+5, itemWidth/2+5),linePaint);
      drawText(canvas, i, daily.conditionDay, 85, fontSize: 13);
      //绘制夜间天气
      canvas.drawImageRect(nightIcons[i],Rect.fromLTWH(0, 0, nightIcons[i].width.toDouble(), nightIcons[i].height.toDouble()),
          Rect.fromLTWH(itemWidth/4 + itemWidth*i, textHeight + temHeight + 30, itemWidth/2+5, itemWidth/2+5),new Paint());
      drawText(canvas, i, daily.conditionNight, textHeight+temHeight + 75, fontSize: 13);
      // 绘制风向风力
      drawText(canvas, i, daily.windDirNight + "\n" + daily.windLevelNight, textHeight+temHeight + 105,fontSize: 12);
    }
    canvas.drawPath(maxPath, maxPaint);
    canvas.drawPath(minPath, minPaint);
    canvas.drawPoints(ui.PointMode.points, maxPoints, pointPaint);
    canvas.drawPoints(ui.PointMode.points, minPoints, pointPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

  // 设置最高气温，最低气温
  void setMinMax(){
    minTem = maxTem = int.parse(dailys[0].tempDay);
    for(Forecast daily in dailys){
      if(int.parse(daily.tempDay) > maxTem){
        maxTem = int.parse(daily.tempDay);
      }
      if(int.parse(daily.tempNight) < minTem){
        minTem = int.parse(daily.tempNight);
      }
    }
  }

  //绘制文字
  drawText(Canvas canvas, int i,String text,double height,{double fontSize}) {
    var pb = ui.ParagraphBuilder(ui.ParagraphStyle(
      textAlign: TextAlign.center,//居中
      fontSize: fontSize == null ?14:fontSize,//大小
    ));
    //文字颜色
    pb.pushStyle(ui.TextStyle(color: Colors.black));
    //添加文字
    pb.addText(text);
    //文本宽度
    var paragraph = pb.build()..layout(ui.ParagraphConstraints(width: itemWidth));
    //绘制文字
    canvas.drawParagraph(paragraph, Offset(itemWidth*i, height));
  }
}