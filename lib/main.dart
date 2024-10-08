import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gpa_calculator/viwe/WelcomePage.dart';
import 'translations.dart'; // استيراد ملف الترجمة

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
  primaryColor: Colors.black, // اللون الأساسي
  hintColor: Colors.orange, // اللون الثانوي
  scaffoldBackgroundColor: Colors.white,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.white, backgroundColor: Colors.orange, // لون النص داخل الأزرار
    ),
  ),
  textTheme: TextTheme(
    bodyLarge: TextStyle(color: Colors.black), // لون النص الأساسي
    bodyMedium: TextStyle(color: Colors.black),
  ),
),
      debugShowCheckedModeBanner: false,
      translations: AppTranslations(), // تفعيل الترجمة
      locale:  Get.deviceLocale,// اللغة الافتراضية
      fallbackLocale: const Locale('ar', 'SA'), // لغة الاحتياط
      home:const WelcomePage(),
    );
  }
}
