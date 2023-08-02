import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:house_scout/login.dart';
import 'package:house_scout/register.dart';
import 'package:house_scout/splash.dart';
import 'package:house_scout/usertype.dart';
import 'package:house_scout/utils/constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'House Scout',
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => const SplashScreen()),
        GetPage(name: '/login', page: () => Login()),
        GetPage(name: '/register', page: () => Register()),
        GetPage(name: '/usertype', page: () => UserType())
      ],
    );
  }
}