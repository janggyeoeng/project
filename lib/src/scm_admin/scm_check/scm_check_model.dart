import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sql_conn/sql_conn.dart';

class ScmCheckModel {
  var barcodeFocusNodes = FocusNode();
  var textFocusNodes = FocusNode();
  bool keyboardClick = false;
  List<Map<String, dynamic>> selectData = []; // 조회데이터 리스트
  List<Map<String, dynamic>> speccheckData = []; //IMPORTSPEC 리스트
  RxList<Map<String, dynamic>> detailData = RxList<Map<String, dynamic>>([]);

  List<Map<String, dynamic>> boxdata = [];

  List<bool> datavalue = [];
  List<String> sum = [];

  bool specTF = false; //IMPORTSPEC 체크

  Map<String, List<String>> selectCheckDataList = {};
  int psuSq = 0;
  String psuNb = '';
  String trNm = '';
  String boxnb = '';
  //String sum = '';
  bool check = false;

  Future<void> pageLoad() async {}

  Future<Map<String, dynamic>> getBindMapData(int index) async {
    return detailData[index];
  }

  Future<Map<String, dynamic>> getBindMapData2(int index) async {
    return boxdata[index];
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

  int sqindex() {
    for (int i = 0; i < detailData.length; i++) {
      detailData[i]["PSU_SQ"];
    }
    return 0;
  }

  Future<void> setTitleData(Map<String, dynamic> map) async {
    psuNb = map['PSU_NB'];
    psuSq = int.parse(map['PSU_SQ']);
    trNm = map['TR_NM'];
    //boxnb = map["BOX_NO"];
  }

//디테일 박스 조회
  Future<void> boxData(String detailNumber, int superIndex) async {
    // scanData = barcode.split('/');
    String detailDataString = await SqlConn.readData(
        "SELECT ('TSST_'+A.PSU_NB)AS PSU_NB,('TSST_'+CONVERT(NVARCHAR,A.PSU_SQ))AS PSU_SQ,('TSST_'+CONVERT(NVARCHAR,A.BOX_SQ))AS BOX_SQ,('TSST_'+A.BOX_NO)AS BOX_NO,('TSST_'+A.ITEM_CD)AS ITEM_CD,('TSST_'+CONVERT(NVARCHAR,A.PACK_QT))AS PACK_QT,('TSST_'+A.BARCODE)AS BARCODE,('TSST_'+A.IMPORTSPEC)AS IMPORTSPEC FROM TSPODELIVER_D_BOX A  LEFT JOIN TSPODELIVER_D B ON A.PSU_NB = B.PSU_NB  AND A.PSU_SQ = B.PSU_SQ WHERE A.PSU_NB = '$detailNumber' ");

    String checkData = detailDataString.replaceAll('TSST_', '');
    List<dynamic> decodedData = jsonDecode(checkData);
    boxdata = List<Map<String, dynamic>>.from(decodedData);
  }

// bool값들 생성
  Future<void> setController() async {
    for (int i = 0; i < detailData.length; i++) {
      datavalue.add(false);
      sum.add('0');
    }
  }

//선택된항목있는지 체크
  Future<void> checkspec(String detailNumber, int index) async {
    List<List<String>> values = selectCheckDataList.values.toList();
    for (int i = 0; i < values.length; i++) {
      if (values[i].contains('1')) {
        await updatedata(detailNumber, i);
      }
    }
  }

  //선택된게 하나라도있으면 TSIMPORTSPEC을 Y로 변경
  Future<void> updatedata(String detailNumber, int index) async {
    await SqlConn.writeData(
        "UPDATE TSIMPORTINSPEC SET IMPORTSPEC = CASE WHEN (SELECT COUNT(BARCODE) FROM TSPODELIVER_D_BOX WHERE PSU_NB = '$detailNumber' AND PSU_SQ ='${index + 1} ' ) > 0 THEN 'Y' ELSE NULL END , INSERT_DT = GETDATE(),INSERT_BY=(SELECT USER_ID FROM TSUSER WHERE ISUSER_POWER = 'P') WHERE PSU_NB = '$detailNumber' AND PSU_SQ ='${index + 1} '");
    print(index);
  }

  //맞는 인덱스의 박스 바코드 변경
  Future<void> updatabox(String detailNumber, int superIndex, int box) async {
    bool update = await SqlConn.writeData(
        "UPDATE TSPODELIVER_D_BOX SET BARCODE = '1' WHERE PSU_NB ='$detailNumber' AND PSU_SQ ='$superIndex  'AND BOX_SQ ='$box' ");
    print('abcde:$update');
    // print('index:$superIndex');
  }

  //SPEC =Y인지 체크(이미 검사된 데이터인지 확인)
  Future<void> specCheck(String detailNumber) async {
    String spec = await SqlConn.readData(
        "SELECT ('tsst'+IMPORTSPEC) AS IMPORTSPEC FROM TSIMPORTINSPEC WHERE PSU_NB = '$detailNumber'");
    String specData = spec.replaceAll('tsst', '');
    List<dynamic> decodedspec = jsonDecode(specData);
    speccheckData = List<Map<String, dynamic>>.from(decodedspec);

    print(speccheckData);
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

  //선택한 박스가 하나라도 있으면 수입검사로 넘어감
  Future<void> checkList(
      BuildContext context, String detailNumber, int index) async {
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
      isuQtCheckDialog(context, '검사가 완료되었습니다.');
      print("a:${selectCheckDataList.values}");
    } else {
      isuQtCheckDialog(context, '검사 목록이 없습니다.');
      print("bb:${selectCheckDataList.values}");
    }

    // if (selectCheckDataList.values.toList()[i][i] == '1' &&
    //     selectCheckDataList.values.toList()[i][i] == '0') {

    //   print('a:${selectCheckDataList.values.toList()[i]}');
    //   break;
    // } else if (selectCheckDataList.values.toList()[i][i] == '0') {
    //   check = false;
    // }
  }

//수량변경
  String psuQt(int index) {
    if (datavalue[index] == false) {
      return detailData[index]["PSU_QT"];
    } else {
      return sum[index];
    }
  }

//바코드 스캔
  Future<void> scanBarcode(BuildContext context, String barcode) async {
    List<String> scanData = [];
    scanData = barcode.split('/');
    String detailDataString = '';
    print('scanData : $scanData');

    if (barcode.isEmpty) {
      return isuQtCheckDialog(context, '바코드가 입력되지 않았습니다.');
    }
    if (barcode.length != 12 || !barcode.startsWith('PD')) {
      isuQtCheckDialog(context, '바코드가 올바르지 않습니다.');
    } else {
      // if (detailData[0]["PSU_NB"] != scanData[0]) {
      //   isuQtCheckDialog(context, '출고번호가 올바르지 않습니다.');
      // }

      for (int i = 0; i < speccheckData.length; i++) {
        if (speccheckData[i]["IMPORTSPEC"] == 'Y') {
          specTF = true;
          break;
        } else {
          specTF = false;
        }
      }
      if (specTF == true) {
        isuQtCheckDialog(context, '이미 검사가 완료된 항목입니다.');
      }
      if (specTF == false) {
        //수입체크가 안됐을때 실행
        var dzRes = await SqlConn.writeData("exec SP_DZIF_PO_C '1001'");
        //print('바코드 :$barcode');
        //print('더존 결과 : $dzRes');
        if (dzRes) {
          detailDataString = await SqlConn.readData(
              "SP_MOBILE_SCM_CHKECK_R_BAK '1001', '${scanData[0]}'");
          //print('mes 결과 : $detailDataString');

          String checkData = detailDataString.replaceAll('tsst', '');
          List<dynamic> decodedData = jsonDecode(checkData);

          if (decodedData.isNotEmpty) {
            selectData = List<Map<String, dynamic>>.from(decodedData);
            detailData.value = selectData;

            datavalue.add(false); // 색깔변하기위한 조건 false = 회색 , true = 파랑

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
          } else {
            isuQtCheckDialog(context, '수입검사 목록이 없습니다.');
          }
        }
      }
    }
  }

//인덱스에 맞는 박스 DB업데이트
  Future<void> updateinfo(String detailNumber, int index) async {
    List<String> keys = selectCheckDataList.keys.toList();
    List<List<String>> values = selectCheckDataList.values.toList();

    for (int i = 0; i < keys.length; i++) {
      for (int j = 0; j < values[i].length; j++) {
        if (values[i][j] == '1') {
          await updatabox(detailNumber, int.parse(keys[i]) + 1,
              int.parse(boxdata[j]["BOX_SQ"]));
          // index i에서 values[i]의 j번째 요소가 '1'인 경우에 업데이트를 수행
        }
      }
    }

    // for (int i = 0; i < values.length; i++) {
    //   if (values[i].contains('1')) {
    //     await updatabox(detailNumber, int.parse(boxdata[i]["PSU_SQ"]),
    //         int.parse(boxdata[i]["BOX_NO"]));
    //     print("abcdefg:${values[i][i]}");
    //     print("abc:${boxdata[i]["BOX_NO"]}");
    //     print("dddddddddddddddddaaaa:${values[i][i]}");
    //   } else {
    //     print("ccccccccccccccc:${keys[i]}");
    //     print("dddddddddddddddddaaaa:${values[i][i]}");
    //     //print("bbbbbbbbb:${keys[i]}:${values[i]}");
    //   }
    // }
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
