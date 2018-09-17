import 'package:flutter/material.dart';
import 'package:flcexcheck/store.dart' show Store;

class SearchWidget extends StatefulWidget {

  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  Store activeStore;
  String searchquery;
  final controller = TextEditingController();

  void _searchProduct(String inp) {
    setState(() {
      searchquery = inp;
    });
  }
  @override
  Widget build(BuildContext context) {
  return Container(
    child: Column(
      children: <Widget>[
        TextField(
          controller: controller,
          onSubmitted: _searchProduct,
        ),
        Text(searchquery),
      ],
    ),
  );
  }
}
