import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class OutPutOrderDetailModel {
  List<bool> setColor = [];
  Widget detailcontainar(String text, TextStyle style, int index) {
    return Container(
      height: 50,
      width: 85,
      decoration: BoxDecoration(
        color: Colors.lightBlue[100],
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(1),
          ),
        ],
      ),
      child: Center(
        child: AutoSizeText(
          text,
          style: style,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget containarwhite(
    String text,
    TextStyle style,
  ) {
    return GestureDetector(
      child: Container(
        height: 50,
        width: 85,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(1),
            ),
          ],
        ),
        child: Center(
          child: AutoSizeText(
            text,
            style: style,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  // Color selectColor(int index) {
  //   if (setColor[index] == true) {
  //     return Colors.blue.shade300;
  //   }
  //   return Colors.grey.shade300;
  // }
}
