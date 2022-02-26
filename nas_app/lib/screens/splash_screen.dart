import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nas_app/screens/login_page.dart';
import 'package:nas_app/utils/app_colors.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  GetStorage box = GetStorage();

  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 2),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginPage())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 180,
                width: 180,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: ExactAssetImage('assets/images/main_logo.png'),
                        fit: BoxFit.fill))),
              SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.only(left: 50.0),
                child: Text("يوم جديد!!", style: Theme.of(context).textTheme.headline1),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, right: 40),
                child: Text("شغل جديد!!",
                    style: Theme.of(context).textTheme.headline1),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
