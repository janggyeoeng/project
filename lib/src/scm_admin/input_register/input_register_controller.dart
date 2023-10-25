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

  Future<void> setController() async {
    return model.setController();
  }

  String psuQt(int index) {
    return model.psuQt(index);
  }

  Future<void> checkList(BuildContext context) async {
    return model.checkList(context);
  }

  Future<void> clearcolor(String detailNumber, String superIndex) async {
    return model.clearcolor(detailNumber, superIndex);
  }

  Future<void> regist() async {
    return model.regist();
  }

  Color getColor(int index) {
    return model.getColor(index);
  }

  String getPsuNb() {
    return model.getPsuNb();
  }

  String getTrNm() {
    return model.getTrNm();
  }
}
