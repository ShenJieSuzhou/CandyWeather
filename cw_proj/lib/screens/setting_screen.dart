import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:cw_proj/screens/dynamicbg_screen.dart';
import 'package:cw_proj/screens/desktool_screen.dart';
import 'package:cw_proj/screens/language_screen.dart';
import 'package:cw_proj/screens/units_screen.dart';
import 'package:cw_proj/screens/contactus_screen.dart';
import 'package:cw_proj/screens/push_screen.dart';
import 'package:cw_proj/screens/position_screen.dart';
import 'package:cw_proj/util/log_util.dart';
import 'package:cw_proj/util/theme_utils.dart';

enum SettingItem{
  SETTING_WIDGET,
  SETTING_BACKGROUND,
  SETTING_POSITION,
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

  // 创建一个给native的channel (类似iOS的通知）
  static const methodChannel = const MethodChannel('com.jj.platinum');
  String _nativeCallBackValue = '等待原生传值';

  @override
  Widget build(BuildContext context) {
    bool isDark = ThemeUtils.isDark(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.keyboard_backspace),
          onPressed: (){
            print("返回");
            Navigator.of(context).pop();
          },
        ),
        title: Text("设置", style: TextStyle(color: isDark? Colors.white : Colors.black),),
      ),
      body: settingListGroupView(isDark),
    );
  }


  Widget settingListGroupView(bool isDark){
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
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: isDark? Colors.white : Colors.black),
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
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: isDark? Colors.white : Colors.black),
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
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: isDark? Colors.white : Colors.black),
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
                      title: Text('自定义桌面Widget小工具', style: TextStyle(color: isDark? Colors.white : Colors.black),),
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
                      title: Text('天气背景', style: TextStyle(color: isDark? Colors.white : Colors.black)),
                      trailing: Icon(Icons.arrow_forward_ios),
                      onTap: (){
                        onTapEvent(SettingItem.SETTING_BACKGROUND);
                      },
                    ),
                    Divider(height: 1.0,),
                    // ListTile(
                    //   title: Text('定位'),
                    //   trailing: Icon(Icons.arrow_forward_ios),
                    //   onTap: (){
                    //     onTapEvent(SettingItem.SETTING_POSITION);
                    //   },
                    // ),
                    // Divider(height: 1.0,),
                    ListTile(
                      title: Text('通知', style: TextStyle(color: isDark? Colors.white : Colors.black)),
                      trailing: Icon(Icons.arrow_forward_ios),
                      onTap: (){
                        onTapEvent(SettingItem.SETTING_PUSH);
                      },
                    ),
                    Divider(height: 1.0,),
                    ListTile(
                      title: Text('语言', style: TextStyle(color: isDark? Colors.white : Colors.black)),
                      trailing: Icon(Icons.arrow_forward_ios),
                      onTap: (){
                        onTapEvent(SettingItem.SETTING_LANGUAGE);
                      },
                    ),
                    Divider(height: 1.0,),
                    ListTile(
                      title: Text('单位', style: TextStyle(color: isDark? Colors.white : Colors.black)),
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
                      title: Text('联系我们', style: TextStyle(color: isDark? Colors.white : Colors.black)),
                      trailing: Icon(Icons.arrow_forward_ios),
                      onTap: (){
                        onTapEvent(SettingItem.SETTING_CONTACTUS);
                      },
                    ),
                    Divider(height: 1.0,),
                    ListTile(
                      title: Text('评价', style: TextStyle(color: isDark? Colors.white : Colors.black)),
                      trailing: Icon(Icons.arrow_forward_ios),
                      onTap: (){
                        onTapEvent(SettingItem.SETTING_COMMENTS);
                      },
                    ),
                    Divider(height: 1.0,),
                    ListTile(
                      title: Text('推荐', style: TextStyle(color: isDark? Colors.white : Colors.black)),
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
      case SettingItem.SETTING_POSITION:
        // pushTo(PositionScreen());
      break;
      case SettingItem.SETTING_COMMENTS:
      break;
      case SettingItem.SETTING_RECOMMEND:
      Log.e("给原生传值");
      _communicateFunction("hello fultter");
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

  // 与原生交互
  Future<void> _communicateFunction(flutterPara) async {
    try {
      //原生方法名为callNativeMethond,flutterPara为flutter调用原生方法传入的参数，await等待方法执行
      final result = await methodChannel.invokeMethod('callNativeMethond', flutterPara);
      //如果原生方法执行回调传值给flutter，那下面的代码才会被执行
      _nativeCallBackValue = result;
    } on PlatformException catch (e) {//抛出异常
      print(e);
    }
  }
}