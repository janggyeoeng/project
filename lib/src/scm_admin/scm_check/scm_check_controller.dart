import 'package:get/get.dart';
import 'package:hnde_pda/src/scm_admin/scm_check/scm_check_model.dart';
import 'package:flutter/material.dart';

class ScmCheckController extends GetxController {
  ScmCheckModel model = ScmCheckModel();

  Future<void> pageLoad() async {
    update();
  }

  Future<void> click() async {
    return model.click();
  }

  Future<void> setKeyboardClick(bool bo) async {
    await model.setKeyboardClick(bo);
  }

  dynamic textFocusListner(BuildContext context, void Function()? state) {
    return model.textFocusListner(context, state);
  }

  dynamic barcodeFocusListner(BuildContext context) {
    return model.barcodeFocusListner(context);
  }

  Future<void> setController() async {
    return model.setController();
  }

  FocusNode getTextNode() {
    return model.getTextNode();
  }

  FocusNode getBarcodeNode() {
    return model.getBarcodeNode();
  }

  Future<void> setFocus(BuildContext context) async {
    model.setFocus(context);
  }

  Color setKeyboardColor() {
    return model.setKeyboardColor();
  }

  Color getColor(int index) {
    return model.getColor(index);
  }

  Future<void> scanBarcode(String barcode) async {
    await model.scanBarcode(barcode);
  }

  String getPsuNb() {
    return model.getPsuNb();
  }

  String getTrNm() {
    return model.getTrNm();
  }
}
