import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../controllers/constants.dart';
import '../widgets/custom_app_bars.dart';
import 'explore.dart';
import 'home_page.dart';

class HomePageFrame extends StatefulWidget {
  const HomePageFrame({super.key});

  @override
  State<HomePageFrame> createState() => _HomePageFrameState();
}

class _HomePageFrameState extends State<HomePageFrame> {
  final constantValues = Get.find<Constants>();
  var userInfo = GetStorage();
  Dio dio = Dio();
  int currentTab = 0;

  List pages = const [
    HomePage(),
    ExplorePage(),
    Center(
      child: Text("Notifications"),
    ),
    Center(
      child: Text("Profile"),
    ),
  ];

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
    return Scaffold(
      appBar: userInfo.read("currentTab") == 0
          ? homeAppBar(context, size)
          : userInfo.read("currentTab") == 1
              ? defaultAppBar(context, size, "Explore")
              : userInfo.read("currentTab") == 2
                  ? defaultAppBar(context, size, "Notifications")
                  : defaultAppBar(context, size, "Profile"),
      body: SafeArea(
        child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: pages[userInfo.read("currentTab")]),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: BottomNavigationBar(
          currentIndex: userInfo.read("currentTab"),
          onTap: (index) {
            setState(() {
              userInfo.write("currentTab", index);
            });
          },
          selectedItemColor: constantValues.whiteColor,
          unselectedItemColor: Colors.grey,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined), label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.explore_outlined), label: "Explore"),
            BottomNavigationBarItem(
                icon: Icon(Icons.notifications_outlined),
                label: "Notifications"),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_outlined), label: "Profile"),
          ],
        ),
      ),
    );
  }
}
