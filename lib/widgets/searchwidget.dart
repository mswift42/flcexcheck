import 'package:flutter/material.dart';
import 'package:flcexcheck/store.dart' show Store;
import 'package:flcexcheck/product.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:flcexcheck/widgets/productswidget.dart';
import 'package:flcexcheck/last_search_service.dart';

class SearchWidget extends StatefulWidget {
  final LastSearchService searchServie = LastSearchService();
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  Store activeStore = _stores[0];
  String searchquery = "";
  Set<String> _lastSearches = Set();
  static final _stores = [
    Store("Rose Street", "54"),
    Store("Cameron Toll", "3017"),
    Store("Leith", "3115")
  ];
  final controller = TextEditingController();

  void _searchProduct(String inp) async {
    if (inp != '') {
      _lastSearches.add(inp);
      widget.searchServie.writeSearches(_lastSearches.toList());
      Navigator.of(context).push(
        new MaterialPageRoute(
          builder: (context) => Scaffold(
                appBar: AppBar(
                    title: Text(
                  "Showing $searchquery at ${activeStore.location}.",
                  textScaleFactor: 0.7,
                )),
                body:
                    _showResultsBody(fetchProduct(searchquery, activeStore.id)),
              ),
        ),
      );
    }
  }

  void _setSearchQueryText() {
      setState(() {
        searchquery = controller.text;
      });
  }

  @override
  void initState() {
    super.initState();
    controller.addListener(_setSearchQueryText);
    widget.searchServie.readSearches().then((List value) {
      setState(() {
        _lastSearches = Set.from(value) ?? Set();
      });
    });
  }

  void handleActiveStoreChanged(Store store) async {
    _searchProduct(searchquery);
    setState(() {
      activeStore = store;
    });
  }

  void _handlePillTap(String inp) {
    setState(() {
      searchquery = inp;
      controller.text = inp;
    });
  }

  @override
  void dispose() {
    controller.removeListener(_setSearchQueryText);
    controller.dispose();
    super.dispose();
  }

  String prodUrl(String query, String storeid) {
    return 'https://cxchecker.appspot.com/querycx?query=$query&location=$storeid';
  }

  Future<List<Product>> fetchProduct(String query, String storeid) async {
    final url = prodUrl(query, storeid);
    final response = await http.get(url);

    if (response.statusCode == 200) {
      var decoded = json.decode(response.body) as List;
      if (decoded != null) {
        return decoded.map((i) => Product.fromJson(i)).toList();
      } else {
        return [];
      }
    } else {
      throw Exception("Failed to load product");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            child: TextField(
              controller: controller,
              onSubmitted: _searchProduct,
            ),
            padding: EdgeInsets.symmetric(vertical: 6.00, horizontal: 8.00),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: _stores
                .map((i) =>
                    _radioWidget(i, activeStore, handleActiveStoreChanged))
                .toList(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: _lastSearches
                .map((i) => _lastSearchWidget(i, _handlePillTap))
                .toList(),
          )
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

Widget _lastSearchWidget(String value, handler) {
  return GestureDetector(
    onTap: handler(value),
    child: Container(
        child: Chip(
      label: Text(value),
    )),
  );
}

FutureBuilder<List<Product>> _showResultsBody(Future<List<Product>> handler) {
  return FutureBuilder(
    future: handler,
    builder: (BuildContext context, AsyncSnapshot<List<Product>> snapshot) {
      switch (snapshot.connectionState) {
        case ConnectionState.none:
          return Container(child: Center(child: Text("Please try again.")));
        case ConnectionState.active:
        case ConnectionState.waiting:
          return Container(child: Center(child: CircularProgressIndicator()));
        case ConnectionState.done:
          if (snapshot.hasError) {
            return Text("Something went wrong: ${snapshot.error}");
          }
          return ProductsWidget(snapshot.data);
      }
    },
  );
}
