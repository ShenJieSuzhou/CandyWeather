import 'package:cw_proj/Model/setting_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cw_proj/screens/main_screen.dart';
import 'package:cw_proj/common/global.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Card(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              // ListTile(     
              //   leading: Icon(Icons.location_on),
              //   title: Container(
              //     padding: EdgeInsets.only(left: 0),
              //     child: Text("打开自动定位", style: TextStyle(fontSize: 16),),
              //   ),
              //   trailing: Switch(value: false, onChanged: (bool v){
              //     if (v){
              //       // 打开自动定位
              //       Provider.of<PositionModel>(context).openPosition();
              //       // 数据持久化
              //       Global.savePositionConfig("1");
              //     } else {
              //       // 关闭定位
              //       Provider.of<PositionModel>(context).closePosition();
              //       // 数据持久化
              //       Global.savePositionConfig("0");
              //     } 
              //   }),
              // ),
              ListTile(     
                leading: Icon(Icons.notifications_active),
                title: Container(
                  padding: EdgeInsets.only(left: 0),
                  child: Text("打开消息推送", style: TextStyle(fontSize: 16),),
                ),
                trailing: Switch(value: false, onChanged: (bool v){
                  if (v){
                    // 打开消息推送
                    Provider.of<NotificationModel>(context).openNotification();
                    Global.saveNotiConfig("1");
                  } else {
                    // 关闭消息推送
                    Provider.of<NotificationModel>(context).closeNotification();
                    Global.saveNotiConfig("0");
                  } 
                }),
              ),
            ],
          ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          elevation: 10.0,
          margin: EdgeInsets.all(10.0),
        )
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
         Navigator.push(context, PageRouteBuilder(
                opaque: false,
                pageBuilder:(BuildContext context, _, __){
                  Global.saveEnterConfig();
                  return MainScreen();
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
      }),
    );
  }
}