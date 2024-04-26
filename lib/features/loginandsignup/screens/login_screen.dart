import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiffen_wala_user/blocs/auth_bloc/auth_bloc.dart';
import 'package:tiffen_wala_user/common/constants/colors.dart';
import 'package:tiffen_wala_user/common/utils/app_extension.dart';
import 'package:tiffen_wala_user/common/utils/utils.dart';
import 'package:tiffen_wala_user/common/widgets/custom_button.dart';
import 'package:tiffen_wala_user/features/home/main_home/screens/main_home_screen.dart';
import 'package:tiffen_wala_user/features/loginandsignup/screens/verify_otp_screen.dart';

class LoginScreen extends ConsumerStatefulWidget {
  static const routeName = "/login-screen";

  const LoginScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final phoneEditingController = TextEditingController(text: "7307372923");
  var isSigning = false;

  void phoneSignInOrSignUp() {
    if (phoneEditingController.text.length != 10) {
      showSnackBar(context, "Invalid Mobile",
          "Please enter 10 digit valid mobile number");
    } else {
      context.read<AuthBloc>().add(
          RequestOtpAuthEvent(map: {"mobile": phoneEditingController.text}));
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthLoading) {
            "".printLog(msg: "LoginScreen>>>>>>>>>>>>>>>>>>>>AuthLoading");
            showLoaderDialog(context);
          } else if (state is AuthError) {
            "${state.error}"
                .printLog(msg: "LoginScreen>>>>>>>>>>>>>>>>>>>>AuthError");
            context.back();
            showSnackBar(
                context, "Invalid Credentials", "${state.error ?? "tttt"}");
          } else if (state is AuthOtpSend) {
            "".printLog(msg: "LoginScreen>>>>>>>>>>>>>>>>>>>>AuthOtpSend");
            context.back();
            context.pushScreen(
                nextScreen: VerifyOTPScreen(
              mobile: phoneEditingController.text,
              verificationId: state.verificationId,
            ));
          } else if (state is AuthSuccess) {
            "".printLog(msg: "LoginScreen>>>>>>>>>>>>>>>>>>>>AuthOtpSend");
            context.back();
            context.pushScreen(nextScreen: MainHomeScreen());
          } else {
            "".printLog(msg: "LoginScreen>>>>>>>>>>>>>>>>>>>>else");
          }
        },
        builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: double.infinity,
                height: size.height * 0.4,
                child: Image.asset(
                  "assets/images/login_image_1.jpg",
                  fit: BoxFit.fill,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 35, vertical: 10),
                child: Text(
                  "India's #1 Food Delivery and Dining App",
                  style: textTheme.displayLarge?.copyWith(
                    fontSize: 24,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 25,
                  vertical: 1,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 1,
                        color: lightGrey,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        "Log in or sign up",
                        style: textTheme.labelSmall?.copyWith(
                          fontSize: 14,
                          color: grey,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 1,
                        color: lightGrey,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 1, horizontal: 25),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: midGrey, width: 1.0)),
                      child: SizedBox(
                        height: 50,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0)
                                .copyWith(left: 10),
                            child: Row(
                              children: [
                                const SizedBox(
                                  width: 8,
                                ),
                                Image.asset(
                                  "assets/images/indian_flag_icon.png",
                                  height: 30,
                                ),
                                const Icon(
                                  Icons.arrow_drop_down,
                                  size: 25,
                                  color: midGrey,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(vertical: 4.0)
                            .copyWith(left: 10),
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: midGrey, width: 1.0)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              "+91",
                              style: textTheme.labelMedium,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Container(
                                alignment: Alignment.center,
                                child: TextFormField(
                                  style: textTheme.bodyMedium,
                                  controller: phoneEditingController,
                                  keyboardType: TextInputType.phone,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    isCollapsed: true,
                                    contentPadding: EdgeInsets.zero,
                                    hintText: "Enter Phone Number",
                                    hintStyle: textTheme.bodyLarge?.copyWith(
                                      color: midLightGrey,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: CustomButton(
                    text: "Continue", onPressed: phoneSignInOrSignUp),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 25,
                  vertical: 10,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 1,
                        color: lightGrey,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        "or",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: grey),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 1,
                        color: lightGrey,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlinedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      overlayColor: MaterialStateProperty.all(lightGrey),
                      shape: MaterialStateProperty.all(
                        const CircleBorder(),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Image.asset(
                        "assets/images/google_icon.png",
                        height: 25,
                        width: 25,
                      ),
                    ),
                  ),
                  OutlinedButton(
                    onPressed: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                OutlinedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all(black),
                                    overlayColor:
                                        MaterialStateProperty.all(lightGrey),
                                    shape: MaterialStateProperty.all(
                                      const CircleBorder(),
                                    ),
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.all(15),
                                    child: Icon(
                                      Icons.close,
                                      color: white,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Container(
                                  decoration: const BoxDecoration(
                                      borderRadius:
                                          BorderRadiusDirectional.only(
                                              topStart: Radius.circular(15),
                                              topEnd: Radius.circular(15)),
                                      color: white),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30, vertical: 40),
                                  child: Column(
                                    children: [
                                      OutlinedButton(
                                        onPressed: () {},
                                        child: Container(
                                          alignment: Alignment.center,
                                          padding: const EdgeInsets.all(15),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const Icon(
                                                Icons.facebook,
                                                color: facebookBlue,
                                                size: 30,
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                "Continue with Facebook",
                                                style: textTheme.bodyLarge
                                                    ?.copyWith(
                                                  color: grey,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      OutlinedButton(
                                        onPressed: () {},
                                        child: Container(
                                          padding: const EdgeInsets.all(15),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const Icon(
                                                Icons.email,
                                                color: black,
                                                size: 30,
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                "Continue with Email",
                                                style: textTheme.bodyLarge
                                                    ?.copyWith(
                                                  color: grey,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          },
                          backgroundColor: transparent);
                    },
                    style: ButtonStyle(
                      overlayColor: MaterialStateProperty.all(lightGrey),
                      shape: MaterialStateProperty.all(
                        const CircleBorder(),
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(12),
                      child: Icon(
                        Icons.more_horiz_rounded,
                        size: 30,
                        color: black,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  "By continuing, you agree to our\nTerms of Service, Privacy Policy, and Content Policy",
                  style: textTheme.bodyLarge
                      ?.copyWith(color: darkGrey, fontSize: 12),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
