import 'dart:convert';
import 'package:get/get.dart';
import 'package:sql_conn/sql_conn.dart';


class OutPutRegisterController extends GetxController {
  Rx<DateTime> selectedStartDate = Rx<DateTime>(DateTime.now());
  Rx<DateTime> selectedEndDate = Rx<DateTime>(DateTime.now());
  RxList<Map<String, dynamic>> outputregisterlist = RxList<Map<String, dynamic>>([]);

  Future<void> OutputRegisterData(DateTime startDate, DateTime endDate, String searchKeyword, String customerKeyword) async {
    String outputdata = await SqlConn.readData(
        "exec SP_MOBILE_DELIVER_R1 '1001', '$startDate', '$endDate', '$searchKeyword', '$customerKeyword'");
    List<Map<String, dynamic>> decodedData =
        List<Map<String, dynamic>>.from(jsonDecode(outputdata));
    outputregisterlist.assignAll(decodedData);
    update();
  }
}