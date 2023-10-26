import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hnde_pda/src/scm_admin/scm_check/scm_check_controller.dart';
import 'package:sql_conn/sql_conn.dart';

class ScmRegisterModel {
  ScmCheckController controller1 = ScmCheckController();
  var barcodeFocusNodes = FocusNode();
  var textFocusNodes = FocusNode();
  RxList<Map<String, dynamic>> rsData = RxList<Map<String, dynamic>>([]);
  List<Map<String, dynamic>> selectData1 = [];
  List<Map<String, dynamic>> selectData = [];
  List<String> barcodedata = [];
  String psuNb = '';
  int psuSq = 0;
  String trNm = '';
  bool check = false;
  List<bool> datavalue = [];
  List<String> sum = [];
  Map<String, List<String>> selectCheckDataList = {};

  Future<void> setController() async {
    for (int i = 0; i < rsData.length; i++) {
      datavalue.add(false);
      sum.add('0');
    }
  }

  Future<Map<String, dynamic>> getBindMapData(int index) async {
    return selectData1[index];
  }

  String getPsuNb() {
    return psuNb;
  }

  int getPsuSq() {
    return psuSq;
  }

  String getTrNm() {
    return trNm;
  }

  String psuQt(int index) {
    if (datavalue[index] == false) {
      return rsData[index]["PSU_QT"];
    } else {
      return sum[index];
    }
  }

  Future<void> setTitleData(Map<String, dynamic> map) async {
    psuNb = map['PSU_NB'];
    psuSq = map['PSU_SQ'];
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

  Future<void> updatespec(String detailNumber, int superIndex) async {
    bool updata = await SqlConn.writeData(
        "UPDATE TSPODELIVER_D_BOX SET IMPORTSPEC = 'Y' WHERE PSU_NB ='$detailNumber' AND PSU_SQ ='${superIndex + 1}' AND BARCODE = '1'");
    print('a:$updata');
  }

  Future<void> clearcolor(String detailNumber, String superIndex) async {
    bool updatecolor = await SqlConn.writeData(
        "UPDATE TSPODELIVER_D_BOX SET BARCODE = null WHERE PSU_NB ='$detailNumber' AND PSU_SQ ='$superIndex '");
    print('a:$updatecolor');
  }

  Future<void> rcvCk(BuildContext context) async {
    String rcv =
        await SqlConn.readData("SELECT RCV_NB FROM DZICUBE.dbo.LSTOCK");
    List<dynamic> rcvdata = jsonDecode(rcv);
    print(rcvdata);

    for (var rsItem in rsData) {
      for (var rcvItem in rcvdata) {
        if (rcvItem["RCV_NB"] == rsItem["RCV_NB"]) {
          isuQtCheckDialog(context, '이미 처리된 입고입니다.');
          break;
        }
      }
    }
  }

  // 바코드 스캔 영역
  Future<void> barcodeScan(String barcode, BuildContext context) async {
    List scanData = [];
    scanData = barcode.split('/');
    String detailDataString = '';

    if (barcode.isEmpty) {
      return isuQtCheckDialog(context, '바코드가 입력되지 않았습니다.');
    }
    if (barcode.length != 12 || !barcode.startsWith('PD')) {
      isuQtCheckDialog(context, '바코드가 올바르지 않습니다.');
    } else {
      // 수입검사가 이루어진 데이터 찾아내기
      String count = await SqlConn.readData(
          "SELECT COUNT(IMPORTSPEC) AS NUMBER FROM TSIMPORTINSPEC WHERE PSU_NB = '${scanData[0]}'");
      List<dynamic> decodedData = jsonDecode(count);
      selectData = List<Map<String, dynamic>>.from(decodedData);
      for (int i = 0; i < selectData.length; i++) {
        if (selectData[i]["NUMBER"] >= 0) {
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
        if (decodedData.isNotEmpty) {
          selectData1 = List<Map<String, dynamic>>.from(decodedData);
          rsData.value = selectData1;
          await setTitleData(rsData[0]);
        } else {
          // 수입검사가 이루어진게 없을때
          isuQtCheckDialog(context, '수입검사가 이루어지지않았습니다.');
        }
      }
    }
  }

  Future<void> regist(BuildContext context) async {
    for (int i = 0; i < barcodedata.length; i++) {
      var regist = await SqlConn.writeData(
          "exec  SP_MOBILE_DZSTOCK_C2 '1001', '${barcodedata[i]}'");
      if (regist) {
        isuQtCheckDialog(context, '수입검사가 완료되었습니다.');
      } else {}
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

  void isuQtCheckDialog2(BuildContext context, String errorMessage) {
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
                    Get.back();
                  },
                  child: const Text('확인'))
            ],
          );
        });
  }
}
