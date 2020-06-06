import 'package:flutter/material.dart';
import 'package:cw_proj/Model/live.dart';
import 'package:cw_proj/util/theme_utils.dart';
import 'package:cw_proj/res/colors.dart';

class LiveIndex extends StatefulWidget {
  Live live;
  LiveIndex({Key key, this.live}) : super(key: key);

  @override
  LiveIndexState createState() => LiveIndexState();
}

class LiveIndexState extends State<LiveIndex> {
  @override
  Widget build(BuildContext context) {
    // double screenW = MediaQuery.of(context).size.width;
    // double screenH = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: Container(
        child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: widget.live.liveIndex.length,
          itemBuilder: (context, index){
            return Padding(
              padding: EdgeInsets.fromLTRB(0, 0.0, 0, 0.0),
              child: indexBoard(widget.live.liveIndex[index].code, widget.live.liveIndex[index].name, '', widget.live.liveIndex[index].status, widget.live.liveIndex[index].desc),
            );
          },
        ),
      ),
    );
  }

  Widget indexBoard(int code, String name, String level, String status, String desc){ 
    bool isDark = ThemeUtils.isDark(context);
    return Card(
      color: isDark?Color(0xFFf5f5f5) : Color(0xFF1c1c1e),
      child: ListTile(
        leading: Image(
          image: getLiveIndexIcon(code),),
        title: Text('$name level:$level',
          style: TextStyle(
              color: isDark? Colours.text : Colours.dark_text
            ),
        ),
        subtitle: Text('$desc',
          style: TextStyle(
              color: isDark? Colours.text : Colours.dark_text
            ),
        ),
        trailing: Text('$status',
          style: TextStyle(
              color: isDark? Colours.text : Colours.dark_text
            ),
        ),
      ),
    );
  }

  AssetImage getLiveIndexIcon(int code){
    if(code == 7){
      // 化妆
    }else if(code == 12){
       // 感冒
    }else if(code == 17){
      // 洗车
    }else if(code == 18){
      // 空气污染
    }else if(code == 20){
      // 穿衣指数
    }else if(code == 21){
      // 紫外线
    }else if(code == 26){
      // 运动
    }else if(code == 28){
      // 钓鱼
    }
    return AssetImage("assets/weatherIcons/W0.png");
  }
}