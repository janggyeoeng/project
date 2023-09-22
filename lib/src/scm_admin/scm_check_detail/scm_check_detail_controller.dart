import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hnde_pda/src/scm_admin/scm_check_detail/scm_check_detail_model.dart';

class ScmCheckDetailController extends GetxController {
  ScmCheckDetailModel model = ScmCheckDetailModel();

  Future<void> boxData(String detailNumber) async {
    return model.boxData(detailNumber);
  }

  dynamic textFocusListner(BuildContext context, void Function()? state) {
    return model.textFocusListner(context, state);
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

  Future<void> check(BuildContext context) async {
    return model.check(context);
  }

  Future<void> checkNb(BuildContext context, String detailNumber) async {
    return model.checkNb(context, detailNumber);
  }

  Future<void> saveEnd(String detailNumber) async {
    return model.saveEnd(detailNumber);
  }

  TextEditingController gettxtCon() {
    return model.gettxtCon();
  }

  FocusNode getTxtNode() {
    return model.getTxtNode();
  }

  FocusNode getBcNode() {
    return model.getBcNode();
  }

  Widget detailcontainar(String text, TextStyle style, Color color) {
    return model.detailcontainar(text, style, color);
  }

  Color getColor(int index) {
    return model.getColor(index);
  }
}
