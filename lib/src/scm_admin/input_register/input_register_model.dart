import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sql_conn/sql_conn.dart';

class ScmRegisterModel {
  var barcodeFocusNodes = FocusNode();
  var textFocusNodes = FocusNode();
  RxList<Map<String, dynamic>> rsData = RxList<Map<String, dynamic>>([]);
  List<Map<String, dynamic>> selectData1 = [];
  List<Map<String, dynamic>> selectData = [];
  String psuNb = '';
  String trNm = '';
  bool check = false;
  List<bool> datavalue = [];

  Map<String, List<String>> selectCheckDataList = {};

  Future<void> setController() async {
    for (int i = 0; i < rsData.length; i++) {
      datavalue.add(false);
    }
  }

  Future<Map<String, dynamic>> getBindMapData(int index) async {
    return selectData1[index];
  }

  String getPsuNb() {
    return psuNb;
  }

  String getTrNm() {
    return trNm;
  }

  Future<void> setTitleData(Map<String, dynamic> map) async {
    psuNb = map['PSU_NB'];
    trNm = map['TR_NM'];
  }

  dynamic textFocusListner(BuildContext context, void Function()? state) {
    return textFocusNodes.addListener(() {
      print(textFocusNodes.hasFocus);
      if (textFocusNodes.hasFocus == false) {
        //keyboardClick = false;

        FocusScope.of(context).requestFocus(barcodeFocusNodes);
        state;
      }
    });
  }

  Future<void> barcodeScan(String barcode, BuildContext context) async {
    List scanData = [];
    scanData = barcode.split('/');
    String detailDataString = '';

    String count = await SqlConn.readData(
        "SELECT COUNT(IMPORTSPEC) AS NUMBER FROM TSIMPORTINSPEC WHERE PSU_NB = '${scanData[0]}'");
    List<dynamic> decodedData = jsonDecode(count);
    selectData = List<Map<String, dynamic>>.from(decodedData);
    for (int i = 0; i < selectData.length; i++) {
      if (selectData[i]["NUMBER"] >= 1) {
        check = true;
        break;
      } else {
        check = false;
      }
    }
    if (check == true) {
      detailDataString = await SqlConn.readData(
          "exec SP_MOBILE_SCM_REGIST_R '1001', '${scanData[0]}'");
      String detailData = detailDataString.replaceAll('tsst', '');
      List<dynamic> decodedData = jsonDecode(detailData);
      selectData1 = List<Map<String, dynamic>>.from(decodedData);
      rsData.value = selectData1;
      await setTitleData(rsData[0]);
    } else {
      isuQtCheckDialog(context, '수입검사가 이루어지지않았습니다.');
    }
  }

  Color getColor(int index) {
    if (datavalue[index] == true) {
      return Colors.blue.shade300;
    } else {
      return Colors.grey.shade300;
    }
  }

  void isuQtCheckDialog(BuildContext context, String errorMessage) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(errorMessage),
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('확인'))
            ],
          );
        });
  }
}
