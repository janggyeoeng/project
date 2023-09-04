import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hnde_pda/src/auth_page.dart';
import 'package:sql_conn/sql_conn.dart';

class LoginManager {
  Future<void> login(TextEditingController idController,
      TextEditingController pwController, BuildContext context) async {
    String? id = idController.text;
    String? pw = pwController.text;

    String loginsql = await SqlConn.readData(
        "EXEC dbo.SP_PDA_LOGIN @UserId ='" +
            id.toString() +
            "', @Password = '" +
            pw.toString() +
            "'");

    // String outputdata = await SqlConn.readData(
    //     "exec SP_MOBILE_DROPBOX 'SO_FG'");
    // print(outputdata);
    // List<dynamic> decodedData = jsonDecode(outputdata);
    // print(decodedData);


    Rx<List<Map<String, dynamic>>> dropdownData = Rx<List<Map<String, dynamic>>>([]);
    String detailDataString = await SqlConn.readData(
      "exec SP_MOBILE_DROPBOX 'SO_FG'");
    List<dynamic> decodedData = jsonDecode(detailDataString);
    dropdownData.value = List<Map<String, dynamic>>.from(decodedData);
    print(dropdownData);

    List<dynamic> logindecode = jsonDecode(loginsql);
    int login = (logindecode[0]["Result"]);

    // id입력 초기화
    void clearId() {
      idController.clear();
    }

    // pw입력 초기화
    void clearPw() {
      pwController.clear();
    }

    if (login == 1) {
      Get.to(() => const AuthPage());
    } else if (login == 0) {
      Get.dialog(
        AlertDialog(
          title: const Text('아이디, 비밀번호를\n다시 확인해주세요.', style: TextStyle(fontSize: 18),),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Get.back();
                clearId();
                clearPw();
              }, //주문번호 거래처, 주문일자 
            ),
          ],
        ),
      );
    }
  }
}