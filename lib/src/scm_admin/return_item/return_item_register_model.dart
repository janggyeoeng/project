import 'dart:convert';

import 'package:get/get.dart';
import 'package:sql_conn/sql_conn.dart';

class ReturnRegisterModel {
  RxList<Map<String, dynamic>> returnData = RxList<Map<String, dynamic>>([]);
  List<Map<String, dynamic>> rtData = [];

  Future<void> returnItem() async {
    String returnItem = await SqlConn.readData(
        "exec SP_TS1JA0003A_R1_BAK '1001', 'PD2310000005'");
    String checkData = returnItem.replaceAll('tsst', '');
    List<dynamic> decodedData = jsonDecode(checkData);
    rtData = List<Map<String, dynamic>>.from(decodedData);
    returnData.value = rtData;
    print(returnData);
  }
}
