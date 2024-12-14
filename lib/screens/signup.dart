import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

import '/screens/signup01.dart';
import '/screens/signup02.dart';
import '/screens/signup03.dart';
import '../controllers/constants.dart';
import '../controllers/responsive.dart';
import '../widgets/buttons.dart';
import '../widgets/custom_app_bars.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final constantValues = Get.find<Constants>();
  var userInfo = GetStorage();
  Dio dio = Dio();
  final PageController pageController = PageController();
  int currentPage = 0;
  bool isLastPage = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController ministryController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  late List<String> selectedInterests = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    ministryController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    var mainFont = GoogleFonts.archivo(
        textStyle: TextStyle(
            fontSize: size.width * 0.02,
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
          child: Responsive(
              isExtraLargeScreen:
                  isExtraLargeScreen(context, size, mainFont, subFont),
              isTablet: isTablet(context, size, mainFont, subFont),
              isMobile: isMobile(context, size, mainFont, subFont))),
    );
  }

  Widget isExtraLargeScreen(
      BuildContext context, Size size, var font1, var font2) {
    return const Text("");
  }

  Widget isTablet(BuildContext context, Size size, var font1, var font2) {
    return const Text("");
  }

  Widget isMobile(BuildContext context, Size size, var font1, var font2) {
    return Stack(
      alignment: AlignmentDirectional.topCenter,
      children: [
        PageView(
          controller: pageController,
          onPageChanged: (index) {
            setState(() {
              currentPage = index;
              isLastPage = (index == 2);
            });
          },
          children: [
            const WhoAreYou(),
            AccountCreation(
              formKey: _formKey,
              firstNameController: firstNameController,
              lastNameController: lastNameController,
              ministryNameController: ministryController,
              emailController: emailController,
              passwordController: passwordController,
              confirmPasswordController: confirmPasswordController,
            ),
            YourInterests(selectedInterests: selectedInterests)
          ],
        ),
        currentPage == 0
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: size.height * 0.82),
                  ButtonA2(
                      width: size.width * 0.9,
                      bgColor: constantValues.primaryColor,
                      textColor: constantValues.whiteColor,
                      text: "Continue",
                      authenticate: () async {
                        if (currentPage == 0) {
                          if (userInfo.read("tempRole") != "") {
                            pageController.nextPage(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeIn);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                customSnackBar("Pick a category!"));
                          }
                        }
                      }),
                ],
              )
            : currentPage == 1
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: size.height * 0.72),
                      ButtonA(
                        width: size.width * 0.9,
                        bgColor: constantValues.primaryColor,
                        textColor: constantValues.whiteColor,
                        text: "Sign Up",
                        authenticate: () async {
                          await signup();
                          pageController.nextPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeIn);
                        },
                      ),
                      SizedBox(height: size.height * 0.02),
                      ButtonB(
                          width: size.width * 0.9,
                          bgColor: constantValues.transparentColor,
                          textColor: constantValues.whiteColor,
                          text: "Sign Up with Google",
                          authenticate: () async {
                            pageController.previousPage(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeOutBack);
                          }),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: size.height * 0.82),
                      ButtonA2(
                          width: size.width * 0.9,
                          bgColor: constantValues.primaryColor,
                          textColor: constantValues.whiteColor,
                          text: "Complete",
                          authenticate: () async {
                            if (currentPage == 2) {
                              if (selectedInterests.isNotEmpty) {
                                pageController.nextPage(
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.easeIn);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    customSnackBar(
                                        "You're required to select at least one interest!"));
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  customSnackBar(
                                      "Credentials cannot be blank!"));
                            }
                          }),
                    ],
                  )
      ],
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

  signup() async {
    final checkForm = _formKey.currentState!;
    if (checkForm.validate()) {}
  }
}
