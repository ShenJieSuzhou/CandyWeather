import 'package:cw_proj/Model/condition.dart';
import 'package:cw_proj/Model/data_key_bean.dart';
import 'package:cw_proj/screens/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:cw_proj/widgets/CityBriefCard.dart';
import 'package:cw_proj/bus/custom_event_bus.dart';
import 'package:cw_proj/util/network_util.dart';

class CityScreen extends StatefulWidget {
  final List<Record> selectedCitys;
  const CityScreen({Key key, this.selectedCitys}) : super(key: key);

  @override
  _CityScreenState createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  Condition _condition;
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  // // 获取城市天气数据
  // Future fetchCityWeatherData(Record record) async {
  //   return Future.wait([
  //     fetchCondition(record.fid)]
  //   ).then((results){
  //       _condition = results[0];
  //   });
  // }


  @override
  Widget build(BuildContext context) {
    bus.on("addCity", (arg) {
      print(arg);
    });

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
          child: ListView.separated(
            itemBuilder: (context, index) {
              Record record = widget.selectedCitys[index];
              // fetchCondition(record.fid).then((result){

              // }).whenComplete((){

              // }).catchError((){

              // });
              // fetchCityWeatherData(widget.selectedCitys[index])
              return FutureBuilder(
                future: fetchCondition(record.fid),
                builder: (BuildContext context, AsyncSnapshot snapShot){
                  if(snapShot.connectionState == ConnectionState.waiting){
                    return Text('Loading');
                  }else if(snapShot.connectionState == ConnectionState.active){

                  }else if(snapShot.connectionState == ConnectionState.done){
                    if(snapShot.hasError){
                      return Text('Error: ${snapShot.error}');
                    }
                    _condition = snapShot.data;
                    return CityBriefCard(cityName: widget.selectedCitys[index].name, temperature: _condition.temp, weather: _condition.condition);
                  }
                  return Container(
                    
                  );
                }
              );
            },
            separatorBuilder: (context, index) {
              return Divider(
                height: 20.0,
              );
            }, 
            itemCount: widget.selectedCitys.length
            ), 
      )
    );
  }
}