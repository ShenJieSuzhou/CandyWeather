import 'package:cw_proj/screens/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:cw_proj/widgets/CityBriefCard.dart';
import 'package:cw_proj/Model/home_entity.dart';
import 'package:cw_proj/Model/my_select_city.dart';
import 'package:provider/provider.dart';

class CityScreen extends StatefulWidget {
  const CityScreen({Key key}) : super(key: key);

  @override
  _CityScreenState createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<HomeEntity> weatherArray = Provider.of<SelectedCityModel>(context).locationList;

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
              HomeEntity weatherInfo = weatherArray[index];
              return  CityBriefCard(cityName: weatherInfo.cityName, temperature: weatherInfo.condition.temp, weather:  weatherInfo.condition.condition);
            },
            separatorBuilder: (context, index) {
              return Divider(
                height: 20.0,
              );
            }, 
            itemCount: weatherArray.length
            ), 
      )
    );
  }
}