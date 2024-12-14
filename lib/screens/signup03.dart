import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_select_items/flutter_multi_select_items.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/constants.dart';
import '../controllers/responsive.dart';

class YourInterests extends StatefulWidget {
  YourInterests({super.key, required this.selectedInterests});
  late List<String> selectedInterests = [];

  @override
  State<YourInterests> createState() => _YourInterestsState();
}

class _YourInterestsState extends State<YourInterests> {
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
    return SingleChildScrollView(
      child: Responsive(
          isExtraLargeScreen: isExtraLargeScreen(context, size, mainFont),
          isTablet: isTablet(context, size, mainFont),
          isMobile: isMobile(context, size, mainFont)),
    );
  }

  Widget isExtraLargeScreen(BuildContext context, Size size, var font1) {
    return const Column(
      children: [],
    );
  }

  Widget isTablet(BuildContext context, Size size, var font1) {
    return const Column(
      children: [],
    );
  }

  Widget isMobile(BuildContext context, Size size, var font1) {
    return Column(
      children: [
        SizedBox(height: size.height * 0.02),
        SizedBox(
          width: size.width * 0.4,
          child: Text(
            constantValues.yourInterestText,
            style: font1,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: size.height * 0.04),
        Padding(
          padding: EdgeInsets.symmetric(
              vertical: size.height * 0.1, horizontal: size.width * 0.025),
          child: SizedBox(
            width: size.width,
            child: MultiSelectContainer(
                maxSelectableCount: 8,
                items: [
                  MultiSelectCard(value: 'Sermons', label: 'Sermons'),
                  MultiSelectCard(value: 'Movies', label: 'Movies'),
                  MultiSelectCard(value: 'Outreach', label: 'Outreach'),
                  MultiSelectCard(value: 'Fusion', label: 'Fusion'),
                  MultiSelectCard(value: 'Weddings', label: 'Weddings'),
                  MultiSelectCard(
                      value: 'Anniversaries', label: 'Anniversaries'),
                  MultiSelectCard(value: 'Podcasts', label: 'Podcasts'),
                  MultiSelectCard(
                      value: 'Baby Christening', label: 'Baby Christening'),
                  MultiSelectCard(
                      value: 'Child Dedication', label: 'Child Dedication'),
                  MultiSelectCard(
                      value: 'Marital Classes', label: 'Marital Classes'),
                ],
                onMaximumSelected: (items, item) {
                  ScaffoldMessenger.of(context).showSnackBar(customSnackBar(
                      "You're only allowed to select a maximum of eight interests!"));
                },
                onChange: (allSelectedItems, selectedItem) {
                  setState(() {
                    widget.selectedInterests = allSelectedItems;
                  });
                }),
          ),
        ),
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
}
