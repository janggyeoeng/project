import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sql_conn/sql_conn.dart';

class ScmCheckModel {
  var barcodeFocusNodes = FocusNode();
  var textFocusNodes = FocusNode();
  bool keyboardClick = false;
  List<Map<String, dynamic>> selectData = [];
  RxList<Map<String, dynamic>> detailData = RxList<Map<String, dynamic>>([]);

  String psuNb = '';
  String trNm = '';

  Future<void> pageLoad() async {}

  Future<Map<String, dynamic>> getBindMapData(int index) async {
    return detailData[index];
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

  Future<void> setKeyboardClick(bool bo) async {
    keyboardClick = bo;
    //print('불값 : ${this.keyboardClick}');
  }

  FocusNode getTextNode() {
    return textFocusNodes;
  }

  FocusNode getBarcodeNode() {
    return barcodeFocusNodes;
  }

  dynamic textFocusListner(BuildContext context, void Function()? state) {
    return textFocusNodes.addListener(() {
      print(textFocusNodes.hasFocus);
      if (textFocusNodes.hasFocus == false) {
        keyboardClick = false;
        FocusScope.of(context).requestFocus(barcodeFocusNodes);
        state;
      }
    });
  }

  dynamic barcodeFocusListner(BuildContext context) {
    return barcodeFocusNodes.addListener(() {
      // print('리스너가 먼저?');
      if (barcodeFocusNodes.hasFocus == false && keyboardClick == false) {
        FocusScope.of(context).requestFocus(barcodeFocusNodes);
        //print('딴거 눌렀으니 이동');
      } else {
        //print('정상클릭했음');
      }

      //barcodeFocusNodes.hasFocus == false ? FocusScope.of(context).requestFocus(barcodeFocusNodes) : '';
    });
  }

  Future<void> scanBarcode(String barcode) async {
    List<String> scanData = [];
    scanData = barcode.split('/');
    String detailDataString = '';
    //print(scanData);

    var dzRes = await SqlConn.writeData("exec SP_DZIF_PO_C '1001'");
    print('바코드 : $barcode');
    //print('더존 결과 : ${dzRes}');
    if (dzRes) {
      detailDataString = await SqlConn.readData(
          "SP_MOBILE_SCM_CHKECK_R '1001', '${scanData[0]}'");
      //print('asdsadasdasd : ${detailDataString.replaceAll('tsst', 'replace')}');
      List<dynamic> decodedData = jsonDecode(detailDataString);
      selectData = List<Map<String, dynamic>>.from(decodedData);

      List<Map<String, dynamic>> modifiedData = decodedData.map((item) {
        Map<String, dynamic> modifiedItem = {};
        item.forEach((key, value) {
          if (value is String) {
            modifiedItem[key] = value.replaceAll('tsst', '');
          } else {
            modifiedItem[key] = value;
          }
        });
        return modifiedItem;
      }).toList();

      detailData.value = modifiedData;
      await setTitleData(detailData[0]);
      print('psu_nb : $psuNb');
    }
  }

  Future<void> setFocus(BuildContext context) async {
    keyboardClick = false;
    FocusScope.of(context).requestFocus(barcodeFocusNodes);
  }

  Color setKeyboardColor() {
    return keyboardClick ? Colors.blue : Colors.grey.withOpacity(0.3);
  }
}
