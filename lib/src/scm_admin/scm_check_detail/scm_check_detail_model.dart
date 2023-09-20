import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sql_conn/sql_conn.dart';

class ScmCheckDetailModel {
  Rx<List<Map<String, dynamic>>> detailData =
      Rx<List<Map<String, dynamic>>>([]);
  List<Map<String, dynamic>> boxdata = [];
  List<Map<String, dynamic>> ckdata = [];
  var barcodeFocusNodes = FocusNode();
  var textFocusNodes = FocusNode();
  bool keyboardClick = false;
  List<String> scanData = [];
  bool same = false;
  TextEditingController txtCon = TextEditingController();
  TextEditingController txtCon2 = TextEditingController();

  List boxdata2 = [];

  Future<void> boxData(String detailNumber) async {
    // scanData = barcode.split('/');
    String detailDataString = await SqlConn.readData(
        "SELECT A.BOX_NO,A.ITEM_CD,A.PACK_QT,'' AS SCANYN FROM TSPODELIVER_D_BOX A  LEFT JOIN TSPODELIVER_D B ON A.PSU_NB = B.PSU_NB  WHERE A.PSU_NB = '$detailNumber'");

    List<dynamic> decodedData = jsonDecode(detailDataString);
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

  Future<void> check() async {
    List<String> barcode = txtCon2.text.split('|');
    Map<String, dynamic> bcData = {
      "BOX_NO": barcode[0],
      "ITEM_CD": barcode[1],
      "PACK_QT": barcode[2]
    };
    print(bcData);

    // for (var element in ckdata) {
    //   if (element["ITEM_CD"] == bcData["ITEM_CD"] &&
    //       element["BOX_NO"] == bcData["BOX_NO"] &&
    //       element["PACK_QT"] == bcData["PACK_QT"]) {
    //     break;
    //   }
    // }
    for (int i = 0; i < detailData.value.length; i++) {
      if (bcData["BOX_NO"] == boxdata[i]["BOX_NO"].toString() &&
          bcData["ITEM_CD"] == boxdata[i]["ITEM_CD"] &&
          bcData["PACK_QT"] == boxdata[i]["PACK_QT"].toString()) {
        // 1 : TURE , 0 : FALSE

        boxdata[i]["SCANYN"] = '1';
        print(boxdata[i]["SCANYN"]);
      } else {
        print('안들옴');
        boxdata[i]["SCANYN"] = '0';
      }
    }
    // if (same == true) {
    //   print('OK');
    //   print('ccc : ${boxdata[3]["SCANYN"]}');
    // } else {
    //   print('bbb : ${bcData["ITEM_CD"].runtimeType}');
    //   print('aaa : ${boxdata[1]["ITEM_CD"].toString().runtimeType}');
    //   print('ㅁㅁㅁㅁ : $same');
    //   print('ccc : ${boxdata[3]["SCANYN"]}');
    //   print('No');
    // }
  }

  Color getColor(int index) {
    if (boxdata[index]["SCANYN"] == '1') {
      return Colors.red;
    } else {
      return Colors.indigo;
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
