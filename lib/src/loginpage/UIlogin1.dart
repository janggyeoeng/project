import 'package:flutter/material.dart';
import 'package:hnde_pda/config.dart';
//import 'package:flutter_screenutil/flutter_screenutil.dart';

class UIlogin1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width -20,
      height: MediaQuery.of(context).size.height -40,
      decoration: const BoxDecoration(
        color: layerOneBg,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(60.0),
          bottomRight: Radius.circular(60.0)
        ),
      ),
    );
  }
}

