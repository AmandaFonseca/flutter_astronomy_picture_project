import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:vimeo_video_player/vimeo_video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ApodVideo extends StatefulWidget {
  final String url;
  const ApodVideo({super.key, required this.url});

  @override
  State<ApodVideo> createState() => _ApodVideoState();
}

class _ApodVideoState extends State<ApodVideo> {
  late String url;
  VideoPlataform videoPlataform = VideoPlataform.standard;

  VideoPlayerController? videoPlayerController;
  YoutubePlayerController? youtubePlayerController;

  @override
  void initState() {
    super.initState();
    url = widget.url;
    checkVideoPlataform();
  }

  @override
  Widget build(BuildContext context) {
    return buildVideoPlayer();
  }

  void checkVideoPlataform() {
    String youtubeHost = "https://www.youtube.com";
    String vimeoHost = "https://vimeo.com";
    if (url.substring(0, youtubeHost.length) == youtubeHost) {
      videoPlataform = VideoPlataform.youtube;
      youtubePlayerController = YoutubePlayerController(
        initialVideoId: YoutubePlayer.convertUrlToId(url) ?? "",
        flags: YoutubePlayerFlags(autoPlay: false),
      );
      setState(() {});
    } else if (url.substring(0, vimeoHost.length) == vimeoHost) {
      videoPlataform = VideoPlataform.vimeo;
    } else {
      videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(url))
        ..initialize().then((_) {
          setState(() {});
        });
    }
  }

  Widget buildVideoPlayer() {
    Widget videoWidget;
    if (videoPlataform == VideoPlataform.youtube) {
      videoWidget = YoutubePlayer(controller: youtubePlayerController!);
    } else if (videoPlataform == VideoPlataform.vimeo) {
      videoWidget = VimeoVideoPlayer(url: url, autoPlay: false);
      if (videoPlayerController!.value.hasError) {
        videoWidget = const Text(
          "Sorry! We can't play this video. Try open in your browser",
        );
      }
    } else {
      videoWidget = videoPlayerController!.value.isInitialized
          ? AspectRatio(
              aspectRatio: videoPlayerController!.value.aspectRatio,
              child: VideoPlayer(videoPlayerController!),
            )
          : Container();
    }
    return videoWidget;
  }
}

enum VideoPlataform { standard, youtube, vimeo }
