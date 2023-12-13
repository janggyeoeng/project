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
  List<dynamic> usedata = [];
  String psuNb = '';
  int psuSq = 0;
  String rcvNb = '';
  int rcvSq = 0;
  bool deleteck = false;

  Future<void> pageLoad(BuildContext context) async {
    await inputdata(context);

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

//색깔바꾸기
  Future<void> colorck(int index) async {
    if (setColor[index] == false) {
      setColor[index] = true;
    } else if (setColor[index] == true) {
      setColor[index] = false;
    }
  }

//컬러 bool 생성
  Future<void> setController() async {
    for (int i = 0; i < deletedata.length; i++) {
      setColor.add(false);
    }
    await boxdata();
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

//날짜랑 키워드에따른 정보가져오기
  Future<void> inputdata(BuildContext context) async {
    String customerKeyword = cscontroller.text;
    await deleteData(customerKeyword, selectedDateRange.start,
        selectedDateRange.end, context);
  }

//제거 데이터 목록 조회
  Future<void> deleteData(String customerKeyword, DateTime startDate,
      DateTime endDate, BuildContext context) async {
    print("test005 : $customerKeyword, $startDate, $endDate");
    String data = await SqlConn.readData(
        "exec SP_SCM_TS1JA0008A_R1_BAK '1001','$customerKeyword', 'B', '$startDate', '$endDate'");

    String detailData = data.replaceAll('tsst', '');
    print(detailData);
    List<Map<String, dynamic>> decodedData =
        List<Map<String, dynamic>>.from(jsonDecode(detailData));
    if (decodedData.isEmpty) {
      isuQtCheckDialog(context, '목록이 없습니다.');
    } else {
      deletedata.assignAll(decodedData);
      await setTitleData(deletedata[0]);
    }
  }

  Future<void> boxdata() async {
    String data2 = await SqlConn.readData(
        "SELECT USE_YN FROM TSPODELIVER_D_BOX WHERE PSU_NB = '$psuNb' AND PSU_SQ = '$psuSq'");
    usedata = jsonDecode(data2);
    print('abcde:$usedata');
  }

  Future<bool> ynck() async {
    for (int i = 0; i < usedata.length; i++) {
      if (usedata[i]["USE_YN"] == 'Y') {
        return false;
      }
    }
    print('hello');
    return true;
  }

//삭제하기
  Future<void> delete(String psunb, int psusq, String rcvnb, int rcvsq) async {
    bool deleteinfo = await SqlConn.writeData(
        //"UPDATE TSPODELIVER_D SET RCV_NB = null ,RCV_SQ = 0,  RCV_QT = 0   WHERE CO_CD  = '1001'AND PSU_NB = '$psunb'AND PSU_SQ = '$psusq' UPDATE TSPODELIVER_D_BOX SET IMPORTSPEC = null WHERE PSU_NB='$psunb'AND PSU_SQ='$psusq'  DELETE FROM DZICUBE.dbo.LSTOCK_D WHERE CO_CD  = '1001'AND RCV_NB ='$rcvnb'AND RCV_SQ = $rcvsq DELETE FROM TSIMPORTINSPEC WHERE PSU_NB = '$psunb'");
        "UPDATE TSPODELIVER_D SET RCV_NB = null ,RCV_SQ = 0,  RCV_QT = 0   WHERE CO_CD  = '1001'AND PSU_NB = '$psunb'AND PSU_SQ = '$psusq' UPDATE TSPODELIVER_D_BOX SET IMPORTSPEC = null WHERE PSU_NB='$psunb'AND PSU_SQ='$psusq'  DELETE FROM DZICUBE.dbo.LSTOCK_D WHERE CO_CD  = '1001'AND RCV_NB ='$rcvnb'AND RCV_SQ = $rcvsq");
  }

//선택항목있으면 삭제 없으면 메세지출력
  Future<void> checkdelete(BuildContext context, String psunb, int psusq,
      String rcvnb, int rcvsq) async {
    if (await ynck()) {
      if (deleteck == true) {
        delete(
          psunb,
          psusq,
          rcvnb,
          rcvsq,
        );
        isuQtCheckDialog(context, '삭제가 완료되었습니다.');
        deletedata.clear();
      } else {
        isuQtCheckDialog(context, '선택된 항목이 없습니다.');
      }
    } else {
      isuQtCheckDialog(context, '삭제가 불가능합니다.');
      return;
    }
  }

//색깔
  Color selectColor(int index) {
    if (setColor[index] == true) {
      deleteck = true;
      return Colors.blue.shade300;
    }
    deleteck = false;
    return Colors.grey.shade300;
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
