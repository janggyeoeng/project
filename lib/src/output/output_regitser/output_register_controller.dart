import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:hnde_pda/src/output/output_regitser/output_register_model.dart';

class OutPutRegisterController extends GetxController {
  OutPutRegisterModel model = OutPutRegisterModel();

  Future<void> OutputRegisterData(DateTime startDate, DateTime endDate,
      String searchKeyword, String customerKeyword) async {
    return model.OutputRegisterData(
        startDate, endDate, searchKeyword, customerKeyword);
  }

  Widget container(String text) {
    return model.container(text);
  }

  Widget expanded(String text) {
    return model.expanded(text);
  }

  Future<void> outputregisterdata() async {
    return model.outputregisterdata();
  }
}
