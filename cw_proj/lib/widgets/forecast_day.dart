import 'package:flutter/material.dart';
import 'package:bezier_chart/bezier_chart.dart';
import 'package:cw_proj/Model/weatherDaily.dart';
import 'dart:ui' as ui;

class ForcastDay extends StatefulWidget {
  List<WeatherDaily> dailys;
  List<ui.Image> dayIcons;
  List<ui.Image> nightIcons;

  @override
  _ForcastDayState createState() => _ForcastDayState();
}

class _ForcastDayState extends State<ForcastDay> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        child: BezierChart(
          bezierChartScale: BezierChartScale.CUSTOM,
          xAxisCustomValues: const [0, 5, 10, 15, 20, 25, 30, 35],
          series: const [
            BezierLine(
              data: const [
                DataPoint<double>(value: 10, xAxis: 0),
                DataPoint<double>(value: 130, xAxis: 5),
                DataPoint<double>(value: 50, xAxis: 10),
                DataPoint<double>(value: 150, xAxis: 15),
                DataPoint<double>(value: 75, xAxis: 20),
                DataPoint<double>(value: 0, xAxis: 25),
                DataPoint<double>(value: 5, xAxis: 30),
                DataPoint<double>(value: 45, xAxis: 35),
              ],
            ),
          ],
          config: BezierChartConfig(
            verticalIndicatorStrokeWidth: 3.0,
            verticalIndicatorColor: Colors.black26,
            showVerticalIndicator: true,
            backgroundColor: Colors.red,
            snap: false,
          ),
        ),
      ),
    );
  }
}

class _futureWeatherPainter extends CustomPainter {
  _futureWeatherPainter(this.dailys, this.dayIcons, this.nightIcons);
  List<WeatherDaily> dailys;
  List<ui.Image> dayIcons;
  List<ui.Image> nightIcons;

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    setMinMax();
    

  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return null;
  }

  // 设置最高气温，最低气温
  void setMinMax(){

  }
}