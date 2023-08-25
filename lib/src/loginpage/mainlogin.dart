import 'package:flutter/material.dart';
import 'package:hnde_pda/config.dart';
import 'package:hnde_pda/src/controller/login_controller.dart';

class MainLogin extends StatefulWidget {
  const MainLogin({super.key});

  @override
  State<MainLogin> createState() => _MainLoginState();
}

class _MainLoginState extends State<MainLogin> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  final LoginManager _loginManager = LoginManager();

  void _resetTextFields() {
    _idController.clear();
    _pwController.clear();
  }

   @override
  void dispose() {
    _idController.dispose();
    _pwController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 584,
        width: MediaQuery.of(context).size.width,
        child: Stack(children: [
           Positioned(
            left: MediaQuery.of(context).size.height - 600,
            top: 70,
            bottom: 0,
            child: Text(
              '아이디',
              style: TextStyle(
                  fontFamily: 'Poppins-Medium',
                  fontSize: 24,
                  fontWeight: FontWeight.w500),
            ),
          ),
          Positioned(
              left: MediaQuery.of(context).size.height - 600,
              top: 99,
              bottom: 0,
              child: Container(
                width: 280,
                child: TextField(
                  controller: _idController,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    hintText: '아이디를 입력하세요',
                    hintStyle: TextStyle(color: hintText),
                  ),
                ),
              )),
          Positioned(
            left: MediaQuery.of(context).size.height - 600,
            top: 189,
            bottom: 0,
            child: Text(
              '비밀번호',
              style: TextStyle(
                  fontFamily: 'Poppins-Medium',
                  fontSize: 24,
                  fontWeight: FontWeight.w500),
            ),
          ),
          Positioned(
              left: MediaQuery.of(context).size.height - 600,
              top: 219,
              bottom: 0,
              child: Container(
                width: 280,
                child: TextField(
                    controller: _pwController,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      hintText: '비밀번호를 입력하세요',
                      hintStyle: TextStyle(color: hintText),
                    ),
                    obscureText: true,
                    onSubmitted: (_) {
                       _loginManager.login(_idController, _pwController, context);
                       _resetTextFields();
                    },
                    ),
              )),
          Positioned(
              top: MediaQuery.of(context).size.height - 380,
              right: MediaQuery.of(context).size.width - 360,
              bottom: MediaQuery.of(context).size.height -580,
              child: GestureDetector(
                onTap: () {
                  _loginManager.login(_idController, _pwController, context);
                  _resetTextFields();
                  // _login();
                },
                child: Container(
                  width: MediaQuery.of(context).size.width -250,
                  height: MediaQuery.of(context).size.height -10,
                  decoration: const BoxDecoration(
                    color: signInButton,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20)),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.only(top: 6.0),
                    child: Text(
                      '로그인',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontFamily: 'Poppins-Medium',
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              )),
        ]));
  }
}
