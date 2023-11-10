import 'package:flutter/material.dart';
import 'package:hnde_pda/src/scm_admin/return_item/return_item_register_model.dart';

class ReturnRegisterController {
  ReturnRegisterModel model = ReturnRegisterModel();
  void Function()? sstate;

  Future<void> setController() async {
    return model.setController();
  }

  Future<void> returnItem(BuildContext context, String barcode) async {
    return model.returnItem(context, barcode);
  }

  Future<void> returnRegist(BuildContext context, String psudt) async {
    return model.returnRegist(context, psudt);
  }

  Future<void> updateStates() async {
    sstate;
  }

  void setStates(void Function()? state) async {
    sstate = state;
  }

  String getPsuNb() {
    return model.getPsuNb();
  }

  String getTrNm() {
    return model.getTrNm();
  }

  String getPsuDt() {
    return model.getPsuDt();
  }

  Color getColor(int index) {
    return model.getColor(index);
  }

  String psuQt(int index) {
    return model.psuQt(index);
  }
}
