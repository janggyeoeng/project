import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hnde_pda/src/scm_admin/scm_check/scm_check_controller.dart';
import 'package:hnde_pda/src/scm_admin/scm_check_detail/scm_check_detail_model.dart';

class ScmCheckDetailController extends GetxController {
  ScmCheckDetailModel model = ScmCheckDetailModel();

  Future<void> boxData(String detailNumber,
      ScmCheckController scmCheckController, int superIndex) async {
    return model.boxData(detailNumber, scmCheckController, superIndex);
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

  Future<void> check(
      BuildContext context,
      ScmCheckController scmCheckController,
      String detailNumber,
      int superIndex) async {
    return model.check(context, scmCheckController, detailNumber, superIndex);
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

  Future<void> plus() async {
    return model.plus();
  }

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

  Color getColor(int index, ScmCheckController scmCheckController) {
    return model.getColor(index, scmCheckController);
  }
}
