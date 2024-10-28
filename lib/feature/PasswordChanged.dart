import 'package:bookia_app/core/function/navigetor.dart';
import 'package:bookia_app/core/utils/color_app.dart';
import 'package:bookia_app/core/utils/textStyle.dart';
import 'package:bookia_app/core/widget/customButton.dart';
import 'package:bookia_app/feature/auth/presentation/page/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class Passwordchanged extends StatelessWidget {
  const Passwordchanged({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(22),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                children: [
                  SvgPicture.asset('assets/icons/password.svg'),
                  const Positioned(
                    bottom: 20,
                    top: 20,
                    left: 20,
                    right: 20,
                    child: Icon(
                      Icons.check,
                      color: ColorApp.white,
                      size: 50,
                    ),
                  )
                ],
              ),
              const Gap(35),
              Text(
                'Password Changed!',
                style: headTitle(fontWeight: FontWeight.bold),
              ),
              Text(
                'Your password has been changed \n                  successfully.',
                style: smallHint(fontWeight: FontWeight.bold),
                maxLines: 2,
              ),
              const Gap(40),
              custom_widget_button(
                  onPressed: () {
                    pushReplacement(context: context, screen: home_screen());
                  },
                  text: 'Back to Login'),
            ],
          ),
        ),
      ),
    );
  }
}
