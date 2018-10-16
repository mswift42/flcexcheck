import 'package:flutter/material.dart';

class  LastSearchList extends StatelessWidget {
  final ValueChanged<String> onDeleted;
  List<String> _lastSearches;
  LastSearchList(this.onDeleted, this._lastSearches);
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
  final String value;
  final ValueChanged<String> onDeleted;

  LastSearchWidget(this.value, this.onDeleted);

  void _handleOnDelete() {
    onDeleted(value);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Chip(
        label: Text(value),
        deleteIcon: Icon(Icons.delete),
        onDeleted: _handleOnDelete,
      ),
    );
  }
}

