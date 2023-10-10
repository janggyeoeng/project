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
  List<bool> datavalue = [];

  Map<String, List<String>> selectCheckDataList = {};

  String psuNb = '';
  String trNm = '';
  bool check = false;

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

  Future<void> cleardata(String detailNumber) async {
    for (int i = 0; i < datavalue.length; i++) {
      datavalue[i] = false;
    }
    await SqlConn.writeData(
        "UPDATE TSPODELIVER_D_BOX SET BARCODE =null,IMPORTSPEC =null WHERE PSU_NB ='$detailNumber'");
  }

  Future<void> setController() async {
    for (int i = 1; i < detailData.length; i++) {
      datavalue.add(false);
    }
  }

  Future<void> updatedata(String detailNumber) async {
    await SqlConn.writeData(
        "UPDATE TSIMPORTINSPEC SET IMPORTSPEC = CASE WHEN (SELECT COUNT(IMPORTSPEC) FROM TSPODELIVER_D_BOX WHERE PSU_NB = '$detailNumber') > 0 THEN 'Y' ELSE NULL END WHERE PSU_NB = '$detailNumber'");
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

  Future<void> checkList(BuildContext context) async {
    for (var key in selectCheckDataList.keys) {
      List<String>? values = selectCheckDataList[key];
      if (values != null && values.contains('1')) {
        check = true;
        break;
      } else {
        check = false;
      }
    }
    if (check == true) {
      print('검사완료');
    } else {
      isuQtCheckDialog(context, '검사 목록이 없습니다.');
    }

    // if (selectCheckDataList.values.toList()[i][i] == '1' &&
    //     selectCheckDataList.values.toList()[i][i] == '0') {

    //   print('a:${selectCheckDataList.values.toList()[i]}');
    //   break;
    // } else if (selectCheckDataList.values.toList()[i][i] == '0') {
    //   check = false;
    // }
  }

  Future<void> scanBarcode(BuildContext context, String barcode) async {
    List<String> scanData = [];
    scanData = barcode.split('/');
    String detailDataString = '';
    print('scanData : $scanData');

    if (barcode.isEmpty) {
      return isuQtCheckDialog(context, '바코드가 입력되지 않았습니다.');
    }

    var dzRes = await SqlConn.writeData("exec SP_DZIF_PO_C '1001'");
    //print('바코드 :$barcode');
    //print('더존 결과 : $dzRes');
    if (dzRes) {
      detailDataString = await SqlConn.readData(
          "SP_MOBILE_SCM_CHKECK_R '1001', '${scanData[0]}'");
      //print('mes 결과 : $detailDataString');
      String checkData = detailDataString.replaceAll('tsst', '');
      List<dynamic> decodedData = jsonDecode(checkData);
      selectData = List<Map<String, dynamic>>.from(decodedData);
      detailData.value = selectData;
      datavalue.add(false);

      // List<Map<String, dynamic>> modifiedData = decodedData.map((item) {
      //   Map<String, dynamic> modifiedItem = {};
      //   item.forEach((key, value) {
      //     if (value is String) {
      //       modifiedItem[key] = value.replaceAll('tsst', '');
      //     } else {
      //       modifiedItem[key] = value;
      //     }
      //   });
      //   return modifiedItem;
      // }).toList();

      // detailData.value = modifiedData;

      await setTitleData(detailData[0]);
    }
  }

  Future<void> setFocus(BuildContext context) async {
    keyboardClick = false;
    FocusScope.of(context).requestFocus(barcodeFocusNodes);
  }

  Color setKeyboardColor() {
    return keyboardClick ? Colors.blue : Colors.grey.withOpacity(0.3);
  }

  Future<void> backKey(BuildContext context) async {
    return FocusScope.of(context).requestFocus(barcodeFocusNodes);
    // await showDialog(
    //     context: context,
    //     builder: (BuildContext context) {
    //       return AlertDialog(
    //         backgroundColor: Colors.white,
    //         title: const Text('끝내시겠습니까?'),
    //         actions: [
    //           TextButton(
    //               onPressed: () {
    //                 Navigator.pop(context, true);
    //               },
    //               child: const Text('끝내기')),
    //           TextButton(
    //               onPressed: () {
    //                 Navigator.pop(context, false);
    //               },
    //               child: const Text('아니요'))
    //         ],
    //       );
    //     });
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
