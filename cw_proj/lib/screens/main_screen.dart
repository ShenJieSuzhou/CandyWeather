import 'package:flutter/material.dart';
import 'package:cw_proj/widgets/weather_card.dart';
import 'package:cw_proj/widgets/JCustomIndicator.dart';
import 'package:cw_proj/Model/SelLocations.dart';
import 'package:cw_proj/util/configFile.dart';
import 'package:cw_proj/screens/city_screen.dart';
import 'package:cw_proj/screens/setting_screen.dart';
import 'package:cw_proj/widgets/HeaderContentView.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  PageController _pageController = PageController(initialPage: 0);
  int _pageCount;
  int _initialPage;
  Future<SelLocations> citys;


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final screenHeight = size.height;
    final headerHeight = 120.0;
    final bottomHeight = 150.0;
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    
    AppBar appBar = AppBar(
        elevation: 0.0,   
        leading: Builder(
          builder: (BuildContext context){
            return IconButton(
              icon: Icon(Icons.menu),
              tooltip: 'Navigation',
              onPressed: (){                
                // Navigator.push(context, MaterialPageRoute(builder: (context) => CityScreen()));
                Navigator.push(context, PageRouteBuilder(
                  opaque: false,
                  pageBuilder: (BuildContext context, _, __) {
                    return CityScreen();
                  },
                  
                  transitionsBuilder: (_, Animation<double> animation, Animation<double> animation1, Widget child){
                    return SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(-1.0, 0.0),
                        end: const Offset(0.0, 0.0),
                      ).animate(animation),
                      child: child,
                    );
                  }
                ));
              },
            );
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: (){
              // Navigator.push(context, MaterialPageRoute(builder: (context) => SettingScreen()));
              Navigator.push(context, PageRouteBuilder(
                opaque: false,
                pageBuilder:(BuildContext context, _, __){
                  return SettingScreen();
                },

                transitionsBuilder: (BuildContext context, Animation<double> animation, __, Widget child){
                  return SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(1.0, 0.0),
                        end: const Offset(0.0, 0.0),
                      ).animate(animation),
                      child: child,
                    );
                }
              ));
            },
          )
        ],
      );

    double appBarHeight = appBar.preferredSize.height;

    return Scaffold(
      appBar: appBar,
      body: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              
            ),
            width: double.infinity,
            height: headerHeight,
            child: HeaderContentView()
          ),
          Container(
            decoration: BoxDecoration(
              
            ),
            height: screenHeight - headerHeight - appBarHeight - bottomHeight - statusBarHeight,
            child: PageView.builder(
              onPageChanged: onPageChanged,
              controller: _pageController,
              itemBuilder: (context, index){
                return Container(
                  child: WeatherInfo(),
                );
              },
              itemCount: _pageCount,
            ),
          ),
        ],
      ),
      // drawer: SideMenuBar(),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Theme.of(context).primaryColor,
          primaryColor: Theme.of(context).accentColor,
        ),
        child: Container(
          height: bottomHeight,
          child: JCustomIndicator(controller: _pageController,itemCount: 5,),
        )
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    // 加载配置文件
    citys = fetchCity();
    

    // 请求网络数据
    
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