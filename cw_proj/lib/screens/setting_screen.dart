import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:cw_proj/screens/dynamicbg_screen.dart';
import 'package:cw_proj/screens/desktool_screen.dart';
import 'package:cw_proj/screens/language_screen.dart';
import 'package:cw_proj/screens/units_screen.dart';
import 'package:cw_proj/screens/contactus_screen.dart';
import 'package:cw_proj/screens/push_screen.dart';


enum SettingItem{
  SETTING_WIDGET,
  SETTING_BACKGROUND,
  SETTING_PUSH,
  SETTING_LANGUAGE,
  SETTING_UNITS,
  SETTING_CONTACTUS,
  SETTING_COMMENTS,
  SETTING_RECOMMEND
}


class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {

  List _elements = [
    {'name': ['自定义桌面Widget小工具'], 'group': '桌面小工具', 'icon':'tool'},
    {'name':['通知','推送','语言','单位'], 'group': '通用设置', 'icon':'general'},
    {'name': ['联系我们','评价','推荐'], 'group': '关于', 'icon':'aboutus'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.keyboard_backspace),
          onPressed: (){
            print("返回");
            Navigator.of(context).pop();
          },
        ),
        title: Text("设置"),
      ),
      body: settingListGroupView(),
    );
  }


  Widget settingListGroupView(){
    return GroupedListView<dynamic, String>(
      groupBy: (element) => element['group'],
      elements: _elements,
      sort: false,
      groupSeparatorBuilder: (String value) {
        if(value == "桌面小工具"){
          return Padding(
            padding: EdgeInsets.fromLTRB(20.0, 20.0, 0.0, 5.0),
            child: Row(
              children: <Widget>[
                Icon(Icons.picture_in_picture),
                SizedBox(width: 10.0,),
                Text(
                  value,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                )
              ],
            )
          );
        }else if(value == "通用设置"){
          return Padding(
            padding: EdgeInsets.fromLTRB(20.0, 20.0, 0.0, 5.0),
            child: Row(
              children: <Widget>[
                Icon(Icons.language),
                SizedBox(width: 10.0,),
                Text(
                  value,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                )
              ],
            )
          );
        }else if(value == "关于"){
          return Padding(
            padding: EdgeInsets.fromLTRB(20.0, 20.0, 0.0, 5.0),
              child: Row(
                children: <Widget>[
                  Icon(Icons.info),
                  SizedBox(width: 10.0,),
                  Text(
                    value,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  )
                ],
              )
          );
        }else {
          return SizedBox();
        }
      }, 
      itemBuilder: (c, element){
        if (element['group'] == "桌面小工具") {
          return Card(
            elevation: 8.0,
                margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                child: Column(
                  children: <Widget>[
                    ListTile(
                      title: Text('自定义桌面Widget小工具'),
                      trailing: Icon(Icons.arrow_forward_ios),
                      onTap: (){
                        onTapEvent(SettingItem.SETTING_WIDGET);
                      },
                    ),
                  ],
                ),
          );
        } else if(element['group'] == "通用设置"){
          return Card(
            elevation: 8.0,
                margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                child: Column(
                  children: <Widget>[
                    ListTile(
                      title: Text('天气背景'),
                      trailing: Icon(Icons.arrow_forward_ios),
                      onTap: (){
                        onTapEvent(SettingItem.SETTING_BACKGROUND);
                      },
                    ),
                    Divider(height: 1.0,),
                    ListTile(
                      title: Text('通知'),
                      trailing: Icon(Icons.arrow_forward_ios),
                      onTap: (){
                        onTapEvent(SettingItem.SETTING_PUSH);
                      },
                    ),
                    Divider(height: 1.0,),
                    ListTile(
                      title: Text('语言'),
                      trailing: Icon(Icons.arrow_forward_ios),
                      onTap: (){
                        onTapEvent(SettingItem.SETTING_LANGUAGE);
                      },
                    ),
                    Divider(height: 1.0,),
                    ListTile(
                      title: Text('单位'),
                      trailing: Icon(Icons.arrow_forward_ios),
                      onTap: (){
                        onTapEvent(SettingItem.SETTING_UNITS);
                      },
                    ),
                  ],
                ),
          );
        } else if(element['group'] == "关于") {
          return Card(
            elevation: 8.0,
                margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                child: Column(
                  children: <Widget>[
                    ListTile(
                      title: Text('联系我们'),
                      trailing: Icon(Icons.arrow_forward_ios),
                      onTap: (){
                        onTapEvent(SettingItem.SETTING_CONTACTUS);
                      },
                    ),
                    Divider(height: 1.0,),
                    ListTile(
                      title: Text('评价'),
                      trailing: Icon(Icons.arrow_forward_ios),
                      onTap: (){
                        onTapEvent(SettingItem.SETTING_COMMENTS);
                      },
                    ),
                    Divider(height: 1.0,),
                    ListTile(
                      title: Text('推荐'),
                      trailing: Icon(Icons.arrow_forward_ios),
                      onTap: (){
                        onTapEvent(SettingItem.SETTING_RECOMMEND);
                      },
                    ),
                  ],
                ),
          );
        } else {
          return SizedBox(height: 0.0,);
        }
      },
    );
  }

  void onTapEvent(SettingItem item){
    switch (item) {
      case SettingItem.SETTING_WIDGET:
        pushTo(DeskToolScreen());
      break;
      case SettingItem.SETTING_BACKGROUND:
        pushTo(DynamicBackground());
      break;
      case SettingItem.SETTING_PUSH:
        pushTo(PushScreen());
      break;
      case SettingItem.SETTING_LANGUAGE:
        pushTo(LanguageScreen());
      break;
      case SettingItem.SETTING_UNITS:
        pushTo(UnitScreen());
      break;
      case SettingItem.SETTING_CONTACTUS:
        pushTo(ContactUsScreen());
      break;
      case SettingItem.SETTING_COMMENTS:
      break;
      case SettingItem.SETTING_RECOMMEND:
      break;
      default:
    }
  }

  void pushTo(Widget widget){
    Navigator.push(context, PageRouteBuilder(
        opaque: false,
        pageBuilder: (BuildContext context, _, __) {
          return widget;
        },
        
        transitionsBuilder: (_, Animation<double> animation, Animation<double> animation1, Widget child){
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1.0, 0.0),
              end: const Offset(0.0, 0.0),
            ).animate(animation),
            child: child,
          );
        }
    ));
  }
  // Widget listDetail(List<String> settings){
  //   print(settings);
  //   return ListView.separated(
  //         physics: NeverScrollableScrollPhysics(),
  //         padding: const EdgeInsets.all(8),
  //         itemCount: settings.length,
  //         itemBuilder: (BuildContext context, int index) {
  //         return Container(
  //           child: Center(child: Text('Entry ${settings[index]}')),
  //         );
  //       },
  //     separatorBuilder: (BuildContext context, int index) => const Divider(),
  //   );
  // }

  // Widget icon
  // Widget settingListView(){
  //   return ListView.separated(
  //     physics: NeverScrollableScrollPhysics(),
  //     itemCount: 9,
  //     separatorBuilder: (context, index){
  //       if(index == 0){
  //         return Container(
  //           height: 40.0,
  //           child: Text("通用",),
  //           color: Colors.blue,
  //         );
  //       }else if(index == 4){
  //         return Container(
  //           height: 40.0,
  //           child: Text("关于",),
  //           color: Colors.blue,
  //         );
  //       }else {
  //         return Container();
  //       }
  //     },
  //     itemBuilder: (context, index){
  //       return InkWell(
  //         child: Container(
  //           height: 40.0,
  //           child: ListTile(
  //             leading: Icon(Icons.favorite),
  //             title: Text("动态背景"),
  //             onTap: (){
  //               print("[ListTile view tap]");
  //             },
  //           ),
  //         ),
  //         onTap: (){
  //           print("[setting view tap]");
  //         },
  //       );
  //     },
  //   );
  // }

}