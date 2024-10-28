import 'package:bookia_app/core/function/navigetor.dart';
import 'package:bookia_app/core/utils/color_app.dart';
import 'package:bookia_app/core/utils/textStyle.dart';
import 'package:bookia_app/core/widget/customButton.dart';
import 'package:bookia_app/core/widget/navigationBarView.dart';
import 'package:bookia_app/feature/auth/data/models/request/RegisterParams.dart';
import 'package:bookia_app/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:bookia_app/feature/auth/presentation/bloc/auth_event.dart';
import 'package:bookia_app/feature/auth/presentation/bloc/auth_state.dart';
import 'package:bookia_app/feature/auth/presentation/page/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class registerScreen extends StatefulWidget {
  const registerScreen({super.key});

  @override
  State<registerScreen> createState() => _registerScreenState();
}

class _registerScreenState extends State<registerScreen> {
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var passwordConfirmationController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(listener: (context, state) {
      if (state is RegisterSuccess) {
        pushAndRemoveUntil(
            context: context, screen: const Navigationbar_view());
      } else if (state is RegisterFiler) {
        SnackBar(content: Text(state.error));
      }
    }, builder: (context, state) {
      return Scaffold(
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
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Gap(20),
                  Text(
                    'Hello! Register to get ',
                    style: headTitle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'started',
                    style: headTitle(fontWeight: FontWeight.bold),
                  ),
                  const Gap(30),
                  TextFormField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      hintText: 'Username',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter your name';
                      }
                      return null;
                    },
                  ),
                  const Gap(12),
                  TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      hintText: 'Email',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter your email';
                      }
                      return null;
                    },
                  ),
                  const Gap(12),
                  TextFormField(
                    controller: passwordController,
                    decoration: const InputDecoration(
                      hintText: 'Password',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter your password';
                      }
                      return null;
                    },
                  ),
                  const Gap(12),
                  TextFormField(
                    controller: passwordConfirmationController,
                    decoration: const InputDecoration(
                      hintText: 'Confirm password',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter your confirm password';
                      }
                      return null;
                    },
                  ),
                  const Gap(30),
                  state is RegisterLoading
                      ? const CircularProgressIndicator()
                      : custom_widget_button(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              context
                                  .read<AuthBloc>()
                                  .add(RegisterEvent(RegisterParams(
                                    name: nameController.text,
                                    email: emailController.text,
                                    password: passwordController.text,
                                    passwordConfirmation:
                                        passwordConfirmationController.text,
                                  )));
                            }
                          },
                          text: 'Register',
                        ),
                  const Gap(35),
                  Center(
                      child: Text(
                    'Or Register with',
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
                  const Gap(3),
                  Row(
                    children: [
                      const Gap(60),
                      Text(
                        'Already have an account?  ',
                        style: smallHint(color: ColorApp.black),
                      ),
                      TextButton(
                          onPressed: () {
                            pushReplacement(
                                context: context, screen: home_screen());
                          },
                          child: Text(
                            'Login Now',
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
    });
  }
}
