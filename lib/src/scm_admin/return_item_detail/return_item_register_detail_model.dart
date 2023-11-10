import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hnde_pda/src/scm_admin/return_item/return_item_register_controller.dart';
import 'package:sql_conn/sql_conn.dart';

class ReturnRegisterDetailModel {
  var barcodeFocusNodes = FocusNode();
  var textFocusNodes = FocusNode();
  bool keyboardClick = false;
  Rx<List<Map<String, dynamic>>> detailData =
      Rx<List<Map<String, dynamic>>>([]);
  List<Map<String, dynamic>> boxdata = [];
  bool psunb = false; //출고번호
  bool bccheck = false; //바코드 체크
  bool hdcheck = false; //헤더체크
  bool select = false;
  String psuNb = '';
  int psuSq = 0;
  String trNm = '';
  String superKey = "";
  int sum = 0;

  TextEditingController txtCon = TextEditingController();

  Future<Map<String, dynamic>> getBindMapData(int index) async {
    return detailData.value[index];
  }

  Future<void> setTitleData(Map<String, dynamic> map) async {
    psuNb = map['PSU_NB'];
    psuSq = int.parse(map['PSU_SQ']);
  }

  String getPsuNb() {
    return psuNb;
  }

  String getTrNm() {
    return trNm;
  }

  FocusNode getTxtNode() {
    return textFocusNodes;
  }

  FocusNode getBcNode() {
    return barcodeFocusNodes;
  }

  Future<void> boxData(
      String detailNumber,
      ReturnRegisterController returnRegisterController,
      String superIndex,
      BuildContext context) async {
    // scanData = barcode.split('/');
    String detailDataString = await SqlConn.readData(
        "SELECT ('TSST_'+A.PSU_NB)AS PSU_NB,('TSST_'+CONVERT(NVARCHAR,A.PSU_SQ))AS PSU_SQ,('TSST_'+CONVERT(NVARCHAR,A.BOX_SQ))AS BOX_SQ,('TSST_'+A.BOX_NO)AS BOX_NO,('TSST_'+A.BOX_NO)AS BOX_NO,('TSST_'+A.ITEM_CD)AS ITEM_CD,('TSST_'+CONVERT(NVARCHAR,A.PACK_QT))AS PACK_QT,('TSST_'+A.BARCODE)AS BARCODE,('TSST_'+A.IMPORTSPEC)AS IMPORTSPEC FROM TSPODELIVER_D_BOX A  LEFT JOIN TSPODELIVER_D B ON A.PSU_NB = B.PSU_NB  AND A.PSU_SQ = B.PSU_SQ LEFT JOIN TSITEM        C ON C.CO_CD = A.CO_CD AND C.ITEM_CD  = B.ITEM_CD WHERE A.PSU_NB = '$detailNumber' AND A.PSU_SQ = '$superIndex' AND IMPORTSPEC is NULL ");

    String checkData = detailDataString.replaceAll('TSST_', '');
    List<dynamic> decodedData = jsonDecode(checkData);

    superKey = superIndex.toString();
    returnRegisterController.model.selectCheckDataList[superIndex.toString()] =
        [];

    for (int i = 0; i < decodedData.length; i++) {
      returnRegisterController.model.selectCheckDataList[superIndex.toString()]!
          .add("0");
    }
    boxdata = List<Map<String, dynamic>>.from(decodedData);
    //print('asdqweasd : ${scmRegisterController.model.selectCheckDataList}');
    if (boxdata.isEmpty) {
      isuQtCheckDialog(context, '목록이 없습니다.');
    } else {
      detailData.value = boxdata;
      await setTitleData(boxdata[0]);
    }
  }

  Future<void> checkNb(String detailNumber) async {
    List<String> barcode = txtCon.text.split('@');
    print("asdasdd : ${txtCon.text}");
    Map<String, dynamic> bcData = {"PSU_NB": barcode[0]};
    if (bcData["PSU_NB"] != detailNumber) {
      psunb = false;
    } else {
      psunb = true;
      bccheck = false;
    }
  }

  Future<void> barcodecheck(
      BuildContext context,
      ReturnRegisterController returnRegisterController,
      String detailNumber,
      int superIndex) async {
    List<String> barcode = txtCon.text.split('@');
    if (txtCon.text.isEmpty) {
      return isuQtCheckDialog(context, '바코드가 입력되지 않았습니다.');
    }
    Map<String, dynamic> bcData = {
      "PSU_NB": barcode[0],
      "PSU_SQ": barcode[1],
      "BOX_NO": barcode[2]
    };
    for (int i = 0; i < detailData.value.length; i++) {
      // print("asdada : $bcData, $boxdata");
      if (psunb == true &&
          bcData["PSU_SQ"] == boxdata[i]["PSU_SQ"] &&
          bcData["BOX_NO"] == boxdata[i]["BOX_NO"]) {
        //출고번호와 박스번호 비교
        // 1 : TURE , 0 : FALSE
        boxdata[i]["IMPORTSPEC"] = 'Y';
        returnRegisterController.model.selectCheckDataList[superKey]![i] =
            '1'; //체크리스트에 1넣기
        //await updatedata(detailNumber, superIndex, bcData["BOX_NO"]);
        //updatespec(detailNumber, superIndex);
        bccheck = true;
      } else if (boxdata[i]["IMPORTSPEC"] == 'Y') {
        returnRegisterController.model.selectCheckDataList[superKey]![i] = '1';

        continue;
      } else {
        boxdata[i]["IMPORTSPEC"] = null;
        returnRegisterController.model.selectCheckDataList[superKey]![i] = '0';
      }
    }
    if (psunb == false) {
      isuQtCheckDialog(context, '출고번호가 올바르지 않습니다.');
    } else if (psunb == true && bccheck == false) {
      isuQtCheckDialog(context, '박스번호가 올바르지 않습니다.');
    }

    print(returnRegisterController.model.selectCheckDataList);
  }

  Future<void> plus() async {
    for (int i = 0; i < detailData.value.length; i++) {
      if (boxdata[i]['IMPORTSPEC'] == 'Y') {
        sum = sum + int.parse(boxdata[i]['PACK_QT']);
      } else {}
    }
  }

  Future<void> setSelectChk() async {
    //헤더박스 색깔변경위한 체크
    for (int i = 0; i < detailData.value.length; i++) {
      if (boxdata[i]["IMPORTSPEC"] == 'Y') {
        hdcheck = true;
        break;
      } else {
        print('no');
      }
    }
    if (hdcheck == true) {
      select = true;
    }
  }

  Future<void> checkcount(String psu, String psusq,
      ReturnRegisterController returnRegisterController) async {
    for (int i = 0; i < detailData.value.length; i++) {
      if (returnRegisterController.model.selectCheckDataList[superKey]![i] ==
          '1') {
        returnRegisterController.model.barcodedata
            .addNonNull("$psu${psusq.toString().padLeft(4, '0')}|$sum");
        print(returnRegisterController.model.barcodedata);
        break;
      } else {}
    }
  }

  Color getColor(int index, ReturnRegisterController returnRegisterController) {
    if (returnRegisterController.model.selectCheckDataList[superKey]![index] ==
        '1') {
      return Colors.blue.shade300;
    } else {
      return Colors.grey.shade300;
    }
  }

  Future<void> setKeyboardClick(bool bo) async {
    keyboardClick = bo;
    //print('불값 : ${this.keyboardClick}');
  }

  Color setKeyboardColor() {
    return keyboardClick ? Colors.blue : Colors.grey.withOpacity(0.3);
  }

  Future<void> setFocus(BuildContext context) async {
    keyboardClick = false;
    FocusScope.of(context).requestFocus(barcodeFocusNodes);
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

  Widget detailcontainar(String text, TextStyle style, Color color) {
    return Container(
      height: 66,
      width: 99.7,
      decoration: BoxDecoration(
        color: color,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(1),
          ),
        ],
      ),
      child: Center(
          child: Text(
        text,
        style: style,
        textAlign: TextAlign.center,
      )),
    );
  }
}
