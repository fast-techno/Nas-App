import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nas_app/screens/splash_screen.dart';
import 'package:nas_app/utils/Translations/localization.dart';
import 'package:nas_app/utils/app_colors.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: _configureThemeData(),
      translations: LocalizationService(),
      locale: LocalizationService().getCurrentLocale(),
      fallbackLocale: const Locale('ar', 'AE'),
      builder: EasyLoading.init(),
      debugShowCheckedModeBanner: false,
      home: const SplashPage(),
    );
  }

  ThemeData _configureThemeData() {
    return ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
        fontFamily: 'Lora',
        textTheme: TextTheme(
          headline1: TextStyle(
              fontSize: 30,
              color: AppColors.secondaryColor,
              height: 0.8,
              fontWeight: FontWeight.w700),
          bodyText1: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
            color: AppColors.secondaryColor,
          ),
          bodyText2: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryColor,
          ),
          subtitle1: TextStyle(
              color: AppColors.greyColor,
              fontSize: 17,
              fontWeight: FontWeight.bold),
          subtitle2: TextStyle(
              color: AppColors.primaryColor,
              fontSize: 17,
              fontWeight: FontWeight.bold),
          headline6: TextStyle(color: AppColors.secondaryColor, fontSize: 14),
          headline5: TextStyle(
              color: AppColors.greyColor,
              fontSize: 12,
              fontWeight: FontWeight.bold),
          headline4: TextStyle(
              color: AppColors.secondaryColor,
              fontSize: 13,
              fontWeight: FontWeight.bold),
          headline3: TextStyle(color: AppColors.greyColor, fontSize: 14),
        ));
  }
}
