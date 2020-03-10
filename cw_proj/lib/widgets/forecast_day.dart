import 'package:flutter/material.dart';
import 'package:cw_proj/Model/weatherDaily.dart';
import 'dart:ui' as ui;
import 'package:cw_proj/util/theme_utils.dart';
import 'package:cw_proj/util/time_util.dart';

class ForcastDay extends StatelessWidget {
  final List<WeatherDaily> dailys;
  final List<ui.Image> dayIcons;
  final List<ui.Image> nightIcons;

  ForcastDay({Key key, this.dailys, this.dayIcons, this.nightIcons}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenW = MediaQuery.of(context).size.width;
    return CustomPaint(
      painter: _futureWeatherPainter(dailys, dayIcons, nightIcons),
      size: Size(screenW - 40, 310),
    );
  }
}

class _futureWeatherPainter extends CustomPainter {
  _futureWeatherPainter(this.dailys, this.dayIcons, this.nightIcons);
  List<WeatherDaily> dailys;
  List<ui.Image> dayIcons;
  List<ui.Image> nightIcons;
  final double itemWidth = 60;
  final double textHeight = 120;
  final double temHeight = 80;
  int maxTem, minTem;

  @override
  void paint(Canvas canvas, Size size) {
    setMinMax();

    var maxPaint = new Paint()
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..color = Color(0xffeceea6)
      ..isAntiAlias = true
      ..strokeWidth = 2;

    var minPaint = new Paint()
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..color = Color(0xffa3f4fe)
      ..isAntiAlias = true
      ..strokeWidth = 2;

    var pointPaint = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..isAntiAlias = true
      ..strokeWidth = 8;

    var linePaint = Paint()
      ..color = Colors.white70
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
      var maxDy = textHeight + (maxTem - int.parse(daily.tempDay)) * oneTemHeight;
      var minDy = textHeight + (maxTem - int.parse(daily.tempNight)) * oneTemHeight;
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
      drawText(canvas, i, date ,10);
      //绘制白天天气
      canvas.drawImageRect(dayIcons[i],Rect.fromLTWH(0, 0, dayIcons[i].width.toDouble(), dayIcons[i].height.toDouble()),
          Rect.fromLTWH(itemWidth/4 + itemWidth*i, 50,30,30),linePaint);
      drawText(canvas, i, daily.conditionDay, 90);
      //绘制夜间天气
      canvas.drawImageRect(nightIcons[i],Rect.fromLTWH(0, 0, nightIcons[i].width.toDouble(),  nightIcons[i].height.toDouble()),
          Rect.fromLTWH(itemWidth/4 + itemWidth*i, textHeight + temHeight + 10,30,30),new Paint());
      drawText(canvas, i, daily.conditionNight, textHeight+temHeight + 45);
      // 绘制风向风力
      drawText(canvas, i, daily.windDirNight + "\n" + daily.windLevelNight, textHeight+temHeight + 70,frontSize: 10);
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

  }

  //绘制文字
  drawText(Canvas canvas, int i,String text,double height,{double frontSize}) {
    var pb = ui.ParagraphBuilder(ui.ParagraphStyle(
      textAlign: TextAlign.center,//居中
      fontSize: frontSize == null ?14:frontSize,//大小
    ));
    //添加文字
    pb.addText(text);
    //文字颜色
    pb.pushStyle(ui.TextStyle(color: Colors.white));
    //文本宽度
    var paragraph = pb.build()..layout(ui.ParagraphConstraints(width: itemWidth));
    //绘制文字
    canvas.drawParagraph(paragraph, Offset(itemWidth*i, height));
  }
}