import 'package:bookia_app/core/function/navigetor.dart';
import 'package:bookia_app/core/utils/color_app.dart';
import 'package:bookia_app/core/utils/textStyle.dart';
import 'package:bookia_app/core/widget/customButton.dart';
import 'package:bookia_app/core/widget/navigationBarView.dart';
import 'package:bookia_app/feature/auth/data/models/request/loginParams.dart';
import 'package:bookia_app/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:bookia_app/feature/auth/presentation/bloc/auth_event.dart';
import 'package:bookia_app/feature/auth/presentation/bloc/auth_state.dart';
import 'package:bookia_app/feature/auth/presentation/page/forgot/forgotPassword.dart';
import 'package:bookia_app/feature/auth/presentation/page/registerScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

// ignore: must_be_immutable
class home_screen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  home_screen({super.key});
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          pushAndRemoveUntil(
              context: context, screen: const Navigationbar_view());
        }
      },
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            leading: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  color: ColorApp.darkBlack,
                )),
          ),
          body: Padding(
            padding: const EdgeInsets.all(22),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Gap(20),
                  Text(
                    'Welcome back! Glad',
                    style: headTitle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'to see you, Again!',
                    style: headTitle(fontWeight: FontWeight.bold),
                  ),
                  const Gap(30),
                  TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      hintText: 'Enter your email',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter your email";
                      }
                      return null;
                    },
                  ),
                  const Gap(15),
                  TextFormField(
                    controller: passwordController,
                    decoration: const InputDecoration(
                        hintText: 'Enter your password',
                        suffixIcon: Icon(Icons.remove_red_eye_outlined)),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter your password";
                      }
                      return null;
                    },
                  ),
                  const Gap(13),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                          onPressed: () {
                            push(
                                context: context,
                                screen: const ForgotPassword());
                          },
                          child: Text(
                            'Forgot Password?',
                            style: smallHint(),
                          )),
                    ],
                  ),
                  const Gap(13),
                  state is LoginLoading
                      ? const Center(child: CircularProgressIndicator())
                      : custom_widget_button(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              context.read<AuthBloc>().add(LoginEvent(
                                  LoginParams(
                                      name: emailController.text,
                                      password: passwordController.text)));
                            }
                          },
                          text: 'login',
                        ),
                  const Gap(35),
                  Center(
                      child: Text(
                    'Or Login with',
                    style: smallHint(),
                  )),
                  const Gap(20),
                  Row(
                    children: [
                      Container(
                        width: 105,
                        height: 50,
                        decoration: const BoxDecoration(
                            shape: BoxShape.rectangle, color: ColorApp.border),
                        child: SvgPicture.asset(
                          'assets/icons/facebook.svg',
                          fit: BoxFit.none,
                        ),
                      ),
                      const Gap(8),
                      Container(
                        width: 105,
                        height: 50,
                        decoration: const BoxDecoration(
                            shape: BoxShape.rectangle, color: ColorApp.border),
                        child: SvgPicture.asset(
                          'assets/icons/google.svg',
                          fit: BoxFit.none,
                        ),
                      ),
                      const Gap(8),
                      Container(
                        width: 105,
                        height: 50,
                        decoration: const BoxDecoration(
                            shape: BoxShape.rectangle, color: ColorApp.border),
                        child: SvgPicture.asset(
                          'assets/icons/apple.svg',
                          fit: BoxFit.none,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      const Gap(60),
                      Text(
                        'Don’t have an account? ',
                        style: smallHint(color: ColorApp.black),
                      ),
                      TextButton(
                          onPressed: () {
                            pushReplacement(
                                context: context,
                                screen: const registerScreen());
                          },
                          child: Text(
                            'Register Now',
                            style: smallHint(color: ColorApp.primary),
                          ))
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
