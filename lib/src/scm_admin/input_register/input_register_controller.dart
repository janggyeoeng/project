import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hnde_pda/src/scm_admin/input_register/input_register_model.dart';

class ScmRegisterController {
  ScmRegisterModel model = ScmRegisterModel();

  Future<void> barcodeScan(String barcode, BuildContext context) async {
    await model.barcodeScan(barcode, context);
  }

  dynamic textFocusListner(BuildContext context, void Function()? state) {
    return model.textFocusListner(context, state);
  }

  void Function()? sstate;

  Future<void> updateStates()async{
    sstate;
  }

  void setStates(void Function()? state)async{
    this.sstate = state;
  }

  Future<void> setController() async {
    return model.setController();
  }

  String psuQt(int index) {
    return model.psuQt(index);
  }

  Future<void> updatespec(String detailNumber, int superIndex) async {
    return model.updatespec(detailNumber, superIndex);
  }

  Future<void> checkList(BuildContext context) async {
    return model.checkList(context);
  }

  Future<void> clearcolor(String detailNumber, String superIndex) async {
    return model.clearcolor(detailNumber, superIndex);
  }

  Future<void> regist(BuildContext context) async {
    return model.regist(context);
  }

  Future<void> rcvCk(BuildContext context) async {
    return model.rcvCk(context);
  }

  Color getColor(int index) {
    return model.getColor(index);
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
