import 'package:flutter/material.dart';
import 'package:cw_proj/Model/Daily.dart';
import 'dart:ui' as ui;
import 'package:cw_proj/util/time_util.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'dart:typed_data';
import 'package:cw_proj/Model/weather_bean.dart';

class ForcastDay extends StatefulWidget {
  const ForcastDay({Key key, this.weatherResult}) : super(key: key);
  final WeatherResult weatherResult;

  @override
  _ForcastDayState createState() => _ForcastDayState();
}

class _ForcastDayState extends State<ForcastDay> {
  List<Daily> dailys = [];
  List<ui.Image> dayIcons = [];
  List<ui.Image> nightIcons = [];
  bool imageLoaded = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    for(int i = 0; i< 7; i++){
      Daily daily = Daily();
      daily.conditionDay = "少云";
      daily.conditionNight = "少云";
      daily.conditionIdDay = "1";
      daily.conditionIdNight = "2";
      daily.tempDay = "22";
      daily.tempNight = "10";
      daily.windDirDay = "东北风";
      daily.windDirNight = "东北风";
      daily.windLevelDay = "4";
      daily.windLevelNight = "4";
      daily.week = "星期二";
      daily.date = "2020-03-10"; 
      dailys.add(daily);
    }

    initDayImage("assets/weatherIcons/W0.png");
    initNightImage("assets/weatherIcons/W0.png");
  }

  @override
  Widget build(BuildContext context) {
    double screenW = MediaQuery.of(context).size.width;
    double itemWidth = (screenW - 60) / 7;
    if(imageLoaded){
      return CustomPaint(
        painter: _futureWeatherPainter(dailys, dayIcons, nightIcons, itemWidth),
        size: Size(screenW - 60, 350),
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
      initDayImage("assets/weatherIcons/W0.png");
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
      initNightImage("assets/weatherIcons/W0.png");
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
}

class _futureWeatherPainter extends CustomPainter {
  _futureWeatherPainter(this.dailys, this.dayIcons, this.nightIcons, this.itemWidth, );
  final List<Daily> dailys;
  final List<ui.Image> dayIcons;
  final List<ui.Image> nightIcons;
  final double itemWidth;
  final double textHeight = 140;
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

      var date;
      if(i == 0){
        date = daily.week + "\n" + "今天";
      }else if(i == 1){
        date = daily.week + "\n" + "明天";
      }else{
        date = daily.week + "\n" + TimeUtil.getWeatherDate(daily.date);
      }
      //绘制日期
      drawText(canvas, i, date ,15, fontSize: 12);
      //绘制白天天气
      canvas.drawImageRect(dayIcons[i],Rect.fromLTWH(0, 0, dayIcons[i].width.toDouble(), dayIcons[i].height.toDouble()),
          Rect.fromLTWH(itemWidth/4 + itemWidth*i, 55, itemWidth/2, itemWidth/2),linePaint);
      drawText(canvas, i, daily.conditionDay, 90, fontSize: 12);
      //绘制夜间天气
      canvas.drawImageRect(nightIcons[i],Rect.fromLTWH(0, 0, nightIcons[i].width.toDouble(),  nightIcons[i].height.toDouble()),
          Rect.fromLTWH(itemWidth/4 + itemWidth*i, textHeight + temHeight + 25, itemWidth/2, itemWidth/2),new Paint());
      drawText(canvas, i, daily.conditionNight, textHeight+temHeight + 60, fontSize: 12);
      // 绘制风向风力
      drawText(canvas, i, daily.windDirNight + "\n" + daily.windLevelNight, textHeight+temHeight + 85,fontSize: 10);
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
    for(Daily daily in dailys){
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