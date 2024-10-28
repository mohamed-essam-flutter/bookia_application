import 'package:bookia_app/core/function/navigetor.dart';
import 'package:bookia_app/core/utils/color_app.dart';
import 'package:bookia_app/core/utils/textStyle.dart';
import 'package:bookia_app/core/widget/customButton.dart';
import 'package:bookia_app/feature/auth/presentation/page/login.dart';
import 'package:bookia_app/feature/auth/presentation/page/registerScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class Welcome_screen extends StatelessWidget {
  const Welcome_screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: Image.asset(
                  'assets/image/welcome.png',
                  fit: BoxFit.cover,
                )),
            Padding(
              padding: const EdgeInsets.all(22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Spacer(
                    flex: 2,
                  ),
                  SvgPicture.asset('assets/image/bookia.svg'),
                  Text(
                    'Order Your Book Now!',
                    style: headTitle(fontSize: 20),
                  ),
                  const Spacer(
                    flex: 4,
                  ),
                  custom_widget_button(
                    onPressed: () {
                      pushReplacement(context: context, screen: home_screen());
                    },
                    text: 'login',
                  ),
                  const Gap(15),
                  custom_widget_button(
                    onPressed: () {
                      push(context: context, screen: const registerScreen());
                    },
                    text: 'Register',
                    color: ColorApp.white,
                    color_text: ColorApp.black,
                  ),
                  const Spacer(
                    flex: 1,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
