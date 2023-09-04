// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:hnde_pda/src/auth_page.dart';
// import 'package:sql_conn/sql_conn.dart';
//dede
// //Login controller
// class LoginManager {
//   Future<void> login(TextEditingController idController,
//       TextEditingController pwController, BuildContext context) async {
//     String? id = idController.text;
//     String? pw = pwController.text;

//     String loginsql = await SqlConn.readData(
//         "EXEC dbo.SP_PDA_LOGIN @UserId ='" +
//             id.toString() +
//             "', @Password = '" +
//             pw.toString() +
//             "'");

//     String outputdata = await SqlConn.readData(
//         "exec SP_MOBILE_DROPBOX 'SO_FG'");
//     print(outputdata);
//     List<dynamic> decodedData = jsonDecode(outputdata);
//     print(decodedData);

//     List<dynamic> logindecode = jsonDecode(loginsql);
//     int login = (logindecode[0]["Result"]);

//     // id입력 초기화
//     void clearId() {
//       idController.clear();
//     }

//     // pw입력 초기화
//     void clearPw() {
//       pwController.clear();
//     }

//     if (login == 1) {
//       Get.to(() => const AuthPage());
//     } else if (login == 0) {
//       Get.dialog(
//         AlertDialog(
//           title: const Text('아이디, 비밀번호를\n다시 확인해주세요.', style: TextStyle(fontSize: 18),),
//           actions: <Widget>[
//             TextButton(
//               child: const Text('OK'),
//               onPressed: () {
//                 Get.back();
//                 clearId();
//                 clearPw();
//               }, //주문번호 거래처, 주문일자 
//             ),
//           ],
//         ),
//       );
//     }
//   }
// }

// //output controller
// class OutPutController extends GetxController {
//   Rx<DateTime> selectedStartDate = Rx<DateTime>(DateTime.now());
//   Rx<DateTime> selectedEndDate = Rx<DateTime>(DateTime.now());
//   RxList<Map<String, dynamic>> outputlist = RxList<Map<String, dynamic>>([]);

//   Future<void> OutputStatusData(DateTime startDate, DateTime endDate, String searchKeyword) async {
//     String outputdata = await SqlConn.readData(
//         "SP_TSDELIVER_MOBILE_R1 '1000', '$searchKeyword', '$startDate', '$endDate'");
//     List<Map<String, dynamic>> decodedData =
//         List<Map<String, dynamic>>.from(jsonDecode(outputdata));
//     outputlist.assignAll(decodedData);
//     update();
//   }
// }

// //output_detail_controller
// class OpDetailController extends GetxController {
//   Rx<List<Map<String, dynamic>>> detailData = Rx<List<Map<String, dynamic>>>([]);

//   Future<void> OutputStDetailData(String detailNumber) async {
//     String detailDataString = await SqlConn.readData(
//       "SP_TSDELIVER_MOBILE_R2 '1000', '$detailNumber'");
//     List<dynamic> decodedData = jsonDecode(detailDataString);
//     detailData.value = List<Map<String, dynamic>>.from(decodedData);
//   }
// }

// //output_register_controller
// class OutPutRegisterController extends GetxController {
//   Rx<DateTime> selectedStartDate = Rx<DateTime>(DateTime.now());
//   Rx<DateTime> selectedEndDate = Rx<DateTime>(DateTime.now());
//   RxList<Map<String, dynamic>> outputregisterlist = RxList<Map<String, dynamic>>([]);

//   Future<void> OutputRegisterData(DateTime startDate, DateTime endDate, String searchKeyword, String customerKeyword) async {
//     String outputdata = await SqlConn.readData(
//         "exec SP_MOBILE_DELIVER_R1 '1001', '$startDate', '$endDate', '$searchKeyword', '$customerKeyword'");
//     List<Map<String, dynamic>> decodedData =
//         List<Map<String, dynamic>>.from(jsonDecode(outputdata));
//     outputregisterlist.assignAll(decodedData);
//     update();
//   }
// }

// class OpRegisterDetailController extends GetxController {
//   Rx<List<Map<String, dynamic>>> detailData = Rx<List<Map<String, dynamic>>>([]);

//   Future<void> OutputStDetailData(String detailNumber) async {
//     String detailDataString = await SqlConn.readData(
//       "exec SP_MOBILE_DELIVER_R2 '1001', '$detailNumber'");
//     List<dynamic> decodedData = jsonDecode(detailDataString);
//     detailData.value = List<Map<String, dynamic>>.from(decodedData);
//   }
// }

// //dropdown
// class DetailDataDropDown extends GetxController {
//   Rx<List<Map<String, dynamic>>> detailData = Rx<List<Map<String, dynamic>>>([]);
//   Rx<String> selectedDropdown = Rx<String>('');

//   Future<void> OutputDropdownData(String dropdetail) async {
//     String detailDataString = await SqlConn.readData(
//       "exec SP_MOBILE_DROPBOX '$dropdetail'");
//     List<dynamic> decodedData = jsonDecode(detailDataString);
//     detailData.value = List<Map<String, dynamic>>.from(decodedData);

//     // Set the default selectedDropdown value based on the first entry
//     selectedDropdown.value = detailData.value.isNotEmpty ? detailData.value[0]['CODE_NAME'] : '';
//   }
// }