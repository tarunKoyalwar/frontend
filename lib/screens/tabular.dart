import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:httpxfrontend/screens/table_data.dart';

class TabularView extends StatefulWidget {
  const TabularView({super.key});

  @override
  State<TabularView> createState() => _TabularViewState();
}

class _TabularViewState extends State<TabularView> {
  final DataTableSource _data = TableData();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
      child: buildDataTable(context),
    );
  }

  Widget buildDataTable(context) {
    log(_data.rowCount.toString());
    return PaginatedDataTable(columns: [
      getColumn('Scheme'),
      getColumn('Input'),
      getColumn('Status Code', numeric: true),
      getColumn('Title'),
      getColumn('Web Server'),
    ], source: _data);
  }

  DataColumn getColumn(String value, {bool numeric = false}) {
    return DataColumn(label: Text(value), numeric: numeric);
  }
}
