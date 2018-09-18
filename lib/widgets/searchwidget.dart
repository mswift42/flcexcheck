import 'package:flutter/material.dart';
import 'package:flcexcheck/store.dart' show Store;
import 'package:flcexcheck/product.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

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

  void _searchProduct(String inp) async {
    if (inp != '') {
      var prods = await fetchProduct(inp, activeStore.id);
      setState(() {
        searchquery = inp;
      });
    }
  }

  void handleActiveStoreChanged(Store store) async {
    _searchProduct(searchquery);
    setState(() {
      activeStore = store;
    });
  }

  String prodUrl(String query, String storeid) {
    return 'https://cxchecker.appspot.com/querycx?query=$query&location=$storeid';
  }

  Future<List<Product>> fetchProduct(String query, String storeid) async {
    final url = prodUrl(query, storeid);
    final response = await http.get(url);

    if (response.statusCode == 200) {
      // return Product.fromJson(json.decode(response.body));
      var decoded = json.decode(response.body) as List;
     print(decoded);
        return decoded.map((i) => Product.fromJson(i)).toList();
    } else {
      throw Exception("Failed to load product");
    }
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
            mainAxisAlignment: MainAxisAlignment.spaceAround,
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
