import 'package:flutter/material.dart';
import 'package:cw_proj/widgets/weather_card.dart';
import 'package:cw_proj/widgets/JCustomIndicator.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  PageController _pageController = PageController(initialPage: 0);
  int _pageCount;
  int _initialPage;

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

      body: PageView.builder(
        onPageChanged: onPageChanged,
        controller: _pageController,
        itemBuilder: (context, index){
          return Center(
            child: WeatherInfo(),
          );
        },
        itemCount: _pageCount,
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Theme.of(context).primaryColor,
          primaryColor: Theme.of(context).accentColor,
        ),
        child: Container(
          height: 100,
          child: JCustomIndicator(controller: _pageController,itemCount: 5,),
        )
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose(){
    super.dispose();
    _pageController.dispose();
  }


  void onPageChanged(int index){
    setState(() {});
  }

  void setPageCount(int count){
    this._pageCount = count;
  }

  void setInitialPage(int initPage){
    this._initialPage = initPage;
  }
}