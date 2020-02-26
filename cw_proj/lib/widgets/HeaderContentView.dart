import 'package:flutter/material.dart';
import 'package:cw_proj/util/HeaderContentStyle.dart';

class HeaderContentView extends StatefulWidget {
  @override
  _HeaderContentViewState createState() => _HeaderContentViewState();
}

class _HeaderContentViewState extends State<HeaderContentView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 50.0,
            padding: EdgeInsets.fromLTRB(30, 5, 0, 0),
            child: Text("2月17日 星期一", 
            style: HeaderContentStyle.dateStyle,
            textAlign: TextAlign.start,),
          ),
          Container(
            height: 70.0,
            padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
            child: Text("Today",
            style: HeaderContentStyle.today,
            textAlign: TextAlign.start,),
          ),
        ],
      ),
    );
  }
}