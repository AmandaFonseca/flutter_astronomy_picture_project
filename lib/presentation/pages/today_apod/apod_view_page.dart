import 'package:astronomy_picture/custom_colors.dart';
import 'package:astronomy_picture/domain/entities/apod.dart';
import 'package:astronomy_picture/presentation/widgets/today_apod/apod_video.dart';
import 'package:astronomy_picture/presentation/widgets/today_apod/apod_view_button.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver_plus/gallery_saver.dart';

class ApodViewPage extends StatefulWidget {
  final Apod apod;
  const ApodViewPage({super.key, required this.apod});

  @override
  State<ApodViewPage> createState() => _ApodViewPageState();
}

class _ApodViewPageState extends State<ApodViewPage> {
  late Apod apod;
  bool isImage = true;

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
          // PopupMenuButton(
          //   icon: Icon(Icons.more_vert, color: CustomColors.white),
          //   color: CustomColors.black,
          //   itemBuilder: (context) => _saveNetworkImage(),
          // ), // PopupMenuButton
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
                      titleCustom: "Image in HD",
                      descriptionCustom:
                          "Images may be incomplete! Tap here to view full image",
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
                      onPressed: _saveOnGallery,
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
          textStyle: TextStyle(color: CustomColors.white),
          onTap: saveOnGallery,
          child: Text("Save Image on Gallery"),
        ),
      );
    }
    list.addAll([
      PopupMenuItem(
        textStyle: TextStyle(color: CustomColors.white),
        onTap: shareOnlyLink,
        child: const Text("Share media only"),
      ), // PopupMenuItem
      PopupMenuItem(
        textStyle: TextStyle(color: CustomColors.white),
        onTap: sharedAllContent,
        child: const Text("Share All Content"),
      ), // PopupMenuItem
    ]);
  }

  void saveOnGallery() {
    if (isImage) {
      GallerySaver.saveImage(apod.url ?? apod.hdurl ?? "").then((value) {
        if (value == true) {
          setState(() => showSnackBar('Image save on Galery'));
        }
      });
    }
  }

  void shareOnlyLink() {}
  void sharedAllContent() {}

  void showSnackBar(String msg) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
    });
  }
}
