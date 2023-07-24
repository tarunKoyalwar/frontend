import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:httpxfrontend/screens/types.dart';

Uri fetchCountUrl = Uri.parse('http://127.0.0.1:8085/count');
Uri fetchRowUrl = Uri.parse('http://127.0.0.1:8085/data');

// TableData contains the data to be displayed in the table.
class TableData extends DataTableSource {
  // replace this with shared_preferes key:value store
  final List<Result> data;
  int _rowCount = 0;

  TableData({this.data = const []}) {
    log('TableData constructor');
    fetchRowCount().then((value) {
      _rowCount = value;
    });
  }

  @override
  DataRow? getRow(int index) {
    if (index >= data.length) {
      fetchRow(index).then((value) {
        data.add(value);
        notifyListeners();
      });
      return null;
    }
    final row = data[index];
    return getDataRow(index, row);
  }

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

  DataCell getDataCell(String? value) {
    return DataCell(Text(value ?? ''));
  }

  Future<Result> fetchRow(int index) async {
    Uri url = fetchRowUrl;
    url.queryParameters.update("index", (value) => index.toString(), ifAbsent: () => index.toString());
    final response = await http.get(url);
    if (response.statusCode == 200) {
      var body = json.decode(response.body);
      return Result.fromJson(body);
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  @override
  bool get isRowCountApproximate => true;

  @override
  int get rowCount => _rowCount;

  @override
  int get selectedRowCount => 0;

  Future<int> fetchRowCount() async {
    final response = await http.get(fetchCountUrl);
    if (response.statusCode == 200) {
      return int.parse(response.body);
    } else {
      throw Exception('Failed to fetch row count');
    }
  }
}
