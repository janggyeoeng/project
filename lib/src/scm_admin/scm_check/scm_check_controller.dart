import 'package:get/get.dart';
import 'package:hnde_pda/src/scm_admin/scm_check/scm_check_model.dart';
import 'package:flutter/material.dart';

class ScmCheckController extends GetxController {
  ScmCheckModel model = ScmCheckModel();

  Future<void> pageLoad() async {
    update();
  }

  Future<void> boxData(String detailNumber, int superIndex) async {
    return model.boxData(detailNumber, superIndex);
  }

  Future<void> setKeyboardClick(bool bo) async {
    await model.setKeyboardClick(bo);
  }

  void Function()? sstate;

  Future<void> supdate() async {
    print("탓나?");
    sstate;
  }

  dynamic textFocusListner(BuildContext context, void Function()? state) {
    sstate = state;
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

  Future<void> checkList(
      BuildContext context, String detailNumber, int index) async {
    return model.checkList(context, detailNumber, index);
  }

  Color getColor(int index) {
    return model.getColor(index);
  }

  Future<void> updateinfo(String detailNumber, int index) async {
    return model.updateinfo(detailNumber, index);
  }

  Future<void> scanBarcode(BuildContext context, String barcode) async {
    await model.scanBarcode(context, barcode);
  }

  Future<void> specCheck(String detailNumber) async {
    return model.specCheck(detailNumber.split('/')[0]);
  }

  Future<void> cleardata(String detailNumber) async {
    return model.cleardata(detailNumber);
  }

  Future<void> updatedata(String detailNumber, int index) async {
    return model.updatedata(detailNumber, index);
  }

  Future<void> checkspec(String detailNumber, int index) async {
    return model.checkspec(detailNumber, index);
  }

  String psuQt(int index) {
    return model.psuQt(index);
  }

  int sqindex() {
    return model.sqindex();
  }

  String getPsuNb() {
    return model.getPsuNb();
  }

  int getPsuSq() {
    return model.getPsuSq();
  }

  String getTrNm() {
    return model.getTrNm();
  }
}
