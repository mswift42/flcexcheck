import 'package:flutter/material.dart';
import 'package:flcexcheck/mockproducts.dart';
import 'package:flcexcheck/widgets/ProductsWidget.dart';

void main() => runApp(new FlCexApp());

class FlCexApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CexCheck',
      home: Scaffold(
        appBar: AppBar(
          title: Text('CexCheck'),
        ),
        body: Center(
          child: ProductsWidget(mockProducts)
        )
      )
    );
  }
}



