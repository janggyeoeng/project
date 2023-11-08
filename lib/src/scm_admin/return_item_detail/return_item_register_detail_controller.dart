import 'package:flutter/material.dart';
import 'package:hnde_pda/src/scm_admin/return_item/return_item_register_controller.dart';
import 'package:hnde_pda/src/scm_admin/return_item_detail/return_item_register_detail_model.dart';

class ReturnRegisterDetailController {
  ReturnRegisterDetailModel model = ReturnRegisterDetailModel();

  Future<void> boxData(
      String detailNumber,
      ReturnRegisterController returnRegisterController,
      String superIndex) async {
    return model.boxData(detailNumber, returnRegisterController, superIndex);
  }

  Future<void> checkNb(String detailNumber) async {
    return model.checkNb(detailNumber);
  }

  Future<void> barcodecheck(
      BuildContext context,
      ReturnRegisterController returnRegisterController,
      String detailNumber,
      int superIndex) async {
    return model.barcodecheck(
        context, returnRegisterController, detailNumber, superIndex);
  }

  Future<void> setSelectChk() async {
    return model.setSelectChk();
  }

  Future<void> plus() async {
    return model.plus();
  }

  Future<void> checkcount(String psu, String psusq,
      ReturnRegisterController returnRegisterController) async {
    return model.checkcount(psu, psusq, returnRegisterController);
  }

  String getPsuNb() {
    return model.getPsuNb();
  }

  String getTrNm() {
    return model.getTrNm();
  }

  Color getColor(int index, ReturnRegisterController returnRegisterController) {
    return model.getColor(index, returnRegisterController);
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

  Widget detailcontainar(String text, TextStyle style, Color color) {
    return model.detailcontainar(text, style, color);
  }

  FocusNode getTxtNode() {
    return model.getTxtNode();
  }

  FocusNode getBcNode() {
    return model.getBcNode();
  }
}
