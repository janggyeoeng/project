import 'package:flutter/material.dart';
import 'package:hnde_pda/src/scm_admin/input_delete/input_delete_model.dart';

class ScmDeleteController {
  ScmDeleteModel model = ScmDeleteModel();

  Future<void> pageLoad() async {
    return model.pageLoad();
  }

  Future<void> colorck(int index) async {
    return model.colorck(index);
  }

  Future<DateTimeRange?> selectDateRange(
      BuildContext context, DateTimeRange selectedDateRange) async {
    return model.selectDateRange(context, selectedDateRange);
  }

  Future<void> selectDate(BuildContext context) async {
    return model.selectDate(context);
  }

  Future<void> setController() async {
    return model.setController();
  }

  Future<void> deleteData(
      String customerKeyword, DateTime startDate, DateTime endDate) async {
    return model.deleteData(customerKeyword, startDate, endDate);
  }

  Future<void> checkdelete(String psunb, int psusq, String rcvnb, int rcvsq) {
    return model.checkdelete(psunb, psusq, rcvnb, rcvsq);
  }

  Future<void> inputdata() async {
    return model.inputdata();
  }

  Color selectColor(int index) {
    return model.selectColor(index);
  }

  String getPsuNb() {
    return model.getPsuNb();
  }

  int getPsuSq() {
    return model.getPsuSq();
  }

  String getRcvNb() {
    return model.getRcvNb();
  }

  int getRcvSq() {
    return model.getRcvSq();
  }
}
