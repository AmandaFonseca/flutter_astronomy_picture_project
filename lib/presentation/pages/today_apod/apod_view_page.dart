import 'package:astronomy_picture/container_injection.dart';
import 'package:astronomy_picture/core/success.dart';
import 'package:astronomy_picture/custom_colors.dart';
import 'package:astronomy_picture/domain/entities/apod.dart';
import 'package:astronomy_picture/l10n/app_localizations.dart';
import 'package:astronomy_picture/presentation/bloc/bookmark/bookmark_apod_bloc.dart';
import 'package:astronomy_picture/presentation/core/date_convert.dart';
import 'package:astronomy_picture/presentation/core/see_full_image.dart';
import 'package:astronomy_picture/presentation/widgets/today_apod/apod_video.dart';
import 'package:astronomy_picture/presentation/widgets/today_apod/apod_view_button.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver_plus/gallery_saver.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class ApodViewPage extends StatefulWidget {
  final Apod apod;
  const ApodViewPage({super.key, required this.apod});

  @override
  State<ApodViewPage> createState() => _ApodViewPageState();
}

class _ApodViewPageState extends State<ApodViewPage> {
  late Apod apod;
  late BookmarkApodBloc _bookmarkApodBloc;
  IconData iconSave = Icons.bookmark_border;

  bool isImage = true;
  String urlToShare = "";

  @override
  void initState() {
    apod = widget.apod;
    _bookmarkApodBloc = getIt<BookmarkApodBloc>();
    _bookmarkApodBloc.input.add(
      IsSaveBookmarkApodEvent(date: DateConvert.dateToString(apod.date)),
    );
    checkMediaType();
    super.initState();
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
          PopupMenuButton(
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
                  Hero(
                    tag: 'apod-${apod.date.toString()}',
                    child: ClipRRect(child: buildMediaType()),
                  ),
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
              const SizedBox(height: 20.0),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ApodViewButton(
                      iconCustom: Icons.open_in_browser,
                      titleCustom: AppLocalizations.of(context)!.showMedia,
                      descriptionCustom: AppLocalizations.of(
                        context,
                      )!.showMediaDescription,
                      onTapCustom: _launchInBrowser,
                    ),
                    const SizedBox(width: 15),
                    StreamBuilder(
                      stream: _bookmarkApodBloc.stream,
                      builder: (context, snapshot) {
                        final state = snapshot.data;

                        if (state is LocalAccessSuccessBookmarkApodState) {
                          if (state.msg == ApodSaved().msg) {
                            if (iconSave.codePoint !=
                                Icons.bookmark.codePoint) {
                              showSnackBar(state.msg);
                              iconSave = Icons.bookmark;
                            }
                          } else {
                            if (iconSave != Icons.bookmark_border) {
                              showSnackBar(state.msg);
                              iconSave = Icons.bookmark_border;
                            }
                          }
                        }

                        if (state is IsSaveBookmarkApodState) {
                          if (state.wasSave) {
                            iconSave = Icons.bookmark;
                          }
                        }

                        return ApodViewButton(
                          iconCustom: iconSave,
                          titleCustom: AppLocalizations.of(context)!.save,
                          descriptionCustom: AppLocalizations.of(
                            context,
                          )!.saveDescription,
                          onTapCustom: () {
                            if (iconSave.codePoint ==
                                Icons.bookmark_border.codePoint) {
                              _bookmarkApodBloc.input.add(
                                SaveBookmarkApodEvent(apod: apod),
                              );
                            } else {
                              _bookmarkApodBloc.input.add(
                                RemoveSaveBookmarkApodEvent(
                                  date: DateConvert.dateToString(apod.date),
                                ),
                              );
                            }
                          },
                        );
                      },
                    ),
                  ],
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

    const fallbackImage =
        "https://spaceplace.nasa.gov/gallery-space/en/NGC2336-galaxy.en.jpg";

    String safeImageUrl() {
      if (isImage) {
        return apod.url?.isNotEmpty == true ? apod.url! : fallbackImage;
      } else {
        return apod.thumbnailUrl?.isNotEmpty == true
            ? apod.thumbnailUrl!
            : fallbackImage;
      }
    }

    final imageUrl = safeImageUrl();

    const borderRadius = BorderRadius.only(
      bottomLeft: Radius.circular(30.0),
      bottomRight: Radius.circular(30.0),
    );

    if (isImage) {
      return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => SeeFullImage(
                url: apod.hdurl?.isNotEmpty == true ? apod.hdurl! : imageUrl,
              ),
            ),
          );
        },
        child: Container(
          height: size,
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            border: Border.all(color: CustomColors.white.withValues(alpha: .5)),
            image: DecorationImage(
              image: NetworkImage(imageUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
      );
    }

    return Container(
      height: size,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        border: Border.all(color: CustomColors.white.withValues(alpha: .5)),
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [ApodVideo(url: apod.url ?? "")],
      ),
    );
  }

  List<PopupMenuItem<int>> buildMenuButtons() {
    return [
      if (isImage)
        PopupMenuItem(
          value: 1,
          onTap: saveOnGallery,
          child: Text(
            AppLocalizations.of(context)!.saveonGallery,
            style: TextStyle(color: CustomColors.white),
          ),
        ),
      PopupMenuItem(
        value: 2,
        onTap: shareOnlyLink,
        child: Text(
          AppLocalizations.of(context)!.shareMediaLink,
          style: TextStyle(color: CustomColors.white),
        ),
      ),
      PopupMenuItem(
        value: 3,
        onTap: sharedAllContent,
        child: Text(
          AppLocalizations.of(context)!.shareAllContent,
          style: TextStyle(color: CustomColors.white),
        ),
      ),
    ];
  }

  void saveOnGallery() {
    if (isImage) {
      GallerySaver.saveImage(apod.hdurl ?? apod.hdurl ?? "").then((value) {
        if (value == true) {
          setState(() {
            AppLocalizations.of(context)!.saveonGallerySaved;
          });
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
    late String copyrightBy = apod.copyright == null
        ? "NASA"
        : "${apod.copyright}";
    if (urlToShare.isNotEmpty) {
      SharePlus.instance.share(
        ShareParams(
          text:
              "${apod.title}\n${apod.explanation}\n\nlink: $urlToShare\n\nby: $copyrightBy",
        ),
      );
    }
  }

  void showSnackBar(String msg) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
    });
  }

  Future<void> _launchInBrowser() async {
    final String urlString = apod.hdurl ?? apod.url ?? "";
    if (urlString.isNotEmpty) {
      final Uri url = Uri.parse(urlString);
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      } else {
        debugPrint('The URL could not be opened: $urlString');
      }
    }
  }
}
