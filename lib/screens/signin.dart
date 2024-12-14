import 'package:dio/dio.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/constants.dart';
import '../controllers/responsive.dart';
import '../controllers/session_controller.dart';
import '../widgets/buttons.dart';
import '../widgets/custom_app_bars.dart';
import '../widgets/input_fields.dart';
import '../widgets/password_fields.dart';

class Signin extends StatefulWidget {
  Signin({super.key, required this.session});
  SessionController session;

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  final constantValues = Get.find<Constants>();
  var userInfo = GetStorage();
  Dio dio = Dio();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  late bool otpSent = false;
  late var otpTextStyles = [
    createStyle(Colors.pinkAccent),
    createStyle(Colors.lightBlueAccent),
    createStyle(Colors.lime),
    createStyle(Colors.purpleAccent),
    createStyle(Colors.brown),
    createStyle(Colors.deepOrange),
  ];
  TextStyle? createStyle(Color color) {
    ThemeData theme = Theme.of(context);
    return theme.textTheme.displaySmall?.copyWith(color: color);
  }

  @override
  void initState() {
    super.initState();
    if (userInfo.read("rememberMe")) {
      setState(() {
        emailController.text = userInfo.read("tempEmail");
        passwordController.text = userInfo.read("tempPassword");
      });
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    // ThemeChanger themeChanger = Provider.of<ThemeChanger>(context);
    var mainFont = GoogleFonts.archivo(
        textStyle: TextStyle(
            fontSize: size.width * 0.04,
            color: constantValues.whiteColor,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.normal));
    var subFont = GoogleFonts.archivo(
        textStyle: TextStyle(
            color: constantValues.whiteColor,
            fontWeight: FontWeight.w300,
            fontStyle: FontStyle.normal));
    return Scaffold(
      backgroundColor: constantValues.bgColor,
      appBar: CustomAppBar(userInfo: userInfo, constantValues: constantValues),
      body: SafeArea(
          child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Responsive(
            isExtraLargeScreen:
                isExtraLargeScreen(context, size, mainFont, subFont),
            isTablet: isTablet(context, size),
            isMobile: isMobile(context, size, mainFont, subFont)),
      )),
    );
  }

  Widget isExtraLargeScreen(
      BuildContext context, Size size, var font1, var font2) {
    return const Column(
      children: [],
    );
  }

  Widget isTablet(BuildContext context, Size size) {
    return const Column(
      children: [],
    );
  }

  Widget isMobile(BuildContext context, Size size, var font1, var font2) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
      child: Column(
        children: [
          SizedBox(height: size.height * 0.02),
          Text(constantValues.signinText, style: font1),
          Text(constantValues.signinSubText,
              style: font2, textAlign: TextAlign.center),
          SizedBox(height: size.height * 0.04),
          Card(
            color: constantValues.bgColor2,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.02, vertical: size.height * 0.05),
              child: Form(
                key: _formKey,
                child: !otpSent
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          EmailFieldA(
                            controller: emailController,
                            width: size.width * 0.9,
                            title: "Email Address",
                          ),
                          SizedBox(height: size.height * 0.02),
                          PasswordFieldA(
                            controller: passwordController,
                            width: size.width * 0.9,
                            title: "Password",
                          ),
                          SizedBox(height: size.height * 0.04),
                          ButtonA(
                            width: size.width * 0.9,
                            bgColor: constantValues.primaryColor,
                            textColor: constantValues.whiteColor,
                            text: "Sign In",
                            authenticate: () async {
                              await signin();
                            },
                          ),
                          SizedBox(height: size.height * 0.02),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Checkbox(
                                  value: userInfo.read("rememberMe"),
                                  onChanged: (value) {
                                    setState(() {
                                      userInfo.write("rememberMe", value);
                                    });
                                    if (value == true) {
                                      userInfo.write("tempEmail",
                                          emailController.text.trim());
                                      userInfo.write("tempPassword",
                                          passwordController.text.trim());
                                    } else {
                                      userInfo.write("tempEmail", "");
                                      userInfo.write("tempPassword", "");
                                    }
                                  },
                                ),
                                SizedBox(width: size.width * 0.005),
                                Text(
                                  constantValues.remember,
                                  style: GoogleFonts.poppins(
                                      textStyle: const TextStyle(
                                          fontWeight: FontWeight.w300)),
                                ),
                              ]),
                          SizedBox(height: size.height * 0.02),
                          ButtonB(
                              width: size.width * 0.9,
                              bgColor: constantValues.transparentColor,
                              textColor: constantValues.whiteColor,
                              text: "Sign In with Google",
                              authenticate: () async {}),
                          SizedBox(height: size.height * 0.02),
                          RichText(
                            text: TextSpan(
                                style: GoogleFonts.archivo(
                                    textStyle: TextStyle(
                                  color: userInfo.read("isDarkTheme")
                                      ? constantValues.whiteColor2
                                      : constantValues.darkColor,
                                )),
                                children: [
                                  TextSpan(
                                    text: constantValues.dontHaveAccount,
                                  ),
                                  TextSpan(
                                      text: constantValues.dontHaveAccount2,
                                      style: GoogleFonts.archivo(
                                          textStyle: TextStyle(
                                              color:
                                                  constantValues.primaryColor,
                                              fontWeight: FontWeight.w500)),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          context.goNamed("signup");
                                        }),
                                ]),
                          ),
                          SizedBox(height: size.height * 0.02),
                          RichText(
                            text: TextSpan(
                                style: GoogleFonts.archivo(
                                    textStyle: TextStyle(
                                  color: userInfo.read("isDarkTheme")
                                      ? constantValues.whiteColor2
                                      : constantValues.darkColor,
                                )),
                                children: [
                                  TextSpan(text: constantValues.forgotPassword),
                                  TextSpan(
                                      text: constantValues.forgotPassword2,
                                      style: GoogleFonts.archivo(
                                          textStyle: TextStyle(
                                              color:
                                                  constantValues.primaryColor,
                                              fontWeight: FontWeight.w500)),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {}),
                                ]),
                          ),
                        ],
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                              "An otp has been sent to your Email address."),
                          SizedBox(height: size.height * 0.02),
                          OtpTextField(
                            numberOfFields: 6,
                            styles: otpTextStyles,
                            obscureText: true,
                            onCodeChanged: (String code) {},
                            onSubmit: (value) async {
                              await verifyOtp();
                            },
                          ),
                        ],
                      ),
              ),
            ),
          ),
          SizedBox(height: size.height * 0.05),
        ],
      ),
    );
  }

  customSnackBar(String message) => SnackBar(
        content: Row(
          children: [
            Icon(Icons.info, color: constantValues.whiteColor),
            const SizedBox(width: 10),
            Text(message,
                maxLines: 5,
                style: GoogleFonts.archivo(
                    textStyle: TextStyle(
                        color: constantValues.whiteColor,
                        fontWeight: FontWeight.w500))),
          ],
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        showCloseIcon: true,
        closeIconColor: constantValues.whiteColor,
        duration: const Duration(seconds: 3),
        backgroundColor: constantValues.darkColor2,
      );

  signin() async {
    final checkForm = _formKey.currentState!;
    if (checkForm.validate()) {
      // final email = emailController.text.trim().toLowerCase();
      // final password = passwordController.text.trim();
      setState(() {
        otpSent = true;
      });
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(customSnackBar("Invalid credentials!"));
    }
  }

  verifyOtp() {
    setState(() {
      userInfo.write("userData", {
        "role": "artist",
        "full_name": "Johnny Doe",
        "ministry": "john d doe",
        "username": "johnny_doe",
        "email": "johndoe@gmail.com",
      });
      widget.session.enableSigninPage = true;
    });
    context.goNamed("home_frame");
    setState(() {
      otpSent = false;
    });
  }
}
