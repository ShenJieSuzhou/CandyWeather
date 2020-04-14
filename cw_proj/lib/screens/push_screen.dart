import 'package:cw_proj/Model/setting_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PushScreen extends StatefulWidget {
  @override
  _PushScreenState createState() => _PushScreenState();
}

class _PushScreenState extends State<PushScreen> {
  @override
  Widget build(BuildContext context) {
    bool isOpen = Provider.of<NotificationModel>(context).isOpen;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        title: Text("通知"),
      ),
      body: Card(
        color: Colors.white,
        child: ListTile(     
            leading: Icon(Icons.notifications_active),
            title: Container(
              padding: EdgeInsets.only(left: 0),
              child: Text("推送设置", style: TextStyle(fontSize: 16),),
            ),
            trailing: Switch(value: isOpen, onChanged: (bool v){
              if (v){
                Provider.of<NotificationModel>(context).openNotification();
              } else {
                Provider.of<NotificationModel>(context).closeNotification();
              } 
            }),
          ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          elevation: 10.0,
          margin: EdgeInsets.all(10.0),
      ),
    );
  }
}