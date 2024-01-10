import 'package:bmiproject/assets/constrains.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:bmiproject/pages/splash.dart';
import 'package:bmiproject/widgets/bmilogic.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(BMIRecordAdapter());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'BMI Calculator',
        theme: ThemeData(scaffoldBackgroundColor: primarybackgroundColor),
        home: const Splash(),
        debugShowCheckedModeBanner: false
    );
  }
}
