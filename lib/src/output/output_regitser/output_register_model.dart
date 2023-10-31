import 'dart:convert';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sql_conn/sql_conn.dart';

class OutPutRegisterModel2 {
  Rx<List<Map<String, dynamic>>> detailData =
      Rx<List<Map<String, dynamic>>>([]);
  Rx<List<Map<String, dynamic>>> outputEnd = Rx<List<Map<String, dynamic>>>([]);
  Rx<List<Map<String, dynamic>>> deadLine = Rx<List<Map<String, dynamic>>>([]);
  List<TextEditingController> outcontroller = [];
  List<Map<String, dynamic>> outDtData = [];
  int? _selectedOutputend = 0;
  int? _selectedDeadline = 0;
  int? get selectedOutputend => _selectedOutputend;
  int? get selectedDeadline => _selectedDeadline;
  List<bool> setColor = [];
  List<Map<String, dynamic>> combinedData = [];
  String detailNumber = '';

  List<TextEditingController> getSearch() {
    return outcontroller;
  }

  Widget detailcontainar(String text, TextStyle style, int index) {
    return Container(
      height: 50,
      width: 85,
      decoration: BoxDecoration(
        color: selectColor(index),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(1),
          ),
        ],
      ),
      child: Center(
        child: AutoSizeText(
          text,
          style: style,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget containarwhite(
    String text,
    TextStyle style,
  ) {
    return GestureDetector(
      child: Container(
        height: 50,
        width: 85,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(1),
            ),
          ],
        ),
        child: Center(
            child: AutoSizeText(
          text,
          style: style,
          textAlign: TextAlign.center,
        )),
      ),
    );
  }

//page 로딩시
  Future<void> pageLoad(String detailNumber) async {
    await outputStDetailData(detailNumber);
    await setController();
    await outputEndData();
    await deadLineData();
  }

  Future<void> outputStDetailData(String detailNumber) async {
    this.detailNumber = detailNumber;
    String detailDataString = await SqlConn.readData(
        "exec SP_MOBILE_DELIVER_R2 '1001', '$detailNumber'");
    String detailDatastr = detailDataString.replaceAll('TSST_', '');
    List<dynamic> decodedData = jsonDecode(detailDatastr);
    outDtData = List<Map<String, dynamic>>.from(decodedData);
    detailData.value = outDtData;
  }

  //출고수량 controller
  Future<void> setController() async {
    for (int i = 0; i < detailData.value.length; i++) {
      outcontroller.add(
          TextEditingController()); //detailData만큼 TextEditingController를 add한다

      outcontroller[i].text = detailData.value[i]['ISU_QT'];
      setColor.add(false);
    }
  }

  Future<void> selectItem(int index, bool selectSate) async {
    setColor[index] = selectSate;
    detailData.value[index]['CHK'] = selectSate;
  }

  Future<void> checkValue(BuildContext context, int index, String value) async {
    if (int.parse(detailData.value[index]['ISUREQ_QT']) < int.parse(value)) {
      //print('큰값들어왔다');
      isuQtCheckDialog(context, '출고수량은 주문수량을 \n초과할 수 없습니다.');
    } else {
      await selectItem(index, true);
    }
  }

  Future<void> setSelectItem(int index, String value, String col) async {
    detailData.value[index][col] = value;

    print('변경됬나? : ${detailData.value[index]}');
  }

  Future<void> saveClick(BuildContext context) async {
    String lists = '';
    for (int i = 0; i < detailData.value.length; i++) {
      //print(this.detailData.value[i]['CHK']);
      if (detailData.value[i]['CHK'] == true) {
        lists +=
            '$detailNumber${detailData.value[i]['ISUREQ_SQ'].toString().padLeft(4, '0')}|';
        lists += detailData.value[i]['ISU_QT'] == null
            ? ''
            : detailData.value[i]['ISU_QT'] + '|';
        lists += detailData.value[i]['LOT_NB'] == null
            ? ''
            : detailData.value[i]['LOT_NB'] + ',';
      }
      print(detailData.value[i]['ISU_QT']);
    }

    //print(lists.substring(0,lists.length-1));
    // print(_selectedOutputend);
    // print(_selectedDeadline);
    await saveIsu(context, lists.substring(0, lists.length - 1));
  }

  Future<void> saveIsu(BuildContext contexts, String str) async {
    print('parameter? : $str, $_selectedOutputend, $_selectedDeadline');
    var res = await SqlConn.writeData(
        "exec SP_MOBILE_DELIVER_C1 '1001', '$_selectedOutputend', '$_selectedDeadline', '$str'");

    if (res) {
      showDialog(
          context: contexts,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              content: const Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('저장이 완료되었습니다.'),
                ],
              ),
              actions: [
                TextButton(
                    onPressed: () async {
                      Navigator.pop(context);
                      await saveEnd();
                    },
                    child: const Text('확인'))
              ],
            );
          });
    }
  }

  Future<void> saveEnd() async {
    // 화면 새로 그리지 말고 그냥 초기화 하고 setupdate 하자
    setColor = [];
    outcontroller = [];
    await pageLoad(detailNumber);
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

  //출고구분 controller code
  Future<void> outputEndData() async {
    String detailDataString =
        await SqlConn.readData("exec SP_MOBILE_DROPBOX 'SO_FG'");
    List<dynamic> decodedData = jsonDecode(detailDataString);
    List<Map<String, dynamic>> processedData =
        List<Map<String, dynamic>>.from(decodedData);
    outputEnd.value = processedData;
  }

  //마감 controller code
  Future<void> deadLineData() async {
    String detailDataString =
        await SqlConn.readData("exec SP_MOBILE_DROPBOX 'PROC_FG'");
    List<dynamic> decodedData = jsonDecode(detailDataString);
    List<Map<String, dynamic>> processedData =
        List<Map<String, dynamic>>.from(decodedData);
    deadLine.value = processedData;
  }

  //출고구분 선택된 값 가져오는 controller
  void setSelectedOutputend(int newValue) {
    _selectedOutputend = newValue;
  }

  //마감 선택된 값을 가져오는 controller
  void setSelectedDeadline(int newValue) {
    _selectedDeadline = newValue;
  }

  //컬러 값 컨트롤러
  Color selectColor(int index) {
    if (setColor[index] == true) {
      return Colors.blue.shade300;
    }
    return Colors.grey.shade300;
  }

  Future<void> colorBool(int index) async {
    if (setColor[index] == true) {
      setColor[index] = false;
      detailData.value[index]['CHK'] = false;
    } else {
      setColor[index] = true;
      detailData.value[index]['CHK'] = true;
    }

    // print(this.detailData.value[index]['CHK']);

    if (setColor[index] == true) {
      Map<String, dynamic> selectedOutputend;
      if (_selectedOutputend == 0) {
        selectedOutputend = outputEnd.value[0];
      } else {
        selectedOutputend = outputEnd.value[1];
      }

      Map<String, dynamic> selectedDeadline;
      if (_selectedDeadline == 0) {
        selectedDeadline = deadLine.value[0];
      } else {
        selectedDeadline = deadLine.value[1];
      }

      await combineData(index, selectedOutputend, selectedDeadline);
    }
  }

  //출고등록 controller
  Future<void> combineData(int index, Map<String, dynamic> selectedOutputend,
      Map<String, dynamic> selectedDeadline) async {
    combinedData.clear(); //데이터 초기화
    Map<String, dynamic> combinedItem = {};

    print('1 : $selectedOutputend');
    print('2 : $selectedDeadline');
    print('3 : ${detailData.value[index]}');

    combinedItem.addAll(selectedOutputend);
    combinedItem.addAll(selectedDeadline);
    combinedItem.addAll(detailData.value[index]);

    combinedData.add(combinedItem);

    print('여기 : $combinedData');
  }
}

// Color.fromRGBO(240, 248, 255, 1)

//출고구분값과 마감 값과 index된 값, 출고수량값을 합쳐서 등록시킨다..