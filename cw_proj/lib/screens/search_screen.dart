import 'package:cw_proj/Model/home_entity.dart';
import 'package:cw_proj/Model/my_select_city.dart';
import 'package:cw_proj/util/cityidlist.dart';
import 'package:cw_proj/util/network_util.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:cw_proj/Model/data_key_bean.dart';
import 'package:cw_proj/provider/theme_provider.dart';
import 'package:cw_proj/util/theme_utils.dart';
import 'package:cw_proj/bus/custom_event_bus.dart';
import 'package:cw_proj/common/global.dart';
import 'package:provider/provider.dart';
import 'package:cw_proj/Model/aqi.dart';
import 'package:cw_proj/widgets/loadingDialog.dart';

List<HotCitys> nodes = [];

class searchBarDelegate extends SearchDelegate<String>{
  @override
  String get searchFieldLabel => "搜索全球热门城市";

  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(icon: Icon(Icons.clear), onPressed: (){
        query = "";
        showSuggestions(context);
      },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(icon: AnimatedIcon(icon: AnimatedIcons.menu_arrow, progress: transitionAnimation), onPressed: (){
      close(context, null);
    });
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return buildSearchFutureBuilder(query);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    if(nodes.length == 0){
      return buildDefaultFutureBuilder();
    } else {
      return SearchDefaultView(
        nodes: nodes,
        callback: (key) {
          query = key;
          showResults(context);
        }
      );
    }
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    bool isDark = ThemeUtils.isDark(context);
    ThemeProvider provider = ThemeProvider();
    return provider.getTheme(isDarkMode: isDark);
  }

  FutureBuilder<KeyBean> buildDefaultFutureBuilder() {
    return FutureBuilder<KeyBean>(
      builder: (context, AsyncSnapshot<KeyBean> async){
        if (async.connectionState == ConnectionState.active || 
        async.connectionState == ConnectionState.waiting) {
          return Center(
            child: Text("Waiting..."),
          );
        }

        if (async.connectionState == ConnectionState.done) {
          if (async.hasError) {
            return Center(
              child: Text("error:code"),
            );
          } else if (async.hasData) {
            KeyBean bean = async.data;
            nodes = bean.hotCitys;
            return SearchDefaultView(
              nodes: nodes,
              callback: (key) {
                query = key;
                showResults(context);
              }
            );
          }
        }
        return Container(

        );
      },
      future: getHotCity(),
      );
  }

  // 热门城市
  Future<KeyBean> getHotCity() async {
    final result =  await rootBundle.loadString('assets/Config/HotCitys.json');
    return KeyBean.fromJson(json.decode(result));
  }

  FutureBuilder buildSearchFutureBuilder(String key){
    return FutureBuilder(
      builder: (context, AsyncSnapshot async){
        if (async.connectionState == ConnectionState.active ||
        async.connectionState == ConnectionState.waiting ) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        if (async.connectionState == ConnectionState.done) {
          if (async.hasError) {
            return Center(
              child: Text('Error:code'),
            );
          } else if (async.hasData){
            List<Record> records = async.data;
            return ListView.separated(
              itemBuilder: (BuildContext context, int index){
              String name = records[index].name;
              return ListTile(title: Text("$name"), onTap: (){
                String cityID = records[index].fid;
                String cityName = records[index].name;
                if (isCityExisted(cityName)) {
                  close(context, null);
                } else {
                  // 请求城市天气数据
                  // show loading
                  LoadingDialog.showLoadingDialog(context);
                  Future.wait([
                    fetchCondition(cityID),
                    fetchAQI(cityID),
                    fetchHours(cityID),
                    fetchDailys(cityID),
                    fetchLiveIndex(cityID)
                  ]).then((results) {
                    AQI aqi = results[1];
                    HomeEntity entity = HomeEntity(cityName: aqi.cityName, condition: results[0], aqi: results[1], hour: results[2], daily: results[3], live: results[4]);
                    Provider.of<SelectedCityModel>(context, listen: false).addCity(entity);
                    // 持久化地名
                    Global.locations.record.add(records[index]);
                    Global.saveLocations();
                    // close loading
                    Navigator.of(context).pop();
                    close(context, null);
                  });
                }
              },);
            }, 
            separatorBuilder: (BuildContext context, int index) {
              return Divider(color: Colors.blue,);
            }, 
            itemCount: records.length,
            );
          }
        }
        return Container(

        );
      },
      future: getSearchData(key),
    );
  }

  Future<List<Record>> getSearchData(String key) async {
    return CityListUtil.getSearchResults(key);
  }

  // 判断城市是否已经添加过
  bool isCityExisted(String cityName){
    List<HomeEntity> cityWeatherInfos = Global.homeEntityList;
    for (var city in  cityWeatherInfos) {
      if (city.cityName == cityName) {
        return true;
      }
    }
    return false;
  }
}

class SearchDefaultView extends StatelessWidget {
  final List<HotCitys> nodes;
  final callback;

  SearchDefaultView({this.nodes, this.callback});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: <Widget>[
        SearchDefaultItemView(
          nodes: nodes,
          callback: callback,
        ),
      ],
    );
  }
}

class SearchDefaultItemView extends StatelessWidget {
  final List<HotCitys> nodes;
  final callback;

  SearchDefaultItemView({this.nodes, this.callback});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              '热门城市',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: 10.0,
            ),
            alignment: Alignment.centerLeft,
            child: Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: nodes.map((childNode) {
                return GestureDetector(
                  child: new ClipRRect(
                    child: Container(
                      padding: EdgeInsets.all(12.0),
                      child: Text(
                        childNode.name,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      color: Colors.blue,
                    ),
                    borderRadius: new BorderRadius.circular(3.0),
                  ),
                  onTap: () {
                    callback(childNode.name);
                  },
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}