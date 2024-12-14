import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icon.dart';

import '../controllers/constants.dart';
import '../controllers/responsive.dart';
import '../widgets/input_fields.dart';
import '../widgets/profile_pictures.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  final constantValues = Get.find<Constants>();
  var userInfo = GetStorage();
  Dio dio = Dio();
  TextEditingController searchController = TextEditingController();
  late List searchResults = [1,2];
  late List topPosts = [1];
  late List latestPosts = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
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
      child: Text("Explore"),
    );
  }

  Widget isTablet(BuildContext context, Size size) {
    return const Center(
      child: Text("Explore"),
    );
  }

  Widget isMobile(BuildContext context, Size size) {
    return Column(
      children: [
        SizedBox(height: size.height * 0.02),
        SearchField(
          controller: searchController,
          width: size.width * 0.9,
          title: "Search for Artists/Ministries",
          icon: const LineIcon.search(),
          onPressed: () {},
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: Divider(),
        ),
        searchResults.isNotEmpty
            ? SizedBox(
              height: size.height,
                child: RefreshIndicator(
                  onRefresh: refreshTop,
                  child: ListView.builder(
                      itemCount: topPosts.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: size.height * 0.01,
                                horizontal: size.width * 0.02),
                            child: ListTile(
                              leading: UserProfilePicture(
                                radius: 25,
                                image: "assets/images/zane.png",
                                onClicked: () {},
                              ),
                              title: Text(
                                "Zane Kessler",
                                style: GoogleFonts.archivo(
                                    textStyle: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                )),
                              ),
                              subtitle: const Text("@zanekess"),
                              onTap: () {},
                            ));
                      }),
                ),
              )
            : Padding(
                padding: EdgeInsets.symmetric(vertical: size.height * 0.25),
                child: Center(
                  child: Column(
                    children: [
                      LineIcon.trash(size: size.width * 0.1),
                      const SizedBox(height: 10),
                      const Text("No record(s) yet..")
                    ],
                  ),
                ),
              )
      ],
    );
  }

  Future<void> refreshTop() async {
    await fetchTopPosts();
  }

  Future<void> refreshLatest() async {
    await fetchLatestPosts();
  }

  fetchTopPosts() async {}

  fetchLatestPosts() async {}
}
