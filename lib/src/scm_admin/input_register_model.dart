import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sql_conn/sql_conn.dart';

class ScmRegisterModel {
  RxList<Map<String, dynamic>> rsData = RxList<Map<String, dynamic>>([]);
  List<Map<String, dynamic>> selectData = [];
  String psuNb = '';
  String trNm = '';

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

  Future<void> barcodeScan(String barcode) async {
    List scanData = [];
    scanData = barcode.split('/');
    String detailDataString = '';

    detailDataString = await SqlConn.readData(
        "exec SP_MOBILE_SCM_REGIST_R '1001', '${scanData[0]}'");
    String detailData = detailDataString.replaceAll('tsst', '');
    List<dynamic> decodedData = jsonDecode(detailData);
    selectData = List<Map<String, dynamic>>.from(decodedData);
    rsData.value = selectData;

    await setTitleData(rsData[0]);
  }
}
