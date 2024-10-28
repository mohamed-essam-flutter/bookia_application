import 'dart:async';
import 'package:bookia_app/core/function/navigetor.dart';
import 'package:bookia_app/core/services/AppLocalStorage.dart';
import 'package:bookia_app/core/widget/navigationBarView.dart';
import 'package:bookia_app/feature/welcome.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    String IsLogin = AppLocalStorage.getCache(key: AppLocalStorage.token) ?? "";
    super.initState();
    Future.delayed(
      const Duration(seconds: 3),
      () {
        if (IsLogin.isNotEmpty) {
          pushReplacement(context: context, screen: const Navigationbar_view());
        } else {
          pushReplacement(context: context, screen: const Welcome_screen());
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset('assets/image/bookia.svg'),
          ],
        ),
      ),
    );
  }
}
