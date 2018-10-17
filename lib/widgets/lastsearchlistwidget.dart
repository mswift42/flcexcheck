import 'package:flutter/material.dart';

class  LastSearchGrid extends StatelessWidget {
  final ValueChanged<String> onDeleted;
  final List<String> _lastSearches;
  LastSearchGrid(this.onDeleted, this._lastSearches);

  void _handleOnDelete(String value) {
    onDeleted(value);
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.extent(
        maxCrossAxisExtent: 180.0,
        children: _lastSearches.map((i) => LastSearchWidget(
          i, _handleOnDelete)
        ).toList(),
      )
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

