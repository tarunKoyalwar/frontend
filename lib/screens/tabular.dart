import 'dart:developer';

import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:httpxfrontend/screens/table_data.dart';
import 'types.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TabularView extends StatefulWidget {
  const TabularView({super.key});

  @override
  State<TabularView> createState() => _TabularViewState();
}

class _TabularViewState extends State<TabularView> {
  String _cursor = "";
  final int rowsPerPage = 100;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
        child: FutureBuilder<List<Result>>(
          future: fetchJSONL(100),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return buildDataTableV2(context, snapshot.data);
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return const CircularProgressIndicator();
          },
        ));
  }

  // Widget buildDataTable(context, List<Result>? data) {
  //   return SingleChildScrollView(
  //     child: PaginatedDataTable(rowsPerPage: rowsPerPage, columns: getAllColumns(), source: TableData(data ?? [])),
  //   );
  // }

  Widget buildDataTableV2(context, List<Result>? data) {
    return PaginatedDataTable2(rowsPerPage: rowsPerPage, columns: getAllColumns(), source: TableData(data ?? []));
  }

  List<DataColumn> getAllColumns() {
    return [
      getColumn('Scheme'),
      getColumn('Input'),
      getColumn('Status Code', numeric: true),
      getColumn('Title'),
      getColumn('Web Server'),
    ];
  }

// call setState in this method
  void sort<T>(int columnIndex, bool ascending) {}

  DataColumn getColumn(String value, {bool numeric = false}) {
    return DataColumn(
      label: Text(value),
      numeric: numeric,
      onSort: (columnIndex, ascending) {
        if (numeric) {
          sort<int>(columnIndex, ascending);
        } else {
          sort<String>(columnIndex, ascending);
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
  }

  // fetchJSONL fetches the data from the server in JSONL format
  Future<List<Result>> fetchJSONL(int limit) async {
    Uri url = fetchRowUrl;
    Map<String, String> params = {
      "limit": limit.toString(),
      "cursor": _cursor,
    };
    url = url.replace(queryParameters: params);
    final response = await http.get(url);
    if (response.statusCode == 200) {
      List<Result> data = [];
      LineSplitter.split(response.body).forEach((element) {
        log(element);
        if (element != "") {
          var body = json.decode(element);
          data.add(Result.fromJson(body));
        }
      });
      _cursor = response.headers['x-cursor'] ?? "";
      return data;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
