import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';
import 'package:tiffen_wala_user/blocs/auth_bloc/auth_bloc.dart';
import 'package:tiffen_wala_user/common/constants/colors.dart';
import 'package:tiffen_wala_user/common/utils/app_extension.dart';
import 'package:tiffen_wala_user/features/home/main_home/screens/main_home_screen.dart';

class VerifyOTPScreen extends StatefulWidget {
  final String mobile, verificationId;

  const VerifyOTPScreen(
      {super.key, required this.mobile, required this.verificationId});

  @override
  State<VerifyOTPScreen> createState() => _VerifyOTPScreenState();
}

class _VerifyOTPScreenState extends State<VerifyOTPScreen> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: textTheme.labelMedium?.copyWith(fontSize: 20),
      decoration: BoxDecoration(
        border: Border.all(color: midGrey),
        borderRadius: BorderRadius.circular(8),
      ),
    );
    final submittedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: black),
      borderRadius: BorderRadius.circular(8),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "OTP Verification",
          style: textTheme.labelSmall?.copyWith(fontSize: 18),
        ),
        centerTitle: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_sharp,
            color: black,
          ),
        ),
        backgroundColor: white,
        elevation: 0,
      ),
      backgroundColor: white,
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if(state is AuthSuccess){
            context.pushReplacementScreen(nextScreen: MainHomeScreen()) ;
          }
        },
        builder: (context, state) {
          return Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "We have sent a verification code to",
                  style: textTheme.bodyLarge?.copyWith(fontSize: 16),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  "${widget.mobile}",
                  style: textTheme.titleSmall,
                ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Pinput(
                    defaultPinTheme: defaultPinTheme,
                    submittedPinTheme: submittedPinTheme,
                    length: 6,
                    pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                    showCursor: true,
                    onCompleted: (pin) {
                      context.read<AuthBloc>().add(OtpVerificationAuthEvent(
                              map: {
                                "otp": pin,
                                "verificationId": widget.verificationId
                              }));
                    },
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.all(15),
                    side: BorderSide(
                      color: midGrey,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7.0),
                    ),
                  ),
                  child: Text(
                    "Resend",
                    style: textTheme.labelSmall
                        ?.copyWith(color: midGrey, fontSize: 16),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  "Try other login methods",
                  style: textTheme.labelSmall?.copyWith(color: primaryColor),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
