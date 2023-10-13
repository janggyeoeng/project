import 'package:get/get.dart';
import 'package:hnde_pda/src/scm_admin/scm_check/scm_check_model.dart';
import 'package:flutter/material.dart';

class ScmCheckController extends GetxController {
  ScmCheckModel model = ScmCheckModel();

  Future<void> pageLoad() async {
    update();
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

  Future<void> backKey(BuildContext context) async {
    return model.backKey(context);
  }

  Future<void> checkList(BuildContext context) async {
    return model.checkList(context);
  }

  Color getColor(int index) {
    return model.getColor(index);
  }

  Future<void> scanBarcode(BuildContext context, String barcode) async {
    await model.scanBarcode(context, barcode);
  }

  Future<void> specCheck(String detailNumber) async {
    return model.specCheck(detailNumber);
  }

  Future<void> cleardata(String detailNumber) async {
    return model.cleardata(detailNumber);
  }

  Future<void> updatedata(String detailNumber) async {
    return model.updatedata(detailNumber);
  }

  String psuQt(int index) {
    return model.psuQt(index);
  }

  String getPsuNb() {
    return model.getPsuNb();
  }

  String getTrNm() {
    return model.getTrNm();
  }
}
