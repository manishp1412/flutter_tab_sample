import 'package:flutter/material.dart';
import 'package:my_shows/src/ui/HomeTabs.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo  a',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeTabs(),  
    );
  }
}
