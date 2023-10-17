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

  //각 인덱스마다 체크된 항목이 있는지 검사하는 리스트  1있으면 검사완료 아니면 팝업창 출력
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

  Future<void> clearcolor(String detailNumber, int superIndex) async {
    bool updata = await SqlConn.writeData(
        "UPDATE TSPODELIVER_D_BOX SET BARCODE = null WHERE PSU_NB ='$detailNumber' AND PSU_SQ ='${superIndex + 1}'");
    print('a:$updata');
  }

  // 바코드 스캔 영역
  Future<void> barcodeScan(String barcode, BuildContext context) async {
    List scanData = [];
    scanData = barcode.split('/');
    String detailDataString = '';
    // 수입검사가 이루어진 데이터 찾아내기
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
      //수입검사완료된 리스트 생성
      detailDataString = await SqlConn.readData(
          "exec SP_MOBILE_SCM_REGIST_R_D '1001', '${scanData[0]}'");
      String detailData = detailDataString.replaceAll('tsst', '');
      List<dynamic> decodedData = jsonDecode(detailData);
      selectData1 = List<Map<String, dynamic>>.from(decodedData);
      rsData.value = selectData1;
      await setTitleData(rsData[0]);
    } else {
      // 수입검사가 이루어진게 없을때
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
