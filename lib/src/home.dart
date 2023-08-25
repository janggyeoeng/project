import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hnde_pda/src/loginpage/UIlogin1.dart';
import 'package:hnde_pda/src/loginpage/UIlogin2.dart';
import 'package:hnde_pda/config.dart';
import 'package:hnde_pda/src/loginpage/mainlogin.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Container(
          color: signInButton,
          child: SingleChildScrollView(
            // SingleChildScrollView 추가
            child: Container(
              height:
                  MediaQuery.of(context).size.height,
              child: Stack(
                children: [
                  Positioned(
                    top: 110,
                    left: 40,
                    bottom: 0,
                    right: 0,
                    child: Container(
                      child: Text(
                        'H&DE',
                        style: GoogleFonts.lato(
                          fontSize: 48,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 190,
                    right: 0,
                    bottom: 0,
                    child: UIlogin1(),
                  ),
                  Positioned(
                    top: 215,
                    right: 0,
                    bottom: 28,
                    child: UIlogin2(),
                  ),
                  const Positioned(
                    top: 185,
                    right: 0,
                    bottom: 48,
                    child: MainLogin(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
