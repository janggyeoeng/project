import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sql_conn/sql_conn.dart';

class ScmCheckDetailModel {
  //ScmCheckModel model = ScmCheckModel();
  Rx<List<Map<String, dynamic>>> detailData =
      Rx<List<Map<String, dynamic>>>([]);
  List<Map<String, dynamic>> boxdata = [];
  List<Map<String, dynamic>> ckdata = [];
  var barcodeFocusNodes = FocusNode();
  var textFocusNodes = FocusNode();
  bool keyboardClick = false;
  List<String> scanData = [];
  bool a = false;
  bool same = false;
  bool same1 = false;

  TextEditingController txtCon = TextEditingController();
  TextEditingController txtCon2 = TextEditingController();

  Future<void> boxData(String detailNumber) async {
    // scanData = barcode.split('/');
    String detailDataString = await SqlConn.readData(
        "SELECT ('TSST_'+A.PSU_NB)AS PSU_NB,('TSST_'+A.BOX_NO)AS BOX_NO,('TSST_'+A.ITEM_CD)AS ITEM_CD,('TSST_'+CONVERT(NVARCHAR,A.PACK_QT))AS PACK_QT,'' AS SCANYN FROM TSPODELIVER_D_BOX A  LEFT JOIN TSPODELIVER_D B ON A.PSU_NB = B.PSU_NB  WHERE A.PSU_NB = '$detailNumber'");

    String checkData = detailDataString.replaceAll('TSST_', '');
    List<dynamic> decodedData = jsonDecode(checkData);
    boxdata = List<Map<String, dynamic>>.from(decodedData);
    detailData.value = boxdata;
  }

  TextEditingController gettxtCon() {
    return txtCon2;
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

  Future<void> checkNb(BuildContext context, String detailNumber) async {
    List<String> barcode = txtCon2.text.split('/');
    Map<String, dynamic> bcData = {"PSU_NB": barcode[0]};
    if (bcData["PSU_NB"] != detailNumber) {
      a = false;
    } else {
      a = true;
      same = false;
    }
  }

  Future<void> check(BuildContext context) async {
    List<String> barcode = txtCon2.text.split('/');
    Map<String, dynamic> bcData = {"PSU_NB": barcode[0], "BOX_NO": barcode[1]};
    for (int i = 0; i < detailData.value.length; i++) {
      if (a == true && bcData["BOX_NO"] == boxdata[i]["BOX_NO"]) {
        // 1 : TURE , 0 : FALSE
        boxdata[i]["SCANYN"] = '1';
        same = true;
      } else if (boxdata[i]["SCANYN"] == '1') {
        continue;
      } else {
        boxdata[i]["SCANYN"] = '0';
      }
    }
    if (a == false) {
      isuQtCheckDialog(context, '출고번호가 올바르지 않습니다.');
    } else if (a == true && same == false) {
      isuQtCheckDialog(context, '박스번호가 올바르지 않습니다.');
    }
  }

  Color getColor(int index) {
    if (boxdata[index]["SCANYN"] == '1') {
      return Colors.blue.shade300;
    } else {
      return Colors.grey.shade300;
    }
  }

  Future<void> setKeyboardClick(bool bo) async {
    keyboardClick = bo;
    //print('불값 : ${this.keyboardClick}');
  }

  Future<void> setFocus(BuildContext context) async {
    keyboardClick = false;
    FocusScope.of(context).requestFocus(barcodeFocusNodes);
  }

  Future<void> saveEnd(String detailNumber) async {
    // 화면 새로 그리지 말고 그냥 초기화 하고 setupdate 하자
    // getColor = [];
    // outcontroller = [];

    await boxData(detailNumber);
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
