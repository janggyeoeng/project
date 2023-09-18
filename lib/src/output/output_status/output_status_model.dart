import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sql_conn/sql_conn.dart';

class OutPutStatusModel {
  Rx<DateTime> selectedStartDate = Rx<DateTime>(DateTime.now());
  Rx<DateTime> selectedEndDate = Rx<DateTime>(DateTime.now());
  RxList<Map<String, dynamic>> outputlist = RxList<Map<String, dynamic>>([]);
  String isuNb = '';
  String trNm = '';

  final TextEditingController searchController = TextEditingController();

  TextEditingController getSearch() {
    return searchController;
  }

  Future<DateTimeRange?> selectDateRange(
      BuildContext context, DateTimeRange selectedDateRange) async {
    return await showDateRangePicker(
      context: context,
      initialDateRange: selectedDateRange,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
  }

  final _selectedDateRange = DateTimeRange(
    start: DateTime.now(),
    end: DateTime.now().add(const Duration(days: 2)),
  ).obs;

  DateTimeRange get selectedDateRange => _selectedDateRange.value;

  Future<void> selectDate(BuildContext context) async {
    DateTimeRange? pickedDateRange =
        await selectDateRange(context, _selectedDateRange.value);
    if (pickedDateRange != null &&
        pickedDateRange != _selectedDateRange.value) {
      _selectedDateRange.value = pickedDateRange;
    }
  }

  Future<void> outputStatusData(
      DateTime startDate, DateTime endDate, String searchKeyword) async {
    String outputdata = await SqlConn.readData(
        "SP_MOBILE_DELIVER_R3 '1001', '$startDate', '$endDate', '$searchKeyword'");
    List<Map<String, dynamic>> decodedData =
        List<Map<String, dynamic>>.from(jsonDecode(outputdata));
    outputlist.assignAll(decodedData);
  }

  Future<void> outputdata() async {
    String searchKeyword = searchController.text;
    await outputStatusData(
      selectedDateRange.start,
      selectedDateRange.end,
      searchKeyword,
    );
  }

  Future<void> setInfo(int index) async {
    trNm = outputlist[index]['TR_NM'];
  }
}
