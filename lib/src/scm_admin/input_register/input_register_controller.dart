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

  String getPsuNb() {
    return model.getPsuNb();
  }

  String getTrNm() {
    return model.getTrNm();
  }
}
