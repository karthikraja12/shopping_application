import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ocean_task/product_screen/categories_select.dart';




void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
        title: 'Ocean',
        themeMode: ThemeMode.system,
        theme: ThemeData(
        primaryColor: Colors.orange, colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.orange).copyWith(secondary: Colors.green.shade800),
        ),
      home: CategorieScreen(),
    );
  }
}


