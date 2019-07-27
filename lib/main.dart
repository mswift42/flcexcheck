import 'package:flcexcheck/widgets/searchwidget.dart';
import 'package:flutter/material.dart';

void main() => runApp(new FlCexApp());

class FlCexApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
            brightness: Brightness.light,
            primaryColor: Color.fromARGB(255, 223, 33, 39),
            accentColor: Color.fromARGB( 255, 0, 105, 179),
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
