import 'package:cw_proj/widgets/CityBriefCard.dart';
import 'package:flutter/material.dart';

class SideMenuBar extends StatefulWidget {
  @override
  _SideMenuBarState createState() => _SideMenuBarState();
}

class _SideMenuBarState extends State<SideMenuBar> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width =size.width;
    return Drawer(
      child: ListView(
        children: <Widget>[
          ListTile(
            leading: IconButton(icon: Icon(Icons.edit), onPressed: (){

            },),
            trailing: IconButton(icon: Icon(Icons.add), onPressed: (){

            },),
          ),
          CityBriefCard(cityName: "苏州", temperature: "12度", weather: "雨",),
        ],
      ),
    );
  }
}