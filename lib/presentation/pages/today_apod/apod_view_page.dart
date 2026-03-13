import 'package:astronomy_picture/custom_colors.dart';
import 'package:astronomy_picture/domain/entities/apod.dart';
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

  String _message = '';

  @override
  void initState() {
    apod = widget.apod;
    super.initState();
  }

  void checkMediaType() {
    if (apod.mediaType == "video") {
      isImage = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        // ignore: deprecated_member_use
        backgroundColor: Colors.white.withOpacity(0.0),
        elevation: 0,
        actions: [
          PopupMenuButton(
            icon: Icon(Icons.more_vert, color: CustomColors.white),
            color: CustomColors.black,
            itemBuilder: (context) => buildMenuButtons(),
          ), // PopupMenuButton
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
                      padding: EdgeInsets.all(20),
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
                          // ignore: deprecated_member_use
                          color: CustomColors.white.withOpacity(.3),
                        ),
                        boxShadow: [
                          BoxShadow(
                            // ignore: deprecated_member_use
                            color: CustomColors.blue.withOpacity(.7),
                            blurRadius: 10.0,
                            spreadRadius: 1.0,
                            offset: const Offset(0, 0),
                          ), // BoxShadow
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
                            ), // TextStyle
                          ), // Text
                          Text(
                            apod.explanation ?? "",
                            style: TextStyle(
                              color: CustomColors.white,
                            ), // TextStyle
                          ),
                          const SizedBox(width: 10),
                          Text(
                            "by ${apod.copyright ?? "Nasa"}",
                            style: TextStyle(
                              color: CustomColors.white,
                            ), // TextStyle
                          ), // Text
                          Text(
                            "date ${apod.date}",
                            style: TextStyle(
                              color: CustomColors.white,
                            ), // TextStyle
                          ), // Text
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ApodViewButton(
                      iconCustom: Icons.hd,
                      titleCustom: "Show media",
                      descriptionCustom:
                          "If mediia are not able on app. Tap here to view on browser",
                      onTapCustom: () {},
                    ),
                    const SizedBox(width: 15),
                    ApodViewButton(
                      iconCustom: Icons.bookmark_outline,
                      titleCustom: "Save",
                      descriptionCustom:
                          "Save this content for quick acess in future",
                      onTapCustom: () {},
                    ),
                    const SizedBox(height: 20),
                    const SizedBox(height: 12),
                    ElevatedButton.icon(
                      onPressed: saveOnGallery,
                      icon: const Icon(Icons.download),
                      label: const Text('Save Network Image'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(16),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildMediaType() {
    if (isImage) {
      return GestureDetector(
        onTap: () {},
        child: Container(
          height: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(apod.url ?? ""),
              fit: BoxFit.fitHeight,
            ),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(50),
              bottomRight: Radius.circular(50),
            ),
            // ignore: deprecated_member_use
            border: Border.all(color: CustomColors.white.withOpacity(.5)),
          ),
        ),
      );
    } else {
      return Container(
        height: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
              apod.hdurl ??
                  "https://spaceplace.nasa.gov/gallery-space/en/NGC2336-galaxy.en.jpg",
            ),
            fit: BoxFit.fitHeight,
          ),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(50),
            bottomRight: Radius.circular(50),
          ),
          // ignore: deprecated_member_use
          border: Border.all(color: CustomColors.white.withOpacity(.5)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [ApodVideo(url: apod.url ?? "")],
        ),
      );
    }
  }

  List<PopupMenuItem> buildMenuButtons() {
    List<PopupMenuItem> list = [];
    if (isImage) {
      list.add(
        PopupMenuItem(
          value: 1,
          onTap: saveOnGallery,
          child: Text(
            "Save Image on Gallery",
            style: TextStyle(color: CustomColors.white),
          ),
        ),
      );
    }
    list.addAll([
      PopupMenuItem(
        value: 2,
        onTap: shareOnlyLink,
        child: Text(
          "Share media only",
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
    ]);
    return list;
  }

  void saveOnGallery() {
    if (isImage) {
      GallerySaver.saveImage(apod.url ?? apod.hdurl ?? "").then((value) {
        if (value == true) {
          setState(() => showSnackBar('Image saved on Galery'));
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
              "${apod.title}\n${apod.explanation}\n\nlink:$urlToShare\n\nby:${apod.copyright}",
        ),
      );
    }
  }

  void showSnackBar(String msg) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
    });
  }
}
