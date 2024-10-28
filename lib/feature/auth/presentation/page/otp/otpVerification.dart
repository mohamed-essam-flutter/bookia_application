import 'package:bookia_app/core/function/navigetor.dart';
import 'package:bookia_app/core/utils/color_app.dart';
import 'package:bookia_app/core/utils/textStyle.dart';
import 'package:bookia_app/core/widget/customButton.dart';
import 'package:bookia_app/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:bookia_app/feature/auth/presentation/bloc/auth_event.dart';
import 'package:bookia_app/feature/auth/presentation/bloc/auth_state.dart';
import 'package:bookia_app/feature/auth/presentation/page/reset_password/createNewPassword.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class Otpverification extends StatefulWidget {
  const Otpverification({super.key});

  @override
  State<Otpverification> createState() => _OtpverificationState();
}

class _OtpverificationState extends State<Otpverification> {
  var formKey = GlobalKey<FormState>();
  var pinCodeController = TextEditingController();
  String? currentText;
  @override
  Widget build(BuildContext context) {
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
            // TODO: implement listener
            if (state is OtpLoading) {
              showDialog(
                context: context,
                builder: (context) {
                  return Lottie.asset('assets/image/book.json');
                },
              );
            } else if (state is OtpLoaded) {
              Navigator.pop(context);
              pushReplacement(
                  context: context,
                  screen: Createnewpassword(
                    verifyCode: currentText ?? "llll",
                  ));
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
                  'OTP Verification',
                  style: headTitle(fontWeight: FontWeight.bold),
                ),
                Text(
                  'Enter the verification code we just sent on your email address.',
                  style: smallHint(fontWeight: FontWeight.bold),
                  maxLines: 2,
                ),
                const Gap(30),
                PinCodeTextField(
                  appContext: context,
                  length: 6,
                  obscureText: false,
                  animationType: AnimationType.fade,
                  pinTheme: PinTheme(
                    inactiveFillColor: ColorApp.white,
                    activeColor: ColorApp.primary,
                    inactiveColor: ColorApp.primary,
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(5),
                    fieldHeight: 50,
                    fieldWidth: 40,
                    activeFillColor: Colors.white,
                  ),
                  animationDuration: Duration(milliseconds: 300),
                  backgroundColor: ColorApp.white,
                  enableActiveFill: true,
                  controller: pinCodeController,
                  onCompleted: (v) {
                    print("Completed");
                  },
                  onChanged: (value) {
                    print(value);
                    setState(() {
                      currentText = value;
                    });
                  },
                  beforeTextPaste: (text) {
                    print("Allowing to paste $text");
                    //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                    //but you can show anything you want here, like your pop up saying wrong paste format or etc
                    return true;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'please enter your code';
                    } else {
                      return null;
                    }
                  },
                ),
                // OtpTextField(
                //   numberOfFields: 6,
                //   borderColor: ColorApp.primary,
                //   focusedBorderColor: ColorApp.primary,
                //   //set to true to show as box or false to show as dash
                //   showFieldAsBox: true,
                //   //runs when a code is typed in
                //   onCodeChanged: (String code) {
                //     //handle validation or checks here
                //   },
                //   //runs when every textfield is filled
                //   onSubmit: (String verificationCode) {
                //     showDialog(
                //         context: context,
                //         builder: (context) {
                //           return AlertDialog(
                //             title: const Text("Verification Code"),
                //             content: Text('Code entered is $verificationCode'),
                //           );
                //         });
                //   }, // end onSubmit
                // ),
                const Gap(40),
                custom_widget_button(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        context
                            .read<AuthBloc>()
                            .add(OtpEvent(code: int.parse(currentText!)));
                      }
                    },
                    text: 'Verify'),
                const Spacer(),
                Row(
                  children: [
                    const Gap(60),
                    Text(
                      'Didn’t received code? ',
                      style: smallHint(color: ColorApp.black),
                    ),
                    TextButton(
                        onPressed: () {},
                        child: Text(
                          'Resend',
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
