import 'dart:convert';
import 'package:get/get.dart';
import 'package:sql_conn/sql_conn.dart';


class OpDetailController extends GetxController {
  Rx<List<Map<String, dynamic>>> detailData = Rx<List<Map<String, dynamic>>>([]);

  Future<void> OutputStDetailData(String detailNumber) async {
    String detailDataString = await SqlConn.readData(
      "SP_MOBILE_DELIVER_R4 '1001', '$detailNumber'");
    List<dynamic> decodedData = jsonDecode(detailDataString);
    detailData.value = List<Map<String, dynamic>>.from(decodedData);
    print(this.detailData);
  }
}