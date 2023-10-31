import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hnde_pda/src/service/date_time.dart';
import 'package:sql_conn/sql_conn.dart';

class OutPutRegisterModel {
  Rx<DateTime> selectedStartDate = Rx<DateTime>(DateTime.now());
  Rx<DateTime> selectedEndDate = Rx<DateTime>(DateTime.now());
  RxList<Map<String, dynamic>> outputregisterlist =
      RxList<Map<String, dynamic>>([]);
  List<Map<String, dynamic>> outData = [];
  final Datechk datechk = Get.put(Datechk());
  final TextEditingController searchController = TextEditingController();
  final TextEditingController customerController = TextEditingController();

  Future<void> OutputRegisterData(DateTime startDate, DateTime endDate,
      String searchKeyword, String customerKeyword) async {
    String outputdata = await SqlConn.readData(
        "exec SP_MOBILE_DELIVER_R1 '1001', '$startDate', '$endDate', '$searchKeyword', '$customerKeyword'");
    String checkData = outputdata.replaceAll('TSST_', ' ');
    List<dynamic> decodedData = jsonDecode(checkData);
    outData = List<Map<String, dynamic>>.from(decodedData);
    outputregisterlist.value = outData;
    print(outputregisterlist);
  }

  Widget container(String text) {
    return Expanded(
        flex: 2,
        child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white.withOpacity(0.3)),
              color: const Color(0xFF3E8EDE),
            ),
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20, color: Colors.white),
            )));
  }

  Widget expanded(String text) {
    return Expanded(
      flex: 2,
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black.withOpacity(0.01)),
        ),
        child: AutoSizeText(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Future<void> outputregisterdata() async {
    String searchKeyword = searchController.text;
    String customerKeyword = customerController.text;
    await OutputRegisterData(datechk.selectedDateRange.start,
        datechk.selectedDateRange.end, searchKeyword, customerKeyword);
  }
}
