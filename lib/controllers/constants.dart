import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Constants extends GetxController {
  // Colors
  Map<int, Color> defaultColor = {
    50: const Color(0xFFE8F5E9),
    100: const Color(0xFFC8E6C9),
    200: const Color(0xFFA5D6A7),
    300: const Color(0xFF81C784),
    400: const Color(0xFF66BB6A),
    500: Colors.green,
    600: const Color(0xFF43A047),
    700: const Color(0xFF388E3C),
    800: const Color(0xFF2E7D32),
    900: const Color(0xFF1B5E20),
  };
  var primaryColor = Colors.green;
  var secondaryColor = const Color(0xFF81C784);
  var secondaryColor2 = const Color.fromARGB(47, 129, 199, 132);
  var bgColor = const Color.fromARGB(255, 15, 24, 16);
  var bgColor2 = const Color.fromARGB(255, 18, 28, 19);
  var whiteColor = Colors.white;
  var whiteColor2 = const Color.fromARGB(255, 234, 234, 234);
  var transparentColor = Colors.transparent;
  var errorColor = const Color.fromARGB(255, 232, 33, 19);
  var darkColor = const Color.fromARGB(255, 23, 23, 23);
  var darkColor2 = const Color.fromARGB(169, 44, 44, 44);
  var bodyTextColor = const Color.fromARGB(255, 46, 46, 46);
  var appVersion = "1.10";

  //SIGN IN
  String signinText = "Sign In";
  String signinSubText = "Welcome back! Let's pick up from where you left.";
  String remember = "Remember me";
  String dontHaveAccount = "Dont have an account ?  ";
  String dontHaveAccount2 = "Sign Up";
  String forgotPassword = "Forgot your password ?  ";
  String forgotPassword2 = "Click here";
  //WHO ARE YOU
  String whoareyouText = "Who Are You";
  String whoareyouSubText =
      "This would assist us to adequately currate your experience.";
  String memberText = "Member";
  String memberSubText =
      "Discover contents that suit your beliefs and interests";
  String artistText = "Artist";
  String artistSubText = "Upload and track your contents";
  String ministryText = "Ministry";
  String ministrySubText = "Build bridges of faith with your content";
  //SIGN UP
  String signupText =
      "Join HolyHarmony to Connect with Believers through Uplifting Videos and Reviews.";
  String signupText2 = "Create Your Account";
  String alreadyHaveAccount = "Got an account already ?  ";
  String alreadyHaveAccount2 = "Sign In";
  String termsAndCondition =
      "By signing up, you agree to our Terms and Conditions as well as our Privacy Policy";
  //YOUR INTEREST
  String yourInterestText = "What Are Your Interests";
  //ARTIST PROFILE EDIT
  String artistProfileText = "Performer";
  String artistProfileSubText =
      "Tell us a bit about yourself and your music taste.";
  //ARTIST INSIGHTS
  String insightText1 = "Performer's Insight";
  String performerStatus = "Active";
  String insightText2 = "Booking Trends";
}
