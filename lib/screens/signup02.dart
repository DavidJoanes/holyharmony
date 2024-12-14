import 'package:dio/dio.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/constants.dart';
import '../controllers/responsive.dart';
import '../widgets/input_fields.dart';
import '../widgets/password_fields.dart';

class AccountCreation extends StatefulWidget {
  AccountCreation({
    super.key,
    required this.formKey,
    required this.firstNameController,
    required this.lastNameController,
    required this.ministryNameController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
  });
  late GlobalKey formKey;
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController ministryNameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  @override
  State<AccountCreation> createState() => _AccountCreationState();
}

class _AccountCreationState extends State<AccountCreation> {
  final constantValues = Get.find<Constants>();
  var userInfo = GetStorage();
  Dio dio = Dio();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    var mainFont = GoogleFonts.archivo(
        textStyle: TextStyle(
            fontSize: size.width * 0.05,
            color: constantValues.whiteColor,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.normal));
    var subFont = GoogleFonts.archivo(
        textStyle: TextStyle(
            color: constantValues.whiteColor,
            fontSize: size.width * 0.04,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal));
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Responsive(
          isExtraLargeScreen:
              isExtraLargeScreen(context, size, mainFont, subFont),
          isTablet: isTablet(context, size, mainFont, subFont),
          isMobile: isMobile(context, size, mainFont, subFont)),
    );
  }

  Widget isExtraLargeScreen(
      BuildContext context, Size size, var font1, var font2) {
    return const Column(
      children: [],
    );
  }

  Widget isTablet(BuildContext context, Size size, var font1, var font2) {
    return const Column(
      children: [],
    );
  }

  Widget isMobile(BuildContext context, Size size, var font1, var font2) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.025),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: size.height * 0.02),
          SizedBox(
            width: size.width * 0.6,
            child: Text(
              constantValues.signupText,
              style: font1,
              textAlign: TextAlign.center,
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(height: size.height * 0.04),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.02, vertical: size.height * 0.05),
            child: Column(
              children: [
                userInfo.read("tempRole") != "ministry"
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(constantValues.signupText2, style: font2),
                          SizedBox(height: size.height * 0.02),
                          InputFieldA(
                            controller: widget.firstNameController,
                            width: size.width * 0.9,
                            title: "First Name",
                            enabled: true,
                            autoFillHint: const [AutofillHints.name],
                          ),
                          SizedBox(height: size.height * 0.02),
                          InputFieldA(
                            controller: widget.lastNameController,
                            width: size.width * 0.9,
                            title: "Last Name",
                            enabled: true,
                            autoFillHint: const [AutofillHints.name],
                          ),
                        ],
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(constantValues.signupText2, style: font2),
                          SizedBox(height: size.height * 0.02),
                          InputFieldA(
                            controller: widget.ministryNameController,
                            width: size.width * 0.9,
                            title: "Ministry Name",
                            enabled: true,
                            autoFillHint: const [AutofillHints.name],
                          ),
                        ],
                      ),
                Form(
                  key: widget.formKey,
                  child: Column(
                    children: [
                      SizedBox(height: size.height * 0.02),
                      EmailFieldA(
                        controller: widget.emailController,
                        width: size.width * 0.9,
                        title: "Email Address",
                      ),
                      SizedBox(height: size.height * 0.02),
                      PasswordFieldB1(
                        controller: widget.passwordController,
                        width: size.width * 0.9,
                        title: "Password",
                      ),
                      SizedBox(height: size.height * 0.02),
                      PasswordFieldB2(
                        controller: widget.confirmPasswordController,
                        controller2: widget.passwordController,
                        width: size.width * 0.9,
                        title: "Retype your password",
                      ),
                      SizedBox(height: size.height * 0.02),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                            style: GoogleFonts.archivo(
                                textStyle: TextStyle(
                              color: userInfo.read("isDarkTheme")
                                  ? constantValues.whiteColor2
                                  : constantValues.darkColor,
                            )),
                            children: [
                              TextSpan(
                                text: constantValues.alreadyHaveAccount,
                              ),
                              TextSpan(
                                  text: constantValues.alreadyHaveAccount2,
                                  style: GoogleFonts.archivo(
                                      textStyle: TextStyle(
                                          color: constantValues.primaryColor,
                                          fontWeight: FontWeight.w500)),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      context.goNamed("signin");
                                    }),
                            ]),
                      ),
                      SizedBox(height: size.height * 0.02),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                              style: GoogleFonts.archivo(
                                  textStyle: TextStyle(
                                color: userInfo.read("isDarkTheme")
                                    ? constantValues.whiteColor2
                                    : constantValues.darkColor,
                              )),
                              children: [
                                const TextSpan(
                                  text: "By signing up, you agree to our ",
                                ),
                                TextSpan(
                                    text: "Terms & Conditions ",
                                    style: GoogleFonts.archivo(
                                        textStyle: TextStyle(
                                            color: constantValues.primaryColor,
                                            fontWeight: FontWeight.w400)),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {}),
                                const TextSpan(
                                  text: "as well as our ",
                                ),
                                TextSpan(
                                    text: "Privacy Policy.",
                                    style: GoogleFonts.archivo(
                                        textStyle: TextStyle(
                                            color: constantValues.primaryColor,
                                            fontWeight: FontWeight.w400)),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {}),
                              ]),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: size.height * 0.2),
        ],
      ),
    );
  }
}
