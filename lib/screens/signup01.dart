import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/constants.dart';
import '../controllers/responsive.dart';

class WhoAreYou extends StatefulWidget {
  const WhoAreYou({super.key});

  @override
  State<WhoAreYou> createState() => _WhoAreYouState();
}

class _WhoAreYouState extends State<WhoAreYou> {
  final constantValues = Get.find<Constants>();
  var userInfo = GetStorage();
  Dio dio = Dio();
  late bool tab0 = userInfo.read("tempRole") == "member" ? true : false;
  late bool tab1 = userInfo.read("tempRole") == "artist" ? true : false;
  late bool tab2 = userInfo.read("tempRole") == "ministry" ? true : false;

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
            fontWeight: FontWeight.w300,
            fontStyle: FontStyle.normal));
    return SingleChildScrollView(
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
        children: [
          SizedBox(height: size.height * 0.02),
          Text(constantValues.whoareyouText, style: font1),
          SizedBox(
            width: size.width * 0.6,
            child: Text(constantValues.whoareyouSubText,
                style: font2, textAlign: TextAlign.center, maxLines: 3),
          ),
          SizedBox(height: size.height * 0.04),
          CircleAvatar(
            radius: size.width * 0.15,
            backgroundColor: constantValues.transparentColor,
            backgroundImage: const AssetImage("assets/images/who_are_you.png"),
          ),
          SizedBox(height: size.height * 0.02),
          Column(
            children: [
              customCategory(
                  context,
                  size,
                  size.width * 0.9,
                  Icons.person_outline_outlined,
                  constantValues.memberText,
                  constantValues.memberSubText,
                  tab0, () {
                setState(() {
                  tab0 = true;
                  tab1 = false;
                  tab2 = false;
                  userInfo.write("tempRole", "member");
                });
              }),
              SizedBox(height: size.height * 0.02),
              customCategory(
                  context,
                  size,
                  size.width * 0.9,
                  Icons.mic_outlined,
                  constantValues.artistText,
                  constantValues.artistSubText,
                  tab1, () {
                setState(() {
                  tab0 = false;
                  tab1 = true;
                  tab2 = false;
                  userInfo.write("tempRole", "artist");
                });
              }),
              SizedBox(height: size.height * 0.02),
              customCategory(
                  context,
                  size,
                  size.width * 0.9,
                  Icons.other_houses_outlined,
                  constantValues.ministryText,
                  constantValues.ministrySubText,
                  tab2, () {
                setState(() {
                  tab0 = false;
                  tab1 = false;
                  tab2 = true;
                  userInfo.write("tempRole", "ministry");
                });
              }),
            ],
          ),
        ],
      ),
    );
  }

  Widget customCategory(
      BuildContext context,
      var size,
      double width,
      IconData icon,
      String title,
      String subTitle,
      bool selectedTab,
      Function onClicked) {
    return SizedBox(
      width: width,
      child: Card(
        child: ListTile(
          horizontalTitleGap: size.width * 0.03,
          minVerticalPadding: size.height * 0.025,
          leading: Icon(icon,
              color: constantValues.secondaryColor, size: size.width * 0.05),
          title: Text(title,
              style: GoogleFonts.archivo(
                  textStyle: const TextStyle(fontWeight: FontWeight.bold))),
          subtitle: Text(subTitle,
              style: GoogleFonts.archivo(textStyle: const TextStyle())),
          tileColor: selectedTab
              ? constantValues.secondaryColor2
              : constantValues.transparentColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(
                width: 2,
                color: selectedTab
                    ? constantValues.secondaryColor
                    : constantValues.transparentColor),
          ),
          onTap: () {
            onClicked();
          },
        ),
      ),
    );
  }
}
