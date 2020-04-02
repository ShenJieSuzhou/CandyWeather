import 'package:cw_proj/Model/data_key_bean.dart';
import 'package:cw_proj/screens/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:cw_proj/widgets/CityBriefCard.dart';
import 'package:cw_proj/bus/custom_event_bus.dart';

class CityScreen extends StatefulWidget {
  final List<Record> selectedCitys;
  const CityScreen({Key key, this.selectedCitys}) : super(key: key);

  @override
  _CityScreenState createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  var _futureCWBuilder;
  
  @override
  void initState() {
    // TODO: implement initState
    _futureCWBuilder = fetchCityWeatherData(widget.selectedCitys);
    super.initState();
  }

  // 获取城市天气数据
  Future fetchCityWeatherData(List<Record> records) async {
    List<Function> requestParam = [];
    for (var record in records) {
      
    }

    return Future.wait([

    ]).then((results){
        
    });
  }


  @override
  Widget build(BuildContext context) {
    bus.on("addCity", (arg) {
      print(arg);
    });

    return FutureBuilder(
      future: _futureCWBuilder,
      builder: (BuildContext context, AsyncSnapshot snapShot){
            if(snapShot.connectionState == ConnectionState.waiting){
              return Text('Loading');
            }else if(snapShot.connectionState == ConnectionState.active){

            }else if(snapShot.connectionState == ConnectionState.done){
              return Scaffold(
                appBar: AppBar(
                  elevation: 0.0,
                  leading: IconButton(
                    icon: Icon(Icons.add),
                    onPressed: (){
                      showSearch(context: context, delegate: searchBarDelegate());
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
      });
  }
}