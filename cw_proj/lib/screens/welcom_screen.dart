import 'package:cw_proj/Model/setting_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
              ListTile(     
                leading: Icon(Icons.location_on),
                title: Container(
                  padding: EdgeInsets.only(left: 0),
                  child: Text("打开自动定位", style: TextStyle(fontSize: 16),),
                ),
                trailing: Switch(value: false, onChanged: (bool v){
                  if (v){
                    Provider.of<PositionModel>(context).openPosition();
                  } else {
                    Provider.of<PositionModel>(context).closePosition();
                  } 
                }),
              ),
              ListTile(     
                leading: Icon(Icons.notifications_active),
                title: Container(
                  padding: EdgeInsets.only(left: 0),
                  child: Text("打开消息推送", style: TextStyle(fontSize: 16),),
                ),
                trailing: Switch(value: false, onChanged: (bool v){
                  if (v){
                    Provider.of<NotificationModel>(context).openNotification();
                  } else {
                    Provider.of<NotificationModel>(context).closeNotification();
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
        Navigator.of(context).pop();
      } 
      ),
    );
  }
}