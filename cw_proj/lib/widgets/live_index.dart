import 'package:flutter/material.dart';
import 'package:cw_proj/Model/live.dart';
import 'package:cw_proj/util/theme_utils.dart';

class LiveIndex extends StatefulWidget {
  Live live;
  @override
  _LiveIndexState createState() => _LiveIndexState();
}

class _LiveIndexState extends State<LiveIndex> {
  @override
  Widget build(BuildContext context) {
    double screenW = MediaQuery.of(context).size.width;
    double screenH = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: Container(
        child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: 5,
          itemBuilder: (context, index){
            return Padding(
              padding: EdgeInsets.fromLTRB(0, 0.0, 0, 0.0),
              child: indexBoard('化妆指数', '3', '保湿', '天气寒冷，多补水，选用滋润保湿型化妆品，使用润唇膏。'),
            );
          },
        ),
      ),
    );
  }

  Widget indexBoard(String name, String level, String status, String desc){
    bool isDark = ThemeUtils.isDark(context);
    return Card(
      color: isDark?Color(0xFF1c1c1e) : Color(0xFFf5f5f5),
      child: ListTile(
        leading: Icon(Icons.code),
        title: Text('$name level:$level'),
        subtitle: Text('$desc'),
        trailing: Text('$status'),
      ),
    );

    // return Container(
    //   decoration: BoxDecoration(
    //     shape: BoxShape.rectangle,
    //     borderRadius: BorderRadius.all(Radius.circular(8)),
    //     color: isDark?Color(0xFF1c1c1e) : Color(0xFFf5f5f5),
    //   ),
    //   child: ListTile(
    //     leading: Icon(Icons.code),
    //     title: Text('$name level:$level'),
    //     subtitle: Text('$desc'),
    //     trailing: Text('$status'),
    //   ),
    // );
  }
}