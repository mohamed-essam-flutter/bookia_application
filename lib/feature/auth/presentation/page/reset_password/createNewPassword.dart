import 'package:bookia_app/core/function/navigetor.dart';
import 'package:bookia_app/core/utils/color_app.dart';
import 'package:bookia_app/core/utils/textStyle.dart';
import 'package:bookia_app/core/widget/customButton.dart';
import 'package:bookia_app/feature/PasswordChanged.dart';
import 'package:bookia_app/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:bookia_app/feature/auth/presentation/bloc/auth_event.dart';
import 'package:bookia_app/feature/auth/presentation/bloc/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';

class Createnewpassword extends StatelessWidget {
  final String verifyCode;
  const Createnewpassword({super.key, required this.verifyCode});

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var passwordController = TextEditingController();
    var newPasswordController = TextEditingController();
    return Form(
      key: formKey,
      child: Scaffold(
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
            if (state is ResetPasswordLoading) {
              showDialog(
                context: context,
                builder: (context) {
                  return Lottie.asset('assets/image/book.json');
                },
              );
            } else if (state is ResetPasswordLoaded) {
              Navigator.pop(context);
              pushReplacement(
                  context: context, screen: const Passwordchanged());
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(20),
                Text(
                  'Create new password',
                  style: headTitle(fontWeight: FontWeight.bold),
                ),
                Text(
                  'Your new password must be unique from those previously used.',
                  style: smallHint(fontWeight: FontWeight.bold),
                  maxLines: 2,
                ),
                const Gap(30),
                TextFormField(
                  controller: passwordController,
                  decoration: const InputDecoration(
                    hintText: 'New Password',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "please enter your password";
                    } else {
                      return null;
                    }
                  },
                ),
                const Gap(15),
                TextFormField(
                  controller: newPasswordController,
                  decoration: const InputDecoration(
                    hintText: 'Confirm Password',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "please enter your confirm password";
                    } else {
                      return null;
                    }
                  },
                ),
                const Gap(40),
                custom_widget_button(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        context.read<AuthBloc>().add(ResetPasswordEvent(
                            code: int.parse(verifyCode),
                            password: int.parse(passwordController.text),
                            newPasswordConfirmation:
                                int.parse(newPasswordController.text)));
                      }
                    },
                    text: 'Reset Password'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
