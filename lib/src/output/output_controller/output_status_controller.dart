import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hnde_pda/src/service/date_time.dart';
import 'package:sql_conn/sql_conn.dart';

class OutPutController extends GetxController {
  Rx<DateTime> selectedStartDate = Rx<DateTime>(DateTime.now());
  Rx<DateTime> selectedEndDate = Rx<DateTime>(DateTime.now());
  RxList<Map<String, dynamic>> outputlist = RxList<Map<String, dynamic>>([]);
  String isuNb = '';
  String trNm = '';
  final Datechk dateck = Get.put(Datechk());

  Future<void> OutputStatusData(
      DateTime startDate, DateTime endDate, String searchKeyword) async {
    String outputdata = await SqlConn.readData(
        "SP_MOBILE_DELIVER_R3 '1001', '$startDate', '$endDate', '$searchKeyword'");
    List<Map<String, dynamic>> decodedData =
        List<Map<String, dynamic>>.from(jsonDecode(outputdata));
    outputlist.assignAll(decodedData);
    update();
  }

  final TextEditingController searchController = TextEditingController();

  Future<void> outputdata() async {
    String searchKeyword = searchController.text;
    await OutputStatusData(
      dateck.selectedDateRange.start,
      dateck.selectedDateRange.end,
      searchKeyword,
    );
  }

  Future<void> setInfo(int index) async {
    trNm = outputlist[index]['TR_NM'];
  }
}
