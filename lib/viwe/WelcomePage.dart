import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gpa_calculator/viwe/gpa_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  Future<void> _setLanguage(String langCode, String countryCode) async {
    // تحديث اللغة في GetX
    Get.updateLocale(Locale(langCode, countryCode));

    // تخزين اللغة في SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('languageCode', langCode);
    await prefs.setString('countryCode', countryCode);

    // الانتقال إلى الصفحة الرئيسية
    Get.off(() => GpaCalculatorView());
  }

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
               Center(child:  Text("Pleaselanguage".tr,style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),)),
               SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                      onTap: () {
                        _setLanguage('en', 'US'); // اختيار اللغة الإنجليزية
                      },
                      child: Card(
                        child: SizedBox(
                          height: widthScreen / 2,
                          width: widthScreen / 2.5,
                          child: Center(child: Text('English'.tr)),
                        ),
                      )),
                  InkWell(
                      onTap: () {
                        _setLanguage('ar', 'SA'); // اختيار اللغة الإنجليزية
                      },
                      child: Card(
                        child: SizedBox(
                          height: widthScreen / 2,
                          width: widthScreen / 2.5,
                          child: Center(
                            child: Text('العربية'.tr),
                          ),
                        ),
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
