import 'package:flutter/material.dart';
import 'package:hnde_pda/src/scm_admin/scm_check_detail/scm_check_detail_model.dart';

class ScmCheckDetailController {
  ScmCheckDetailModel model = ScmCheckDetailModel();

  Future<void> boxData() async {
    return model.boxData();
  }

  dynamic textFocusListner(BuildContext context) {
    return model.textFocusListner(
      context,
    );
  }

  dynamic barcodeFocusListner(BuildContext context) {
    return model.barcodeFocusListner(context);
  }

  Future<void> setFocus(BuildContext context) async {
    return model.setFocus(context);
  }

  FocusNode getTextNode() {
    return model.textFocusNodes;
  }

  FocusNode getBarcodeNode() {
    return model.barcodeFocusNodes;
  }

  Widget detailcontainar(String text, TextStyle style, Color color) {
    return model.detailcontainar(text, style, color);
  }
}
