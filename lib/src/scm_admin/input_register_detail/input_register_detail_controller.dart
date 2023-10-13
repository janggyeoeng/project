import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hnde_pda/src/scm_admin/input_register/input_register_controller.dart';
import 'package:hnde_pda/src/scm_admin/input_register_detail/input_register_detail_model.dart';
import 'package:hnde_pda/src/scm_admin/scm_check/scm_check_controller.dart';

class ScmRegisterDetailController extends GetxController {
  ScmRegisterDetailModel model = ScmRegisterDetailModel();

  Future<void> boxData(String detailNumber,
      ScmRegisterController scmRegisterController, int superIndex) async {
    return model.boxData(detailNumber, scmRegisterController, superIndex);
  }

  dynamic textFocusListner(BuildContext context, void Function()? state) {
    return model.textFocusListner(context, state);
  }

  dynamic barcodeFocusListner(BuildContext context) {
    return model.barcodeFocusListner(context);
  }

  Future<void> setFocus(BuildContext context) async {
    return model.setFocus(context);
  }

  Future<void> setKeyboardClick(bool bo) async {
    return model.setKeyboardClick(bo);
    //print('불값 : ${this.keyboardClick}');
  }

  Color setKeyboardColor() {
    return model.setKeyboardColor();
  }

  Future<void> barcodecheck(
      BuildContext context,
      ScmRegisterController scmRegisterController,
      String detailNumber,
      int superIndex) async {
    return model.barcodecheck(
        context, scmRegisterController, detailNumber, superIndex);
  }

  Future<void> updatedata(
      String detailNumber, int superIndex, String box) async {
    return model.updatedata(detailNumber, superIndex, box);
  }

  Future<void> checkNb(String detailNumber) async {
    return model.checkNb(detailNumber);
  }

  // Future<void> saveEnd(String detailNumber) async {
  //   return model.saveEnd(detailNumber);
  // }

  Future<void> setSelectChk() async {
    update();
    return model.setSelectChk();
  }

  bool getselect() {
    return model.getselect();
  }

  TextEditingController gettxtCon() {
    return model.gettxtCon();
  }

  FocusNode getTxtNode() {
    return model.getTxtNode();
  }

  FocusNode getBcNode() {
    return model.getBcNode();
  }

  Widget detailcontainar(String text, TextStyle style, Color color) {
    return model.detailcontainar(text, style, color);
  }

  Color getColor(int index) {
    return model.getColor(index);
  }
}
