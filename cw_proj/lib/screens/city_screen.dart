import 'package:flutter/material.dart';
import 'package:cw_proj/widgets/CityBriefCard.dart';

class CityScreen extends StatefulWidget {
  @override
  _CityScreenState createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.edit),
          onPressed: (){
            print("编辑天气卡包");
          },
        ),
        title: Text("天气卡包"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.check),
            onPressed: (){
              print("退出");
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Container(
          child: ListView(
          children: <Widget>[
            CityBriefCard(cityName: "苏州市", temperature: "12℃", weather: "正在下雨",),
          ],
        ),
      )
    );
  }
}