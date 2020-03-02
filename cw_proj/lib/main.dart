import 'package:cw_proj/provider/ThemeProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cw_proj/screens/main_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_){
    runApp(MyApp());
  });
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
    // SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //   // statusBarColor: isDark ? Constants.darkPrimary:Constants.lightPrimary,
    //   // statusBarIconBrightness: isDark? Brightness.light:Brightness.dark,
    //   statusBarColor: Colors.transparent,
    //   statusBarIconBrightness: Brightness.light
    // ));
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
    );
  }
}