import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../controllers/constants.dart';
import '../controllers/responsive.dart';
import '../widgets/post.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
    return Responsive(
        isExtraLargeScreen: isExtraLargeScreen(context, size),
        isTablet: isTablet(context, size),
        isMobile: isMobile(context, size));
  }

  Widget isExtraLargeScreen(BuildContext context, Size size) {
    return const Center(
      child: Text("Home"),
    );
  }

  Widget isTablet(BuildContext context, Size size) {
    return const Center(
      child: Text("Home"),
    );
  }

  Widget isMobile(BuildContext context, Size size) {
    return Column(
      children: [
        SizedBox(height: size.height * 0.02),
        CustomPost(
          profileImage: "assets/images/zane.png",
          fullName: "Zane Kessler",
          timeOfPost: "2d",
          category: "Sermon",
          caption: "Reminiscing about service earlier..",
          link: "https://www.w3schools.com/html/mov_bbb.mp4",
          commentsCount: 24,
          likeCount: 96,
          viewsCount: 322,
          follow: () {},
          expand: () {},
          alreadyLiked: true,
          likePost: () {},
          download: () {},
          copy: () {},
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: Divider(),
        ),
        CustomPost(
          profileImage: "assets/images/zane.png",
          fullName: "Zane Kessler",
          timeOfPost: "2d",
          category: "Sermon",
          caption: "Reminiscing about service earlier..",
          link: "",
          commentsCount: 24,
          likeCount: 96,
          viewsCount: 322,
          follow: () {},
          expand: () {},
          alreadyLiked: true,
          likePost: () {},
          download: () {},
          copy: () {},
        ),
        SizedBox(height: size.height * 0.05),
      ],
    );
  }
}
