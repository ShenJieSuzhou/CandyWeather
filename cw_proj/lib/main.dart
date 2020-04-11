import 'package:cw_proj/provider/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cw_proj/screens/main_screen.dart';
import 'package:cw_proj/common/global.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async{
 WidgetsFlutterBinding.ensureInitialized();
//  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_){
   return Global.init().then((e) => runApp(MyApp()));
//  });
  
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDark = false;
  
  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    ThemeProvider provider = ThemeProvider();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '铂金天气',
      theme: provider.getTheme(),
      darkTheme: provider.getTheme(isDarkMode: true),
      home: MainScreen(),
      builder: (context, child){
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0), // 或者 MediaQueryData.fromWindow(WidgetsBinding.instance.window).copyWith(textScaleFactor: 1.0),
          child: child,
        );
      },
    );
  }
}