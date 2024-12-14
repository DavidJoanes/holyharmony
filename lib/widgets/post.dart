import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'custom_video_player.dart';
import 'profile_pictures.dart';

class CustomPost extends StatefulWidget {
  CustomPost({
    super.key,
    required this.profileImage,
    required this.fullName,
    required this.timeOfPost,
    required this.category,
    required this.caption,
    required this.link,
    required this.commentsCount,
    required this.likeCount,
    required this.viewsCount,
    required this.follow,
    required this.expand,
    required this.alreadyLiked,
    required this.likePost,
    required this.download,
    required this.copy,
  });
  late String profileImage;
  late String fullName;
  late var timeOfPost;
  late String category;
  late String caption;
  late String link;
  late int commentsCount;
  late int likeCount;
  late int viewsCount;
  Function follow;
  Function expand;
  late bool alreadyLiked;
  Function likePost;
  Function download;
  VoidCallback copy;

  @override
  State<CustomPost> createState() => _CustomPostState();
}

class _CustomPostState extends State<CustomPost> {
  bool isVideo = false;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () async {
        await widget.expand();
      },
      child: Card(
        elevation: 0.5,
        child: SizedBox(
          width: size.width * 0.95,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ListTile(
                leading: UserProfilePicture(
                  radius: 20,
                  image: widget.profileImage,
                  onClicked: () {},
                ),
                title: Text(
                  widget.fullName,
                  style: GoogleFonts.archivo(
                      textStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                  )),
                ),
                subtitle: Row(
                  children: [
                    Text("${widget.timeOfPost} ago"),
                    const SizedBox(width: 2),
                    Container(
                      width: (size.width * 0.03 * widget.category.length),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: constantValues.darkColor2,
                        border: Border.all(
                            width: 1, color: constantValues.darkColor),
                      ),
                      child: Center(child: Text(widget.category)),
                    ),
                  ],
                ),
                // trailing: PopupMenuButton(
                //     tooltip: "Menu",
                //     onSelected: (value) async {
                //       if (value.toLowerCase() == "download") {
                //         await widget.download();
                //       } else {
                //         widget.copy();
                //       }
                //     },
                //     itemBuilder: (BuildContext context) {
                //       return [
                //         const PopupMenuItem(
                //           value: "Download",
                //           child: Text("Download"),
                //         ),
                //         const PopupMenuItem(
                //           value: "Copy",
                //           child: Text("Copy link"),
                //         ),
                //       ];
                //     }),
              ),
                        const SizedBox(width: 4),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: SizedBox(
                  width: size.width * 0.92,
                  child: Text(
                    widget.caption,
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.01),
              widget.link.startsWith("https")
                  ? Container(
                      width: size.width * 0.9,
                      height: size.height * 0.4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: constantValues.transparentColor,
                      ),
                      child: VideoPlayerScreen(
                        postLink: 'https://www.w3schools.com/html/mov_bbb.mp4',
                      ),
                    )
                  : Container(
                      width: size.width * 0.9,
                      height: size.height * 0.4,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: constantValues.transparentColor,
                          image: const DecorationImage(
                              scale: 2,
                              image:
                                  AssetImage("assets/images/who_are_you.png"),
                              fit: BoxFit.cover)),
                    ),
              SizedBox(height: size.height * 0.01),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(
                            onPressed: () async {
                              await widget.likePost();
                            },
                            icon: !widget.alreadyLiked
                                ? const Icon(Icons.favorite_outline_outlined)
                                : Icon(
                                    Icons.favorite,
                                    color: constantValues.errorColor,
                                  )),
                        const SizedBox(width: 2),
                        Text("${widget.commentsCount.round()}"),
                        const SizedBox(width: 20),
                        Row(
                          children: [
                            const Icon(Icons.message_outlined),
                            const SizedBox(width: 4),
                            Text("${widget.commentsCount}"),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.remove_red_eye_outlined),
                        const SizedBox(width: 4),
                        Text("${widget.viewsCount}"),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
