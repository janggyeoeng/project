import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hnde_pda/config.dart';
import 'package:hnde_pda/src/auth_page.dart';
import 'package:hnde_pda/src/home.dart';
import 'package:hnde_pda/src/scm_admin/scm_check/scmcheck.dart';
import 'package:hnde_pda/src/scm_admin/scm_check_detail/scm_check_detail.dart';
import 'package:sql_conn/sql_conn.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

Future<void> main() async {
  runApp(const MyApp());
  await SqlConn.connect(
      ip: "175.126.146.139",
      port: "62301",
      databaseName: "HNDEDB",
      username: "hnde",
      password: "hnde1234#@!");
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: '/',
      routes: {
        '/main': (context) => const AuthPage(),
        '/scmcheck': (context) => const ScmCheck(),
      },
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: primaryBlue),
      home: const Home(),
      supportedLocales: const [
        Locale('ko', 'KR'),
        Locale('en', 'US'),
      ],
    );
  }
}
