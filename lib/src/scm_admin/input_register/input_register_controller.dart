import 'package:flutter/material.dart';
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

  Future<void> updateStates() async {
    sstate;
  }

  void setStates(void Function()? state) async {
    sstate = state;
  }

  Future<void> setController() async {
    return model.setController();
  }

  String psuQt(int index) {
    return model.psuQt(index);
  }

  Future<void> boxData(String detailNumber, int superIndex) async {
    return model.boxData(detailNumber, superIndex);
  }

  Future<void> updatespec(String detailNumber, int superIndex) async {
    return model.updatespec(detailNumber, superIndex);
  }

  Future<void> checkList(BuildContext context) async {
    return model.checkList(context);
  }

  Future<void> regist(BuildContext context) async {
    return model.regist(context);
  }

  // Future<void> rcvCk(BuildContext context) async {
  //   return model.rcvCk(context);
  // }

  Color getColor(int index) {
    return model.getColor(index);
  }

  Future<void> updateinfo(String detailNumber, int index) async {
    return model.updateinfo(detailNumber, index);
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
