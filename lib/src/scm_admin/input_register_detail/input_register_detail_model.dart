import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hnde_pda/src/scm_admin/input_register/input_register_controller.dart';
import 'package:hnde_pda/src/scm_admin/scm_check/scm_check_controller.dart';

import 'package:sql_conn/sql_conn.dart';

class ScmRegisterDetailModel {
  Rx<List<Map<String, dynamic>>> detailData =
      Rx<List<Map<String, dynamic>>>([]);
  List<Map<String, dynamic>> boxdata = [];
  List<Map<String, dynamic>> ckdata = [];
  var barcodeFocusNodes = FocusNode();
  var textFocusNodes = FocusNode();
  bool keyboardClick = false;
  List<String> scanData = [];
  bool psunb = false; //출고번호

  bool bccheck = false; //바코드 체크
  bool hdcheck = false; //헤더체크
  bool select = false; //datavalue 변경
  int sum = 0;

  String superKey = "";

  TextEditingController txtCon = TextEditingController();
  TextEditingController txtCon2 = TextEditingController();

  // 디테일박스 조회
  Future<void> boxData(String detailNumber,
      ScmRegisterController scmRegisterController, String superIndex) async {
    // scanData = barcode.split('/');
    String detailDataString = await SqlConn.readData(
        "SELECT ('TSST_'+A.PSU_NB)AS PSU_NB,('TSST_'+CONVERT(NVARCHAR,A.PSU_SQ))AS PSU_SQ,('TSST_'+A.BOX_NO)AS BOX_NO,('TSST_'+A.ITEM_CD)AS ITEM_CD,('TSST_'+CONVERT(NVARCHAR,A.PACK_QT))AS PACK_QT,('TSST_'+A.BARCODE)AS BARCODE,('TSST_'+A.IMPORTSPEC)AS IMPORTSPEC FROM TSPODELIVER_D_BOX A  LEFT JOIN TSPODELIVER_D B ON A.PSU_NB = B.PSU_NB  AND A.PSU_SQ = B.PSU_SQ LEFT JOIN TSITEM        C ON C.CO_CD = A.CO_CD AND C.ITEM_CD  = B.ITEM_CD WHERE A.PSU_NB = '$detailNumber' AND A.PSU_SQ = '$superIndex' AND (A.IMPORTSPEC = CASE WHEN C.PU_FG = 1 THEN 'Y' ELSE NULL END OR C.PU_FG = 0)");

    String checkData = detailDataString.replaceAll('TSST_', '');
    List<dynamic> decodedData = jsonDecode(checkData);

    superKey = superIndex.toString();
    scmRegisterController.model.selectCheckDataList[superIndex.toString()] = [];

    for (int i = 0; i < decodedData.length; i++) {
      scmRegisterController.model.selectCheckDataList[superIndex.toString()]!
          .add("0");
    }

    //print('asdqweasd : ${scmRegisterController.model.selectCheckDataList}');

    boxdata = List<Map<String, dynamic>>.from(decodedData);
    detailData.value = boxdata;
  }

  TextEditingController gettxtCon() {
    return txtCon2;
  }

  bool getselect() {
    return select;
  }

  FocusNode getTxtNode() {
    return textFocusNodes;
  }

  FocusNode getBcNode() {
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

  //맞는 인덱스의 박스 바코드 변경
  Future<void> updatedata(
      String detailNumber, int superIndex, String box) async {
    bool updata = await SqlConn.writeData(
        "UPDATE TSPODELIVER_D_BOX SET BARCODE = '1' WHERE PSU_NB ='$detailNumber' AND PSU_SQ ='${superIndex + 1}'AND BOX_NO =$box");
    print('a:$updata');
  }

  //바코드가 1인값들에 IMPORTSPEC에 Y 넣기
  Future<void> updatespec(String detailNumber, int superIndex) async {
    bool updata = await SqlConn.writeData(
        "UPDATE TSPODELIVER_D_BOX SET IMPORTSPEC = 'Y' WHERE PSU_NB ='$detailNumber' AND PSU_SQ ='${superIndex + 1}' AND BARCODE = '1'");
    print('a:$updata');
  }

  // 출고번호 체크
  Future<void> checkNb(String detailNumber) async {
    List<String> barcode = txtCon2.text.split('/');
    Map<String, dynamic> bcData = {"PSU_NB": barcode[0]};
    if (bcData["PSU_NB"] != detailNumber) {
      psunb = false;
    } else {
      psunb = true;
      bccheck = false;
    }
  }

  //바코드 체크
  Future<void> barcodecheck(
      BuildContext context,
      ScmRegisterController scmRegisterController,
      String detailNumber,
      int superIndex) async {
    List<String> barcode = txtCon2.text.split('/');
    if (txtCon2.text.isEmpty) {
      return isuQtCheckDialog(context, '바코드가 입력되지 않았습니다.');
    }
    Map<String, dynamic> bcData = {
      "PSU_NB": barcode[0],
      "PSU_SQ": barcode[1],
      "BOX_NO": barcode[2]
    };
    for (int i = 0; i < detailData.value.length; i++) {
      if (psunb == true &&
          bcData["PSU_SQ"] == boxdata[i]["PSU_SQ"] &&
          bcData["BOX_NO"] == boxdata[i]["BOX_NO"]) {
        //출고번호와 박스번호 비교
        // 1 : TURE , 0 : FALSE
        boxdata[i]["BARCODE"] = '1';
        scmRegisterController.model.selectCheckDataList[superKey]![i] =
            '1'; //체크리스트에 1넣기
        updatedata(detailNumber, superIndex, bcData["BOX_NO"]);
        updatespec(detailNumber, superIndex);
        bccheck = true;
      } else if (boxdata[i]["BARCODE"] == '1') {
        scmRegisterController.model.selectCheckDataList[superKey]![i] = '1';
        continue;
      } else {
        boxdata[i]["BARCODE"] = '0';
        scmRegisterController.model.selectCheckDataList[superKey]![i] = '0';
      }
    }
    if (psunb == false) {
      isuQtCheckDialog(context, '출고번호가 올바르지 않습니다.');
    } else if (psunb == true && bccheck == false) {
      isuQtCheckDialog(context, '박스번호가 올바르지 않습니다.');
    }

    print(scmRegisterController.model.selectCheckDataList);
  }

  Future<void> setSelectChk() async {
    //헤더박스 색깔변경위한 체크
    for (int i = 0; i < detailData.value.length; i++) {
      if (boxdata[i]["BARCODE"] == '1') {
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

  Future<void> plus() async {
    for (int i = 0; i < detailData.value.length; i++) {
      if (boxdata[i]['BARCODE'] == '1') {
        sum = sum + int.parse(boxdata[i]['PACK_QT']);
      } else {}
    }
  }

  Future<void> checkcount(String psu, String psusq,
      ScmRegisterController scmRegisterController) async {
    for (int i = 0; i < detailData.value.length; i++) {
      if (boxdata[i]['BARCODE'] == '1') {
        scmRegisterController.model.barcodedata
            .addNonNull("$psu${psusq.toString().padLeft(4, '0')}|$sum");
        break;
      } else {}
    }
  }

  Future<void> clearSpec(String detailNumber, int superIndex) async {
    var clearSp = await SqlConn.writeData(
        "UPDATE TSPODELIVER_D_BOX SET IMPORTSPEC = null WHERE PSU_NB = '$detailNumber' AND PSU_SQ = '${superIndex + 1}' AND BARCODE is NULL");
  }

  Color getColor(int index) {
    if (boxdata[index]["BARCODE"] == '1') {
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

  // Future<void> saveEnd(String detailNumber) async {
  //   // 화면 새로 그리지 말고 그냥 초기화 하고 setupdate 하자
  //   // getColor = [];
  //   // outcontroller = [];

  //   await boxData(detailNumber);
  // }

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
