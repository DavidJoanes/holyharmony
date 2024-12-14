import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:video_player/video_player.dart';

import '../controllers/constants.dart';

class VideoPlayerScreen extends StatefulWidget {
  VideoPlayerScreen({super.key, required this.postLink});
  late String postLink;

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  final constantValues = Get.find<Constants>();
  var userInfo = GetStorage();
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    // Initialize the video player with a network URL (can also be a local asset)
    _controller = VideoPlayerController.asset(
      widget.postLink,
    );

    // Initialize the video player asynchronously
    _initializeVideoPlayerFuture = _controller.initialize();

    // Set looping and autoplay properties
    _controller.setLooping(true);
    _controller.play();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose(); // Don't forget to dispose the controller
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<void>(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          // Check if the video is initialized
          if (snapshot.connectionState == ConnectionState.done) {
            return Stack(
              alignment: Alignment.center,
              children: [
                // Display the video
                AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                ),
                // Controls for Play/Pause button
                Positioned(
                  height: 100,
                  left: 210,
                  child: CircleAvatar(
                    backgroundColor: constantValues.darkColor2,
                    child: IconButton(
                      icon: Icon(
                        _controller.value.isPlaying
                            ? Icons.pause
                            : Icons.play_arrow,
                      ),
                      onPressed: () {
                        setState(() {
                          if (_controller.value.isPlaying) {
                            _controller.pause();
                          } else {
                            _controller.play();
                          }
                        });
                      },
                    ),
                  ),
                ),
              ],
            );
          } else {
            // Display loading indicator while the video is loading
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
