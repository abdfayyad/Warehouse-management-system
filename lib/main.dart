import 'package:flutter/material.dart';
import 'package:ware_house_project/src/admin/AddWarehouseRequests/AddWarehousesRequest.dart';
import 'package:ware_house_project/src/both/Login/login.dart';
import 'package:ware_house_project/src/both/Signup/siginup.dart';
import 'package:ware_house_project/src/both/splash_screen.dart';
import 'package:ware_house_project/src/client/Home/home_page.dart';
import 'package:ware_house_project/utils/shared_prefirance.dart';

import 'src/Owner/Home/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPref.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      debugShowCheckedModeBanner: false,

      home: SplashScreen(),
    );
  }
}

