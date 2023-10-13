import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sql_conn/sql_conn.dart';

class OutputStatusDetailModel {
  Rx<List<Map<String, dynamic>>> detailData =
      Rx<List<Map<String, dynamic>>>([]);

  Future<void> outputStDetailData(String detailNumber) async {
    String detailDataString =
        await SqlConn.readData("SP_MOBILE_DELIVER_R4 '1001', '$detailNumber'");
    print('dkdsk : $detailDataString');
    List<dynamic> decodedData = jsonDecode(detailDataString);
    detailData.value = List<Map<String, dynamic>>.from(decodedData);
    print(detailData);
  }

  Widget detailcontainar(String text, TextStyle style, Color color) {
    return Container(
      height: 66,
      width: 99.7,
      decoration: BoxDecoration(
        color: color,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(1),
          ),
        ],
      ),
      child: Center(
          child: Text(
        text,
        style: style,
        textAlign: TextAlign.center,
      )),
    );
  }
}
