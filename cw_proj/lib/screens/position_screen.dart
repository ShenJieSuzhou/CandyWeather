import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cw_proj/Model/setting_model.dart';

class PositionScreen extends StatefulWidget {
  @override
  _PositionScreenState createState() => _PositionScreenState();
}

class _PositionScreenState extends State<PositionScreen> {
  @override
  Widget build(BuildContext context) {
    bool isOpen = Provider.of<PositionModel>(context).isOpen;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        title: Text("定位"),
      ),
      body: Card(
        color: Colors.white,
        child: ListTile(     
            leading: Icon(Icons.location_on),
            title: Container(
              padding: EdgeInsets.only(left: 0),
              child: Text("自动定位", style: TextStyle(fontSize: 16),),
            ),
            trailing: Switch(value: isOpen, onChanged: (bool v){
              if (v){
                Provider.of<PositionModel>(context).openPosition();
              } else {
                Provider.of<PositionModel>(context).closePosition();
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