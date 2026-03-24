import 'package:astronomy_picture/custom_colors.dart';
import 'package:astronomy_picture/domain/entities/apod.dart';
import 'package:flutter/material.dart';

class ApodTile extends StatelessWidget {
  final Apod apod;
  final Function() onTap;
  const ApodTile({super.key, required this.apod, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final String displayImageUrl = (apod.mediaType == 'video')
        ? (apod.thumbnailUrl ??
              "https://spaceplace.nasa.gov/gallery-space/en/NGC2336-galaxy.en.jpg")
        : (apod.url ?? "");

    final bool isSafeImage =
        displayImageUrl.isNotEmpty &&
        !displayImageUrl.toLowerCase().endsWith('.mp4');

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: 'apod-${apod.date.toString()}',
              child: Container(
                height: MediaQuery.of(context).size.width,
                alignment: Alignment.bottomCenter,
                decoration: BoxDecoration(
                  color: Colors.black,
                  image: isSafeImage
                      ? DecorationImage(
                          image: NetworkImage(displayImageUrl),
                          fit: BoxFit.cover,
                        )
                      : null,
                  borderRadius: BorderRadius.circular(30.0),
                  border: Border.all(color: CustomColors.white.withOpacity(.5)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (apod.mediaType == 'video')
                      const Expanded(
                        child: Center(
                          child: Icon(
                            Icons.play_circle_outline,
                            color: Colors.white,
                            size: 80,
                          ),
                        ),
                      ),

                    Container(
                      height: 100,
                      decoration: BoxDecoration(
                        color: CustomColors.black.withOpacity(.6),
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * .6,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    apod.title ?? "",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: CustomColors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    apod.explanation ?? "",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(color: CustomColors.white),
                                  ),
                                ],
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: CustomColors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
