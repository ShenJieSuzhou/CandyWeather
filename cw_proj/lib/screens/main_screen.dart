import 'package:flutter/material.dart';
import 'package:cw_proj/widgets/weather_card.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.menu),
          tooltip: 'Navigation',
          onPressed: (){

          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: (){

            },
          )
        ],
      ),

      body: PageView.custom(
        childrenDelegate: SliverChildBuilderDelegate(
          (context, index){
            return Center(
              child: WeatherInfo(
                
              ),
            );
          },
          childCount: 10,
        ),
      ),
    );
  }
}