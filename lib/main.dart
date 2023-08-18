import 'package:flutter/material.dart';

import 'screens/my_home.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quran App',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const Directionality(
          textDirection: TextDirection.rtl, child: MyHomePage()),
    );
  }
}
