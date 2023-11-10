import 'package:flutter/material.dart';
import 'package:hnde_pda/src/scm_admin/input_delete/input_delete_model.dart';

class ScmDeleteController {
  ScmDeleteModel model = ScmDeleteModel();

  Future<void> pageLoad(BuildContext context) async {
    return model.pageLoad(context);
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

  Future<void> deleteData(BuildContext context, String customerKeyword,
      DateTime startDate, DateTime endDate) async {
    return model.deleteData(context, customerKeyword, startDate, endDate);
  }

  Future<void> checkdelete(
      BuildContext context, String psunb, int psusq, String rcvnb, int rcvsq) {
    return model.checkdelete(context, psunb, psusq, rcvnb, rcvsq);
  }

  Future<void> inputdata(BuildContext context) async {
    return model.inputdata(context);
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
