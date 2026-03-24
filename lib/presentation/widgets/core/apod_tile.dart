import 'package:astronomy_picture/custom_colors.dart';
import 'package:astronomy_picture/domain/entities/apod.dart';
import 'package:flutter/material.dart';

class ApodTile extends StatelessWidget {
  final Apod apod;
  final Function() onTap;
  const ApodTile({super.key, required this.apod, required this.onTap});

  @override
  Widget build(BuildContext context) {
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
                  image: DecorationImage(
                    image: NetworkImage(apod.thumbnailUrl ?? apod.url!),
                    fit: BoxFit.fitHeight,
                  ),
                  borderRadius: BorderRadius.circular(30.0),
                  border: Border.all(color: CustomColors.white.withOpacity(.5)),
                ),
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                    color: CustomColors.black.withOpacity(.6),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .6,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Spacer(),
                              Expanded(
                                flex: 1,
                                child: Text(
                                  apod.title ?? "",
                                  style: TextStyle(
                                    color: CustomColors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text(
                                  apod.explanation ?? "",
                                  maxLines: 1,
                                  style: TextStyle(color: CustomColors.white),
                                ),
                              ),
                              const Spacer(),
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
