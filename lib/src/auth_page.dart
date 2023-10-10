import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hnde_pda/src/output/output_order/output_order.dart';
import 'package:hnde_pda/src/scm_admin/return_item_register.dart';
import 'package:hnde_pda/src/scm_admin/scm_check/scmcheck.dart';
import 'package:hnde_pda/src/home.dart';
import 'package:hnde_pda/src/scm_admin/input_register/input_register.dart';
import 'package:hnde_pda/src/scm_admin/input_delete.dart';
import 'package:hnde_pda/src/output/output_regitser/output_register.dart';
import 'package:hnde_pda/src/output/output_status/output_status.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  Widget gridRouter(String title, IconData icon, VoidCallback onTap) {
    return Card(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(7))),
      shadowColor: Colors.black,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 10,
                    spreadRadius: 3),
              ]),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(
                height: 15,
              ),
              Icon(
                icon,
                size: 70,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () {
                Get.defaultDialog(
                    title: '로그아웃',
                    middleText: '로그아웃 하시겠습니까?\n',
                    onConfirm: () => Get.offAll(() => const Home()),
                    onCancel: () => (),
                    textConfirm: '예',
                    textCancel: '취소',
                    barrierDismissible: false);
              },
              icon: const Icon(
                Icons.exit_to_app,
                size: 30,
                color: Colors.white,
              ))
        ],
        elevation: 0.7,
        centerTitle: true,
        title: Text(
          'H&DE',
          style: GoogleFonts.lato(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.0),
        ),
      ),
      body: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 10),
            child: SingleChildScrollView(
              child: GridView.count(
                padding: const EdgeInsets.all(35),
                crossAxisCount: 2,
                crossAxisSpacing: 3,
                mainAxisSpacing: 3,
                shrinkWrap: true, // 스크롤 불가하도록 함
                physics: const NeverScrollableScrollPhysics(), //스크롤 불가하도록 ㅎ마
                children: [
                  gridRouter("SCM수입검사", Icons.pageview, () {
                    Get.to(() => const ScmCheck());
                  }),
                  gridRouter("SCM입고등록", Icons.move_to_inbox, () {
                    Get.to(() => const InputRegister());
                  }),
                  gridRouter("SCM입고삭제", Icons.gpp_bad, () {
                    Get.to(() => const InputDelete());
                  }),
                  gridRouter("SCM반품등록", Icons.library_add_check, () {
                    Get.to(() => const ReturnItemRegister());
                  }),
                  gridRouter("출고등록", Icons.open_in_browser_rounded, () {
                    Get.to(() => OutputRegister());
                  }),
                  gridRouter("출고현황", Icons.reorder, () {
                    Get.to(() => OutputStatus());
                  })
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
