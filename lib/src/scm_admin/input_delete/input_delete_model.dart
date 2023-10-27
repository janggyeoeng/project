import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sql_conn/sql_conn.dart';

class ScmDeleteModel {
  Rx<DateTime> selectedStartDate = Rx<DateTime>(DateTime.now());
  Rx<DateTime> selectedEndDate = Rx<DateTime>(DateTime.now());
  RxList<Map<String, dynamic>> deletedata = RxList<Map<String, dynamic>>([]);
  TextEditingController cscontroller = TextEditingController();
  List<bool> setColor = [];

  Future<void> pageLoad() async {
    await inputdata();
    await setController();
  }

  Future<void> colorck(int index) async {
    if (setColor[index] == false) {
      setColor[index] = true;
    } else if (setColor[index] == true) {
      setColor[index] = false;
    }
  }

  Future<void> setController() async {
    for (int i = 0; i < deletedata.length; i++) {
      setColor.add(false);
    }
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

  Future<void> inputdata() async {
    String customerKeyword = cscontroller.text;
    await deleteData(
      customerKeyword,
      selectedDateRange.start,
      selectedDateRange.end,
    );
  }

  Future<void> deleteData(
      String customerKeyword, DateTime startDate, DateTime endDate) async {
    String data = await SqlConn.readData(
        "exec SP_SCM_TS1JA0008A_R1_BAK '1001','$customerKeyword', 'B', '$startDate', '$endDate'");
    String detailData = data.replaceAll('tsst', '');
    List<Map<String, dynamic>> decodedData =
        List<Map<String, dynamic>>.from(jsonDecode(detailData));
    deletedata.assignAll(decodedData);
  }

  Color selectColor(int index) {
    if (setColor[index] == true) {
      return Colors.blue.shade300;
    }
    return Colors.grey.shade300;
  }
}
