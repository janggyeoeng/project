import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:hnde_pda/src/output/output_regitser/output_register_model.dart';
import 'package:hnde_pda/src/output/output_regitser(back)/output_register_model_back.dart';

class OutPutRegisterController2 extends GetxController {
  OutPutRegisterModel2 model = OutPutRegisterModel2();

  Widget detailcontainar(String text, TextStyle style, int index) {
    return model.detailcontainar(text, style, index);
  }

  Widget containarwhite(
    String text,
    TextStyle style,
  ) {
    return model.containarwhite(text, style);
  }

//page 로딩시
  Future<void> pageLoad(String detailNumber) async {
    return model.pageLoad(detailNumber);
  }

  Future<void> outputStDetailData(String detailNumber) async {
    return model.outputStDetailData(detailNumber);
  }

  //출고수량 controller
  Future<void> setController() async {
    return model.setController();
  }

  Future<void> selectItem(int index, bool selectSate) async {
    return model.selectItem(index, selectSate);
  }

  Future<void> checkValue(BuildContext context, int index, String value) async {
    return model.checkValue(context, index, value);
  }

  Future<void> setSelectItem(int index, String value, String col) async {
    return model.setSelectItem(index, value, col);
  }

  Future<void> saveClick(BuildContext context) async {
    return model.saveClick(context);
  }

  Future<void> saveIsu(BuildContext contexts, String str) async {
    return model.saveIsu(contexts, str);
  }

  Future<void> saveEnd() async {
    // 화면 새로 그리지 말고 그냥 초기화 하고 setupdate 하자
    return model.saveEnd();
  }

  void isuQtCheckDialog(BuildContext context, String errorMessage) {
    return model.isuQtCheckDialog(context, errorMessage);
  }

  //출고구분 controller code
  Future<void> outputEndData() async {
    return model.outputEndData();
  }

  //마감 controller code
  Future<void> deadLineData() async {
    return model.deadLineData();
  }

  //출고구분 선택된 값 가져오는 controller
  void setSelectedOutputend(int newValue) {
    return model.setSelectedOutputend(newValue);
  }

  //마감 선택된 값을 가져오는 controller
  void setSelectedDeadline(int newValue) {
    return model.setSelectedDeadline(newValue);
  }

  //컬러 값 컨트롤러
  Color selectColor(int index) {
    return model.selectColor(index);
  }

  Future<void> colorBool(int index) async {
    return model.colorBool(index);
  }

  //출고등록 controller
  Future<void> combineData(int index, Map<String, dynamic> selectedOutputend,
      Map<String, dynamic> selectedDeadline) async {
    return model.combineData(index, selectedOutputend, selectedDeadline);
  }

  List<TextEditingController> getSearch() {
    return model.outcontroller;
  }
}
