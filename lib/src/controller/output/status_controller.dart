import 'dart:convert';
import 'package:get/get.dart';
import 'package:sql_conn/sql_conn.dart';

class OutPutController extends GetxController {
  Rx<DateTime> selectedStartDate = Rx<DateTime>(DateTime.now());
  Rx<DateTime> selectedEndDate = Rx<DateTime>(DateTime.now());
  RxList<Map<String, dynamic>> outputlist = RxList<Map<String, dynamic>>([]);

  Future<void> OutputStatusData(DateTime startDate, DateTime endDate, String searchKeyword) async {
    String outputdata = await SqlConn.readData(
        "SP_TSDELIVER_MOBILE_R1 '1000', '$searchKeyword', '$startDate', '$endDate'");
    List<Map<String, dynamic>> decodedData =
        List<Map<String, dynamic>>.from(jsonDecode(outputdata));
    outputlist.assignAll(decodedData);
    update();
  }
}