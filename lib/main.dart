import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:harvest_delivery/customerSide/view/pages/order_placed_page.dart';

import 'common/views/pages/signin_page.dart';
import 'farmerSide/views/main_page.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key); 

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Harvest Link',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      //home: const MainPage(title: 'Harvest Link'),
      //home:SignInPage(),
      home:OrderPlacedPage(),
    );
  }
}

