import 'package:flutter/material.dart';
import 'package:flcexcheck/store.dart' show Store;

class SearchWidget extends StatefulWidget {
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  Store activeStore = _stores[0];
  String searchquery = "Search Query";
  static final _stores = [
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
          Row(
            children: _stores
                .map((i) =>
                    _radioWidget(i, activeStore, handleActiveStoreChanged))
                .toList(),
          ),
        ],
      ),
    );
  }
}

Widget _radioWidget(
    Store value, Store groupvalue, ValueChanged<Store> handler) {
  return Row(
    children: <Widget>[
      Text(value.location),
      Radio<Store>(
        value: value,
        groupValue: groupvalue,
        onChanged: handler,
      ),
    ],
  );
}
