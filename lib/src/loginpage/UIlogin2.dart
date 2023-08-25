import 'package:flutter/material.dart';

class UIlogin2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width -40,
        height: 350,
        decoration: const BoxDecoration(
          color:Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(60.0),
              bottomRight: Radius.circular(60.0),
              bottomLeft: Radius.circular(60.0),
          ),  
        ),
    );
  }
}