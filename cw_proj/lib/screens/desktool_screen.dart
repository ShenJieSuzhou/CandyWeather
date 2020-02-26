import 'package:flutter/material.dart';

class DeskToolScreen extends StatefulWidget {
  @override
  _DeskToolScreenState createState() => _DeskToolScreenState();
}

class _DeskToolScreenState extends State<DeskToolScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        title: Text("桌面小工具"),
      ),
    );
  }
}