import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hnde_pda/src/output/output_status_detail/output_status_detail_model.dart';

class OpDetailController {
  OutputStatusDetailModel model = OutputStatusDetailModel();
  Rx<List<Map<String, dynamic>>> detailData =
      Rx<List<Map<String, dynamic>>>([]);

  Future<void> outputStDetailData(String detailNumber) async {
    return model.outputStDetailData(detailNumber);
  }

  Widget detailcontainar(String text, TextStyle style, Color color) {
    return model.detailcontainar(text, style, color);
  }
}
