import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sql_conn/sql_conn.dart';

class ScmCheckModel{

  var barcodeFocusNodes = FocusNode();
  var textFocusNodes = FocusNode();
  bool keyboardClick = false;
  List<Map<String, dynamic>> selectData = [];

  Future<void> pageLoad()async{

  }

  Future<void> setKeyboardClick(bool bo)async{
    this.keyboardClick = bo;
    //print('불값 : ${this.keyboardClick}');
  }

  FocusNode getTextNode(){
    return this.textFocusNodes;
  }

  FocusNode getBarcodeNode(){
    return this.barcodeFocusNodes;
  }
  
  dynamic textFocusListner(BuildContext context, void Function()? state){
    return textFocusNodes.addListener(() {
      print(textFocusNodes.hasFocus);
      if(textFocusNodes.hasFocus == false){
        this.keyboardClick = false;
        FocusScope.of(context).requestFocus(barcodeFocusNodes);
        state;
      }
      
    });
  }

  dynamic barcodeFocusListner(BuildContext context){
    return barcodeFocusNodes.addListener(() {
     // print('리스너가 먼저?');
      if(barcodeFocusNodes.hasFocus == false && this.keyboardClick == false){
        FocusScope.of(context).requestFocus(barcodeFocusNodes);
        //print('딴거 눌렀으니 이동');
      }else{
        //print('정상클릭했음');
      }


      //barcodeFocusNodes.hasFocus == false ? FocusScope.of(context).requestFocus(barcodeFocusNodes) : '';
    });
  }

  Future<void> scanBarcode(String barcode)async{
    
    List<String> scanData = [];
    scanData = barcode.split('/');
    String detailDataString = '';
    //print(scanData);

    var dzRes = await SqlConn.writeData(
        "exec SP_DZIF_PO_C '1001'");
        print('바코드 : ${barcode}');
        //print('더존 결과 : ${dzRes}');
    if(dzRes){
      // detailDataString = await SqlConn.readData("SP_TS1JA0009A_R1 '1001', '${scanData[0]}'");
      // List<dynamic> decodedData = jsonDecode(detailDataString);
      // this.selectData = List<Map<String, dynamic>>.from(decodedData);
      // print('조회결과 : ${this.selectData}');
    }
    
  }

  Future<void>setFocus(BuildContext context)async{
    this.keyboardClick = false;
    FocusScope.of(context).requestFocus(this.barcodeFocusNodes);
  }

  Color setKeyboardColor(){
    return this.keyboardClick ? Colors.blue : Colors.grey.withOpacity(0.3);
  }
    
}