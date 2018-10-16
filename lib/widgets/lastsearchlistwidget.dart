import 'package:flutter/material.dart';

class  LastSearchList extends StatelessWidget {
  List<String> _lastSearches;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.extent(
        maxCrossAxisExtent: 180.0,
        children: <Widget>[],)
    );
  }
}

class LastSearchWidget extends StatelessWidget {
  final ValueChanged<String> onDeleted;

  LastSearchWidget(this.onDeleted);
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

