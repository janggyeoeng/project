import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hnde_pda/src/output/output_status/output_status_model.dart';

class OutPutController extends GetxController {
  OutPutStatusModel model = OutPutStatusModel();

  Future<void> outputStatusData(
      DateTime startDate, DateTime endDate, String searchKeyword) async {
    return model.outputStatusData(startDate, endDate, searchKeyword);
  }

  Future<DateTimeRange?> selectDateRange(
      BuildContext context, DateTimeRange selectedDateRange) async {
    return model.selectDateRange(context, selectedDateRange);
  }

  Future<void> selectDate(BuildContext context) async {
    return model.selectDate(context);
  }

  Future<void> outputdata() async {
    return model.outputdata();
  }

  Future<void> setInfo(int index) async {
    return model.setInfo(index);
  }

  TextEditingController getSearch() {
    return model.searchController;
  }
}
