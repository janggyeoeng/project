import 'package:flutter/material.dart';
import 'package:hnde_pda/src/scm_admin/input_delete_detail(X)/input_delete_detail_model.dart';

class ScmDeleteDetailController {
  ScmDeleteDetailModel model = ScmDeleteDetailModel();

  Future<DateTimeRange?> selectDateRange(
      BuildContext context, DateTimeRange selectedDateRange) async {
    return model.selectDateRange(context, selectedDateRange);
  }

  Future<void> selectDate(BuildContext context) async {
    return model.selectDate(context);
  }

  Future<void> deleteData(
      String customerKeyword, DateTime startDate, DateTime endDate) async {
    return model.deleteData(customerKeyword, startDate, endDate);
  }

  Future<void> outputdata() async {
    return model.outputdata();
  }
}
