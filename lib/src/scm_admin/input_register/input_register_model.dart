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
  List<Map<String, dynamic>> boxdata = [];
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
    psuSq = int.parse(map['PSU_SQ']);
    trNm = map['TR_NM'];
  }

//디테일박스 조회
  Future<void> boxData(String detailNumber, int superIndex) async {
    // scanData = barcode.split('/');
    String detailDataString = await SqlConn.readData(
        "SELECT ('TSST_'+A.PSU_NB)AS PSU_NB,('TSST_'+CONVERT(NVARCHAR,A.PSU_SQ))AS PSU_SQ,('TSST_'+CONVERT(NVARCHAR,A.BOX_SQ))AS BOX_SQ,('TSST_'+A.BOX_NO)AS BOX_NO,('TSST_'+A.ITEM_CD)AS ITEM_CD,('TSST_'+CONVERT(NVARCHAR,A.PACK_QT))AS PACK_QT,('TSST_'+A.BARCODE)AS BARCODE,('TSST_'+A.IMPORTSPEC)AS IMPORTSPEC FROM TSPODELIVER_D_BOX A  LEFT JOIN TSPODELIVER_D B ON A.PSU_NB = B.PSU_NB  AND A.PSU_SQ = B.PSU_SQ LEFT JOIN TSITEM        C ON C.CO_CD = A.CO_CD AND C.ITEM_CD  = B.ITEM_CD WHERE A.PSU_NB = '$detailNumber' AND A.PSU_SQ = '$superIndex' AND (A.BARCODE = CASE WHEN C.PU_FG = 1 THEN '1' ELSE NULL END OR C.PU_FG = 0)");

    String checkData = detailDataString.replaceAll('TSST_', '');
    List<dynamic> decodedData = jsonDecode(checkData);
    boxdata = List<Map<String, dynamic>>.from(decodedData);
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

//DB 디테일박스 업데이트
  Future<void> updatabox(String detailNumber, int superIndex, int box) async {
    bool update = await SqlConn.writeData(
        "UPDATE TSPODELIVER_D_BOX SET IMPORTSPEC = 'Y' WHERE PSU_NB ='$detailNumber' AND PSU_SQ ='$superIndex  'AND BOX_SQ ='$box' ");
    print('abcde:$update');
    // print('index:$superIndex');
  }

//BARCODE정리
  Future<void> updatespec(String detailNumber, int superIndex) async {
    bool updata = await SqlConn.writeData(
        "UPDATE TSPODELIVER_D_BOX SET BARCODE = null WHERE PSU_NB ='$detailNumber' AND PSU_SQ ='$superIndex' AND IMPORTSPEC is NULL");
    print('a:$updata');
  }

//입고처리 확인하기
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
    print("asdad : $scanData");
    String detailDataString = '';

    if (barcode.isEmpty) {
      return isuQtCheckDialog(context, '바코드가 입력되지 않았습니다.');
    }
    if (scanData[0].length != 12 || !scanData[0].startsWith('PD')) {
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

//인덱스 값이 1 이면 박스 업데이트
  Future<void> updateinfo(String detailNumber, int index) async {
    List<String> keys = selectCheckDataList.keys.toList();
    List<List<String>> values = selectCheckDataList.values.toList();

    for (int i = 0; i < keys.length; i++) {
      for (int j = 0; j < values[i].length; j++) {
        if (values[i][j] == '1') {
          await updatabox(detailNumber, int.parse(keys[i]),
              int.parse(boxdata[j]["BOX_SQ"]));

          // index i에서 values[i]의 j번째 요소가 '1'인 경우에 업데이트를 수행
        }
      }
    }
  }

//입고등록
  Future<void> regist(BuildContext context) async {
    for (int i = 0; i < barcodedata.length; i++) {
      var regist = await SqlConn.writeData(
          "exec  SP_MOBILE_DZSTOCK_C2 '1001', '${barcodedata[i]}'");
      if (regist) {
        isuQtCheckDialog(context, '입고등록이 완료되었습니다.');
      } else {}
    }
  }

//색깔
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
                    Get.back;
                  },
                  child: const Text('확인'))
            ],
          );
        });
  }
}
