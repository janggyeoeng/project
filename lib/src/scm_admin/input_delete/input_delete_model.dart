import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sql_conn/sql_conn.dart';

class ScmDeleteModel {
  Rx<DateTime> selectedStartDate = Rx<DateTime>(DateTime.now());
  Rx<DateTime> selectedEndDate = Rx<DateTime>(DateTime.now());
  RxList<Map<String, dynamic>> deletedata = RxList<Map<String, dynamic>>([]);
  TextEditingController cscontroller = TextEditingController();
  List<bool> setColor = [];
  String psuNb = '';
  int psuSq = 0;
  String rcvNb = '';
  int rcvSq = 0;
  bool abc = false;

  Future<void> pageLoad() async {
    await inputdata();
    await setController();
  }

  Future<Map<String, dynamic>> getBindMapData(int index) async {
    return deletedata[index];
  }

  Future<void> setTitleData(Map<String, dynamic> map) async {
    psuNb = map['PSU_NB'];
    psuSq = map['PSU_SQ'];
    rcvNb = map['RCV_NB'];
    rcvSq = map['RCV_SQ'];
  }

  String getPsuNb() {
    return psuNb;
  }

  int getPsuSq() {
    return psuSq;
  }

  String getRcvNb() {
    return rcvNb;
  }

  int getRcvSq() {
    return rcvSq;
  }

  Future<void> colorck(int index) async {
    if (setColor[index] == false) {
      setColor[index] = true;
    } else if (setColor[index] == true) {
      setColor[index] = false;
    }
  }

  Future<void> setController() async {
    for (int i = 0; i < deletedata.length; i++) {
      setColor.add(false);
    }
  }

  Future<DateTimeRange?> selectDateRange(
      BuildContext context, DateTimeRange selectedDateRange) async {
    return await showDateRangePicker(
      context: context,
      initialDateRange: selectedDateRange,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
  }

  final _selectedDateRange = DateTimeRange(
    start: DateTime.now(),
    end: DateTime.now().add(const Duration(days: 2)),
  ).obs;

  DateTimeRange get selectedDateRange => _selectedDateRange.value;

  Future<void> selectDate(BuildContext context) async {
    DateTimeRange? pickedDateRange =
        await selectDateRange(context, _selectedDateRange.value);
    if (pickedDateRange != null &&
        pickedDateRange != _selectedDateRange.value) {
      _selectedDateRange.value = pickedDateRange;
    }
  }

  Future<void> inputdata() async {
    String customerKeyword = cscontroller.text;
    await deleteData(
      customerKeyword,
      selectedDateRange.start,
      selectedDateRange.end,
    );
  }

  Future<void> deleteData(
      String customerKeyword, DateTime startDate, DateTime endDate) async {
    String data = await SqlConn.readData(
        "exec SP_SCM_TS1JA0008A_R1_BAK '1001','$customerKeyword', 'B', '$startDate', '$endDate'");
    String detailData = data.replaceAll('tsst', '');
    List<Map<String, dynamic>> decodedData =
        List<Map<String, dynamic>>.from(jsonDecode(detailData));
    deletedata.assignAll(decodedData);
    await setTitleData(deletedata[0]);
  }

  Future<void> delete(String psunb, int psusq, String rcvnb, int rcvsq) async {
    bool deleteinfo = await SqlConn.writeData(
        "UPDATE TSPODELIVER_D SET RCV_NB = null ,RCV_SQ = 0,  RCV_QT = 0   WHERE CO_CD  = '1001'AND PSU_NB = '$psunb'AND PSU_SQ = '$psusq' UPDATE TSPODELIVER_D_BOX SET IMPORTSPEC = null,BARCODE = null WHERE PSU_NB='$psunb'AND PSU_SQ='$psusq'  DELETE FROM DZICUBE.dbo.LSTOCK_D WHERE CO_CD  = '1001'AND RCV_NB ='$rcvnb'AND RCV_SQ = $rcvsq");
  }

  Future<void> checkdelete(
      String psunb, int psusq, String rcvnb, int rcvsq) async {
    if (abc == true) {
      delete(psunb, psusq, rcvnb, rcvsq);
      print('돼따.');
    }
  }

  Color selectColor(int index) {
    if (setColor[index] == true) {
      abc = true;
      return Colors.blue.shade300;
    }
    abc = false;
    return Colors.grey.shade300;
  }
}
