import 'dart:ui';

import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cw_proj/common/common.dart';
import 'package:cw_proj/common/themes.dart';
import 'package:cw_proj/res/colors.dart';
import 'package:cw_proj/res/styles.dart';


class ThemeProvider extends ChangeNotifier {

  static const Map<Themes, String> themes = {
    Themes.DARK: "Dark", Themes.LIGHT : "Light", Themes.SYSTEM : "System"
  };
  
  void syncTheme(){
    String theme = SpUtil.getString(Constant.theme);
    if (theme.isNotEmpty && theme != themes[Themes.SYSTEM]){
      notifyListeners();
    }
  }

  void setTheme(Themes theme) {
    SpUtil.putString(Constant.theme, themes[theme]);
    notifyListeners();
  }

  getTheme({bool isDarkMode: false}) {
    String theme = SpUtil.getString(Constant.theme);
    switch(theme){
      case "Dark":
        isDarkMode = true;
        break;
      case "Light":
        isDarkMode = false;
        break;
      default:
        break;
    }

    return ThemeData(
      errorColor: isDarkMode ? Colours.dark_red : Colours.red,
      brightness: isDarkMode ? Brightness.dark : Brightness.light,
      primaryColor: isDarkMode ? Colours.dark_app_main : Colours.app_main,
      accentColor: isDarkMode ? Colours.dark_app_main : Colours.app_main,
      // Tab指示器颜色
      indicatorColor: isDarkMode ? Colours.dark_app_main : Colours.app_main,
      // 页面背景色
      scaffoldBackgroundColor: isDarkMode ? Colours.dark_bg_color : Color(0xFFd8d8da),
      // 主要用于Material背景色
      canvasColor: isDarkMode ? Colours.dark_material_bg : Colors.white,
      // 文字选择色（输入框复制粘贴菜单）
      textSelectionColor: Colours.app_main.withAlpha(70),
      textSelectionHandleColor: Colours.app_main,
      textTheme: TextTheme(
        // TextField输入文字颜色
        subhead: isDarkMode ? TextStyles.textWhite14 : TextStyles.textDark,
        // Text文字样式
        body1: isDarkMode ? TextStyles.textWhite14: TextStyles.textDark,
        subtitle: isDarkMode ? TextStyles.textWhite14 : TextStyles.textDarkGray14,
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: isDarkMode ? TextStyles.textHint14 : TextStyles.textDarkGray14,
      ),
      appBarTheme: AppBarTheme(
        elevation: 0.0,
        color: isDarkMode ? Color(0xFF1c1c1e) : Color(0xFFf5f5f5),
        brightness: isDarkMode ? Brightness.dark : Brightness.light,
        iconTheme: IconThemeData(color: isDarkMode ? Colors.white : Colours.dark_bg_color),
        actionsIconTheme: IconThemeData(color: isDarkMode ? Colors.white : Colours.dark_bg_color),
      ),
      dividerTheme: DividerThemeData(
        color: isDarkMode ? Colours.dark_line : Colours.line,
        space: 0.6,
        thickness: 0.6
      ),
      cupertinoOverrideTheme: CupertinoThemeData(
        brightness: isDarkMode ? Brightness.dark : Brightness.light,
      ),
      iconTheme: IconThemeData(
        color: isDarkMode ? Color(0xFFFFFFFF) : Color(0xFF1c1c1e),
      ),
    );
  }

}