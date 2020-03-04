import 'package:flutter/material.dart';
import 'package:cw_proj/res/styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
            height: ScreenUtil().setHeight(80),
            padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(60), ScreenUtil().setWidth(30), 0, 5),
            child: Text("2020年2月17日 星期一", 
            style: TextStyle(
                      color: Colors.black,
                      fontSize: ScreenUtil().setSp(35),
                    ),
            textAlign: TextAlign.start,),
          ),
          Container(
            height: ScreenUtil().setHeight(100),
            padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(60), 0, 0, 5),
            child: Text("Today",
            style: TextStyle(
                      color: Colors.black,
                      fontSize: ScreenUtil().setSp(80),
                      fontWeight: FontWeight.bold
                    ),
            textAlign: TextAlign.start,),
          ),
        ],
      ),
    );
  }
}