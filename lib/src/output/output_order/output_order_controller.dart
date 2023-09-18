import 'package:flutter/material.dart';
import 'package:hnde_pda/src/output/output_order/output_order_model.dart';

class OutPutOrderController {
  OutPutOrderModel model = OutPutOrderModel();

  Future<DateTimeRange?> selectDateRange(
      BuildContext context, DateTimeRange selectedDateRange) async {
    return model.selectDateRange(context, selectedDateRange);
  }

  Future<void> selectDate(BuildContext context) async {
    return model.selectDate(context);
  }

  Widget container(String text) {
    return model.container(text);
  }

  Widget expanded(String text) {
    return model.expanded(text);
  }
}
