import 'package:astronomy_picture/custom_colors.dart';
import 'package:astronomy_picture/domain/entities/apod.dart';
import 'package:astronomy_picture/presentation/core/date_convert.dart';
import 'package:astronomy_picture/presentation/core/see_full_image.dart';
import 'package:astronomy_picture/presentation/widgets/today_apod/apod_video.dart';
import 'package:astronomy_picture/presentation/widgets/today_apod/apod_view_button.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver_plus/gallery_saver.dart';
import 'package:share_plus/share_plus.dart';

class ApodViewPage extends StatefulWidget {
  final Apod apod;
  const ApodViewPage({super.key, required this.apod});

  @override
  State<ApodViewPage> createState() => _ApodViewPageState();
}

class _ApodViewPageState extends State<ApodViewPage> {
  late Apod apod;
  bool isImage = true;
  String urlToShare = "";

  @override
  void initState() {
    super.initState();
    apod = widget.apod;
    checkMediaType();
  }

  void checkMediaType() {
    if (apod.mediaType == "video") {
      setState(() {
        isImage = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.white.withValues(alpha: 0.0),
        elevation: 0,
        actions: [
          PopupMenuButton<int>(
            icon: Icon(Icons.more_vert, color: CustomColors.white),
            color: CustomColors.black,
            itemBuilder: (context) => buildMenuButtons(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.center,
              end: Alignment.bottomCenter,
              colors: [CustomColors.spaceBlue, CustomColors.black],
            ),
          ),
          child: Column(
            children: [
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  ClipRRect(child: buildMediaType()),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30.0, 350.0, 30.0, 0.0),
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomLeft,
                          colors: [
                            CustomColors.blueDarker,
                            CustomColors.blueDarker,
                            CustomColors.blueLigth,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(30.0),
                        border: Border.all(
                          color: CustomColors.white.withValues(alpha: .3),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: CustomColors.blue.withValues(alpha: .7),
                            blurRadius: 10.0,
                            spreadRadius: 1.0,
                            offset: const Offset(0, 0),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            apod.title ?? "",
                            style: TextStyle(
                              fontSize: 22.0,
                              color: CustomColors.white,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            apod.explanation ?? "",
                            style: TextStyle(color: CustomColors.white),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "by ${apod.copyright ?? "NASA"}",
                            style: TextStyle(color: CustomColors.white),
                          ),
                          Text(
                            "Date ${DateConvert.dateToString(apod.date)} (YYYY-MM-DD)",
                            style: TextStyle(color: CustomColors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      ApodViewButton(
                        iconCustom: Icons.hd,
                        titleCustom: "Show media",
                        descriptionCustom: "Open media in browser",
                        onTapCustom: () {},
                      ),
                      const SizedBox(width: 15),
                      ApodViewButton(
                        iconCustom: Icons.bookmark_outline,
                        titleCustom: "Save",
                        descriptionCustom: "Add to favorites",
                        onTapCustom: () {},
                      ),
                      const SizedBox(width: 15),
                      ElevatedButton.icon(
                        onPressed: saveOnGallery,
                        icon: const Icon(Icons.download),
                        label: const Text('Download Image'),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(16),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildMediaType() {
    final double size = MediaQuery.of(context).size.width;

    final String backgroundUrl = isImage
        ? (apod.url ?? "")
        : (apod.thumbnailUrl ??
              "https://spaceplace.nasa.gov/gallery-space/en/NGC2336-galaxy.en.jpg");

    const borderRadius = BorderRadius.only(
      bottomLeft: Radius.circular(30.0),
      bottomRight: Radius.circular(30.0),
    );

    Widget content = Container(
      height: size,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(backgroundUrl),
          fit: BoxFit.cover,
        ),
        borderRadius: borderRadius,
        border: Border.all(color: CustomColors.white.withOpacity(.5)),
      ),
      child: !isImage ? Center(child: ApodVideo(url: apod.url ?? "")) : null,
    );

    if (isImage) {
      return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => SeeFullImage(url: apod.hdurl ?? apod.url ?? ""),
            ),
          );
        },
        child: content,
      );
    }

    return content;
  }

  List<PopupMenuItem<int>> buildMenuButtons() {
    return [
      if (isImage)
        PopupMenuItem(
          value: 1,
          onTap: saveOnGallery,
          child: Text(
            "Save Image on Gallery",
            style: TextStyle(color: CustomColors.white),
          ),
        ),
      PopupMenuItem(
        value: 2,
        onTap: shareOnlyLink,
        child: Text(
          "Share media link",
          style: TextStyle(color: CustomColors.white),
        ),
      ),
      PopupMenuItem(
        value: 3,
        onTap: sharedAllContent,
        child: Text(
          "Share All Content",
          style: TextStyle(color: CustomColors.white),
        ),
      ),
    ];
  }

  void saveOnGallery() {
    if (isImage) {
      GallerySaver.saveImage(apod.url ?? apod.hdurl ?? "").then((value) {
        if (value == true) {
          showSnackBar('Image saved on Gallery');
        }
      });
    }
  }

  void shareOnlyLink() {
    urlToShare = apod.url ?? apod.hdurl ?? "";
    if (urlToShare.isNotEmpty) {
      SharePlus.instance.share(ShareParams(text: urlToShare));
    }
  }

  void sharedAllContent() {
    urlToShare = apod.url ?? apod.hdurl ?? "";
    if (urlToShare.isNotEmpty) {
      SharePlus.instance.share(
        ShareParams(
          text:
              "${apod.title}\n${apod.explanation}\n\nlink: $urlToShare\n\nby: ${apod.copyright}",
        ),
      );
    }
  }

  void showSnackBar(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }
}
