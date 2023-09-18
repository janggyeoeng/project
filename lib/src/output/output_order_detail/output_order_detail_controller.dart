import 'package:flutter/material.dart';
import 'package:hnde_pda/src/output/output_order_detail/output_order_detail_model.dart';

class OutPutOrderDetailController {
  OutPutOrderDetailModel model = OutPutOrderDetailModel();

  Widget detailcontainar(String text, TextStyle style, int index) {
    return model.detailcontainar(text, style, index);
  }

  Widget containarwhite(
    String text,
    TextStyle style,
  ) {
    return model.containarwhite(text, style);
  }
}
