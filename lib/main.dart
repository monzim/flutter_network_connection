import 'package:flutter/material.dart';
import 'package:flutter_network_connection/binding/home_binding.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'view/home_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Network Status',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeView(),
      initialBinding: HomeBinding(),
    );
  }
}
