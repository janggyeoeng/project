import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sql_conn/sql_conn.dart';

class OpRegisterDetailController extends GetxController {
  Rx<List<Map<String, dynamic>>> detailData =
      Rx<List<Map<String, dynamic>>>([]);
  Rx<List<Map<String, dynamic>>> outputEnd = Rx<List<Map<String, dynamic>>>([]);
  Rx<List<Map<String, dynamic>>> deadLine = Rx<List<Map<String, dynamic>>>([]);
  List<TextEditingController> outcontroller = [];

  List<bool> setColor = [];

//page 로딩시
  Future<void> pageLoad(String detailNumber) async {
    await outputStDetailData(detailNumber);
    await setController();
    await outputEndData();
    await deadLineData();
  }

  // Future<void> outputStDetailData(String detailNumber) async {
  //   String detailDataString = await SqlConn.readData(
  //       "exec SP_MOBILE_DELIVER_R2 '1001', '$detailNumber'");
  //   List<dynamic> decodedData = jsonDecode(detailDataString);
  //   detailData.value = List<Map<String, dynamic>>.from(decodedData);
  // }

  Future<void> outputStDetailData(String detailNumber) async {
    String detailDataString = await SqlConn.readData(
        "exec SP_MOBILE_DELIVER_R2 '1001', '$detailNumber'");

    List<dynamic> decodedData = jsonDecode(detailDataString);

    List<Map<String, dynamic>> modifiedData = decodedData.map((item) {
      Map<String, dynamic> modifiedItem = {};
      item.forEach((key, value) {
        if (value is String) {
          modifiedItem[key] = value.replaceAll('TSST_', '');
        } else {
          modifiedItem[key] = value;
        }
      });
      return modifiedItem;
    }).toList();

    detailData.value = modifiedData;
  }

  Future<void> outputEndData() async {
    String detailDataString =
        await SqlConn.readData("exec SP_MOBILE_DROPBOX 'SO_FG'");
    List<dynamic> decodedData = jsonDecode(detailDataString);
    List<Map<String, dynamic>> processedData = List<Map<String, dynamic>>.from(
            decodedData)
        .map((item) => {'CODE': item['CODE'], 'CODE_NAME': item['CODE_NAME']})
        .toList();
    outputEnd.value = processedData;
  }

  Future<void> deadLineData() async {
    String detailDataString =
        await SqlConn.readData("exec SP_MOBILE_DROPBOX 'PROC_FG'");
    List<dynamic> decodedData = jsonDecode(detailDataString);
    List<Map<String, dynamic>> processedData = List<Map<String, dynamic>>.from(
            decodedData)
        .map((item) => {'CODE': item['CODE'], 'CODE_NAME': item['CODE_NAME']})
        .toList();
    deadLine.value = processedData;
  }

  Future<void> setController() async {
    for (int i = 0; i < detailData.value.length; i++) {
      outcontroller.add(
          TextEditingController()); //detailData만큼 TextEditingController를 add한다

      outcontroller[i].text =
          detailData.value[i]['SO_QT'].replaceAll('TSST_', '').toString();
      setColor.add(false);
    }
  }

  Future<void> colorBool(int index) async {
    if (setColor[index] == true) {
      setColor[index] = false;
    } else {
      setColor[index] = true;
    }
  }

  Color selectColor(int index) {
    print(detailData.value[index]);
     print(setColor[index]);
    // print(setColor);
    if (this.setColor[index] == true) {
      return Color(0xFF3E8EDE);
    }
    return Color.fromRGBO(240, 248, 255, 1);
  }
}

// Color.fromRGBO(240, 248, 255, 1)