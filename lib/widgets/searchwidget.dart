import 'package:flutter/material.dart';
import 'package:flcexcheck/store.dart' show Store;

class SearchWidget extends StatefulWidget {
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  Store activeStore;
  String searchquery;
  var _stores = [
    Store("Rose Street", "54"),
    Store("Cameron Toll", "3015"),
    Store("Leith", "3117")
  ];
  final controller = TextEditingController();

  void _searchProduct(String inp) {
    setState(() {
      searchquery = inp;
    });
  }

  void handleActiveStoreChanged(Store store) {
    setState(() {
      activeStore = store;
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
          Row(
            children: _stores.map((i) => Radio<Store>(
              value: i,
              groupValue: activeStore,
              onChanged: handleActiveStoreChanged,
            )).toList(),
          )
        ],
      ),
    );
  }
}

