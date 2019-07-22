import 'package:flcexcheck/widgets/searchwidget.dart';
import 'package:flutter/material.dart';

void main() => runApp(new FlCexApp());

class FlCexApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
            brightness: Brightness.light,
            primaryColor: Colors.cyan[600],
            accentColor: Colors.blueGrey[500],
            textTheme: TextTheme(
              body1: TextStyle(fontWeight: FontWeight.w500),
              body2: TextStyle(fontWeight: FontWeight.w700),
            )),
        title: 'CexCheck',
        home: Scaffold(
            appBar: AppBar(
              title: Text('CexCheck'),
            ),
            body: Center(
              child: SearchWidget(),
            )));
  }
}
