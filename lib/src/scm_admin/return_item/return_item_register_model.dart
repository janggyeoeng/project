import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sql_conn/sql_conn.dart';

class ReturnRegisterModel {
  RxList<Map<String, dynamic>> returnData = RxList<Map<String, dynamic>>([]);
  List<Map<String, dynamic>> rtData = [];
  String psuNb = '';
  int psuSq = 0;
  String trNm = '';
  String psudt = '';
  Map<String, List<String>> selectCheckDataList = {};
  List<String> sum = [];
  List<bool> datavalue = [];
  List<String> barcodedata = [];

  Future<Map<String, dynamic>> getBindMapData(int index) async {
    return returnData[index];
  }

  Future<void> setTitleData(Map<String, dynamic> map) async {
    psuNb = map['PSU_NB'];
    psuSq = int.parse(map['PSU_SQ']);
    trNm = map['TR_NM'];
    psudt = map['PSU_DT'];
  }

  String getPsuNb() {
    return psuNb;
  }

  String getTrNm() {
    return trNm;
  }

  String getPsuDt() {
    return psudt;
  }

  Future<void> setController() async {
    for (int i = 0; i < returnData.length; i++) {
      datavalue.add(false);
      sum.add('0');
    }
  }

  Future<void> returnItem(BuildContext context, String barcode) async {
    List scanData = [];
    scanData = barcode.split('/');
    print("asdad : $scanData");
    if (barcode.isEmpty) {
      return isuQtCheckDialog(context, '바코드가 입력되지 않았습니다.');
    }
    if (scanData[0].length != 12 || !scanData[0].startsWith('PD')) {
      isuQtCheckDialog(context, '바코드가 올바르지 않습니다.');
    } else {
      String returnItem = await SqlConn.readData(
          "exec SP_TS1JA0003A_R1_BAK '1001', '${scanData[0]}'");
      String checkData = returnItem.replaceAll('tsst', '');
      List<dynamic> decodedData = jsonDecode(checkData);
      rtData = List<Map<String, dynamic>>.from(decodedData);
      returnData.value = rtData;
      await setTitleData(returnData[0]);
      print(returnData);
    }
  }

  Future<void> returnRegist(BuildContext context, String psudt) async {
    for (int i = 0; i < barcodedata.length; i++) {
      var regist = await SqlConn.writeData(
          "exec  SP_SCM_TS1JA0003A_C1 '1001','$psudt', '${barcodedata[i]}'");
      if (regist) {
        isuQtCheckDialog(context, '반품등록이 완료되었습니다.');
      } else {
        isuQtCheckDialog(context, '반품등록이 안된다.');
      }
    }
  }

//datavalue[index] == true
//selectCheckDataList.values.toList()[index].contains('1')
  Color getColor(int index) {
    if (datavalue[index] == true) {
      return Colors.blue.shade300;
    } else {
      return Colors.grey.shade300;
    }
  }

  String psuQt(int index) {
    if (datavalue[index] == true) {
      return sum[index];
    } else {
      return returnData[index]["BAR_QT"];
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
