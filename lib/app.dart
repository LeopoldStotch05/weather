import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'units/main_screen/screen/main_screen.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: Colors.indigo[900], cardColor: Colors.amber),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
