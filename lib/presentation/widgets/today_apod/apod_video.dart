import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:vimeo_video_player/vimeo_video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

enum VideoPlataform { standard, youtube, vimeo, network }

class ApodVideo extends StatefulWidget {
  final String url;
  const ApodVideo({super.key, required this.url});

  @override
  State<ApodVideo> createState() => _ApodVideoState();
}

class _ApodVideoState extends State<ApodVideo> {
  VideoPlataform videoPlataform = VideoPlataform.standard;
  VideoPlayerController? videoPlayerController;
  YoutubePlayerController? youtubePlayerController;

  String normalizeUrl(String url) {
    if (url.startsWith('//')) {
      return 'https:$url';
    }
    return url;
  }

  @override
  void initState() {
    super.initState();
    checkVideoPlataform();
  }

  @override
  void dispose() {
    videoPlayerController?.dispose();
    youtubePlayerController?.dispose();
    super.dispose();
  }

  void checkVideoPlataform() {
    final String rawUrl = widget.url;
    final String url = normalizeUrl(rawUrl);

    if (url.startsWith("https://www.youtube.com") ||
        url.startsWith("https://youtu.be")) {
      videoPlataform = VideoPlataform.youtube;

      youtubePlayerController = YoutubePlayerController(
        initialVideoId: YoutubePlayer.convertUrlToId(url) ?? "",
        flags: const YoutubePlayerFlags(autoPlay: false),
      );

      setState(() {});
    } else if (url.startsWith("https://vimeo.com")) {
      videoPlataform = VideoPlataform.vimeo;
      setState(() {});
    } else if (isDirectVideo(url)) {
      videoPlataform = VideoPlataform.network;

      videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(url))
        ..initialize()
            .then((_) {
              if (mounted) {
                setState(() {});
                videoPlayerController?.play();
                videoPlayerController?.setLooping(true);
              }
            })
            .catchError((error) {
              debugPrint("Error loading video: $error");
            });

      setState(() {});
    } else {
      videoPlataform = VideoPlataform.standard;

      debugPrint("Video format not supported.: $url");
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    switch (videoPlataform) {
      case VideoPlataform.youtube:
        return youtubePlayerController != null
            ? YoutubePlayer(controller: youtubePlayerController!)
            : const Center(child: CircularProgressIndicator());

      case VideoPlataform.vimeo:
        return VimeoVideoPlayer(url: widget.url, autoPlay: false);

      case VideoPlataform.network:
        if (videoPlayerController != null &&
            videoPlayerController!.value.isInitialized) {
          return AspectRatio(
            aspectRatio: videoPlayerController!.value.aspectRatio,
            child: VideoPlayer(videoPlayerController!),
          );
        }
        return const Center(child: CircularProgressIndicator());

      default:
        return const Center(child: CircularProgressIndicator());
    }
  }
}

String extractYoutubeId(String url) {
  final uri = Uri.parse(url);

  if (uri.pathSegments.contains('embed')) {
    return uri.pathSegments.last;
  }

  return YoutubePlayer.convertUrlToId(url) ?? '';
}

bool isDirectVideo(String url) {
  return url.endsWith('.mp4') || url.contains('.mp4?');
}
