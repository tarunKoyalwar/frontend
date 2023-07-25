import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:httpxfrontend/screens/types.dart';

Uri fetchCountUrl = Uri.parse('http://127.0.0.1:8085/count');
Uri fetchRowUrl = Uri.parse('http://127.0.0.1:8085/data');

// TableData contains the data to be displayed in the table.
class TableData extends DataTableSource {
  // replace this with shared_preferes key:value store
  late final List<Result> data;
  int _rowCount = 0;

// Constructor for TableData
  TableData(List<Result> value) {
    log('TableData constructor');
    data = value;
    _rowCount = data.length;
  }

  @override
  DataRow? getRow(int index) {
    if (index >= data.length) {
      log('index >= data.length');
      return null;
    }
    final row = data[index];
    return getDataRow(index, row);
  }

// getDataRow returns a DataRow for the given index and row
  DataRow getDataRow(int index, Result row) {
    return DataRow.byIndex(
      index: index,
      cells: [
        getDataCell(row.scheme),
        getDataCell(row.input),
        getDataCell(row.statusCode.toString()),
        getDataCell(row.title),
        getDataCell(row.webServer),
      ],
    );
  }

// getDataCell returns a DataCell for the given value
  DataCell getDataCell(String? value) {
    return DataCell(Text(value ?? ''));
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _rowCount;

  @override
  int get selectedRowCount => 0;
}
