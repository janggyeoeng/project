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

  Future<void> setController() async {
    return model.setController();
  }

  Future<void> checkList(BuildContext context) async {
    return model.checkList(context);
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
