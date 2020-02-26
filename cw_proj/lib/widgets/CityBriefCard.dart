import 'package:cw_proj/util/const.dart';
import 'package:flutter/material.dart';
import 'package:cw_proj/util/CityBriefStyle.dart';

class CityBriefCard extends StatefulWidget {
  final String cityName, temperature, weather;

  CityBriefCard({
    @required this.cityName,
    @required this.temperature,
    @required this.weather
  });

  @override
  _CityBriefCardState createState() => _CityBriefCardState();
}

class _CityBriefCardState extends State<CityBriefCard> {
  final bg = Colors.black54;
  final radius = BorderRadius.only(topLeft: Radius.circular(5.0), topRight:Radius.circular(5.0), bottomLeft: Radius.circular(5.0), bottomRight: Radius.circular(5.0));

  @override
  Widget build(BuildContext context) {
    final size =MediaQuery.of(context).size;
    final width =size.width;

    return Padding(
      padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: Container(
        height: 100.0,
        decoration: BoxDecoration(
            color: bg,
            borderRadius: radius,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 50.0,
                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: Text("${widget.cityName}",
                 textAlign: TextAlign.start,
                 style: CityBriefStyle.cityNameStyle,),
              ),
              Container(
                height: 45.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: width - 120,
                      padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("${widget.temperature}",
                          textAlign: TextAlign.start,
                          style: CityBriefStyle.temperatureStyle,),
                          SizedBox(height: 5,),
                          Text("${widget.weather}",
                          textAlign: TextAlign.start,
                          style: CityBriefStyle.weatherStyle,)
                        ],
                      ),
                    ),
                    Container(
                      width: 80,
                      child: Icon(IconData(0xe8e0,fontFamily: 'iconfont',),
                      color: Colors.white, size: 40.0,),
                    )
                  ],
                )
              )
              
            ],
        ),
      )
    );


    // return Column(
    //   crossAxisAlignment: CrossAxisAlignment.start,
    //   children: <Widget>[
    //     Container(
    //       margin: const EdgeInsets.all(3.0),
    //       padding: const EdgeInsets.all(5.0),
    //       decoration: BoxDecoration(
    //         color: bg,
    //         borderRadius: radius
    //       ),
          
    //     ),
    //   ],
    // );



    // return Row(
    //   children: <Widget>[
    //     Container(
    //       margin: const EdgeInsets.all(3.0),
    //       padding: const EdgeInsets.all(5.0),

    //       decoration: BoxDecoration(
    //         color: bg,
    //         borderRadius: radius
    //       ),
      
    //       child: Column(
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: <Widget>[
    //           Text("${widget.cityName}"),
    //           Text("${widget.temperature}"),
    //           Text("${widget.weather}")
    //         ],
    //       ),
    //     ),
    //   ],
    // );
  }
}