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
  int? _selectedOutputend = 0;
  int? _selectedDeadline = 0;
  int? get selectedOutputend => _selectedOutputend;
  int? get selectedDeadline => _selectedDeadline;
  List<bool> setColor = [];
  List<Map<String, dynamic>> combinedData = [];

//page 로딩시
  Future<void> pageLoad(String detailNumber) async {
    await outputStDetailData(detailNumber);
    await setController();
    await outputEndData();
    await deadLineData();
  }

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

  //출고수량 controller
  Future<void> setController() async {
    for (int i = 0; i < detailData.value.length; i++) {
      outcontroller.add(
          TextEditingController()); //detailData만큼 TextEditingController를 add한다

      outcontroller[i].text =
          detailData.value[i]['SO_QT'].replaceAll('TSST_', '').toString();
      setColor.add(false);
    }
  }

  //출고구분 controller code
  Future<void> outputEndData() async {
    String detailDataString =
        await SqlConn.readData("exec SP_MOBILE_DROPBOX 'SO_FG'");
    List<dynamic> decodedData = jsonDecode(detailDataString);
    List<Map<String, dynamic>> processedData =
        List<Map<String, dynamic>>.from(decodedData);
    outputEnd.value = processedData;
  }

  //마감 controller code
  Future<void> deadLineData() async {
    String detailDataString =
        await SqlConn.readData("exec SP_MOBILE_DROPBOX 'PROC_FG'");
    List<dynamic> decodedData = jsonDecode(detailDataString);
    List<Map<String, dynamic>> processedData =
        List<Map<String, dynamic>>.from(decodedData);
    deadLine.value = processedData;
  }

  //출고구분 선택된 값 가져오는 controller
  void setSelectedOutputend(int newValue) {
    _selectedOutputend = newValue;
    update();
  }
  //마감 선택된 값을 가져오는 controller
  void setSelectedDeadline(int newValue) {
    _selectedDeadline = newValue;
    update();
  }
  //컬러 값 컨트롤러
  Color selectColor(int index) {
    if (this.setColor[index] == true) {
      return Color(0xFF3E8EDE);
    }
    return Color.fromRGBO(240, 248, 255, 1);
  }

  Future<void> colorBool(int index) async {
  if (setColor[index] == true) {
    setColor[index] = false;
  } else {
    setColor[index] = true;
  }

  if (setColor[index] == true) {
    Map<String, dynamic> selectedOutputend;
    if (_selectedOutputend == 0) {
      selectedOutputend = outputEnd.value[0];
    } else {
      selectedOutputend = outputEnd.value[1];
    }

    Map<String, dynamic> selectedDeadline;
    if (_selectedDeadline == 0) {
      selectedDeadline = deadLine.value[0];
    } else {
      selectedDeadline = deadLine.value[1];
    }

    await combineData(index, selectedOutputend, selectedDeadline);
  }
}
  //출고등록 controller
  Future<void> combineData(
      int index, Map<String, dynamic> selectedOutputend, Map<String, dynamic> selectedDeadline) async {
    combinedData.clear(); //데이터 초기화
    Map<String, dynamic> combinedItem = {};

    print('1 : ${selectedOutputend}');
    print('2 : ${selectedDeadline}');
    print('3 : ${detailData.value[index]}');

    combinedItem.addAll(selectedOutputend);
    combinedItem.addAll(selectedDeadline);
    combinedItem.addAll(detailData.value[index]);
    

    combinedData.add(combinedItem);

    print('여기 : ${combinedData}');
  }
}

// Color.fromRGBO(240, 248, 255, 1)

//출고구분값과 마감 값과 index된 값, 출고수량값을 합쳐서 등록시킨다..