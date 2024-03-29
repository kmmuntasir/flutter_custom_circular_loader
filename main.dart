import 'custom_percentage_widget.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Custom Circular Loader Demo",
      home: Scaffold(
        appBar: AppBar(
          title: Text("Custom Circular Loader Demo"),
        ),
        body: Container(
          child: Center(
            child: loader,
          ),
        ),
      ),
    );
  }
}


Widget loader = CustomCircularLoader(
  coveredPercent: 65,
  circleHeader: "Total",
  circleSize: 200.0,
  circleWidth: 5.0,
  headerInBottom: true,
  animationDuration: 1000,
  circleColor: Colors.grey[100],
  coveredCircleColor: Colors.red,
  coveredPercentStyle: TextStyle(
      fontSize: 44.0,
      fontWeight: FontWeight.w600,
      color: Colors.red
  ),
  circleHeaderStyle: TextStyle(
      fontSize: 22.0,
      fontWeight: FontWeight.w400,
      color: Colors.grey[900]
  ),
);