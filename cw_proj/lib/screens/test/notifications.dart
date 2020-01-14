import 'package:flutter/material.dart';

class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
     body: new Center(
       child: new Text("改革春风吹满地，明年还需在努力 💪 ", style: new TextStyle(color: Colors.black,
                    fontSize: 24.0,
                    fontWeight: FontWeight.w800),),
       
     ),
   );
  }
}