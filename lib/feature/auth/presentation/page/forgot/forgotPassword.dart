import 'dart:developer';

import 'package:bookia_app/core/function/navigetor.dart';
import 'package:bookia_app/core/utils/color_app.dart';
import 'package:bookia_app/core/utils/textStyle.dart';
import 'package:bookia_app/core/widget/customButton.dart';
import 'package:bookia_app/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:bookia_app/feature/auth/presentation/bloc/auth_event.dart';
import 'package:bookia_app/feature/auth/presentation/bloc/auth_state.dart';
import 'package:bookia_app/feature/auth/presentation/page/otp/otpVerification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: ColorApp.darkBlack,
            )),
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          // TODO: implement listener
          if (state is ForgotPasswordLoading) {
            showDialog(
              context: context,
              builder: (context) {
                return Lottie.asset('assets/image/book.json');
              },
            );
          } else if (state is ForgotPasswordLoaded) {
            Navigator.pop(context);
            pushReplacement(context: context, screen: const Otpverification());
          } else {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('There is a mistake in the transmission'),
              backgroundColor: ColorApp.red,
            ));
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(22),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(20),
                Text(
                  'Forgot Password?',
                  style: headTitle(fontWeight: FontWeight.bold),
                ),
                Text(
                  'Don\'t worry! It occurs. Please enter the email address linked with your account.',
                  style: smallHint(fontWeight: FontWeight.bold),
                  maxLines: 2,
                ),
                const Gap(30),
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    hintText: 'Enter your email',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'please enter your email';
                    } else {
                      return null;
                    }
                  },
                ),
                const Gap(40),
                custom_widget_button(
                    onPressed: () {
                      log(emailController.text);
                      if (formKey.currentState!.validate()) {
                        context.read<AuthBloc>().add(
                            ForgotPasswordEvent(email: emailController.text));
                      }
                    },
                    text: 'Send Code'),
                const Spacer(),
                Row(
                  children: [
                    const Gap(60),
                    Text(
                      'Remember Password?  ',
                      style: smallHint(color: ColorApp.black),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Login',
                          style: smallHint(color: ColorApp.primary),
                        ))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
