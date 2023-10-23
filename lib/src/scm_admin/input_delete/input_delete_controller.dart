import 'package:flutter/material.dart';
import 'package:hnde_pda/src/scm_admin/input_delete/input_delete_model.dart';

class ScmDeleteController {
  ScmDeleteModel model = ScmDeleteModel();

  Future<DateTimeRange?> selectDateRange(
      BuildContext context, DateTimeRange selectedDateRange) async {
    return model.selectDateRange(context, selectedDateRange);
  }

  Future<void> selectDate(BuildContext context) async {
    return model.selectDate(context);
  }

  Future<void> deleteData(DateTime startDate, DateTime endDate) async {
    return model.deleteData(startDate, endDate);
  }

  Future<void> outputdata() async {
    return model.outputdata();
  }
}
