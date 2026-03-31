import 'package:astronomy_picture/custom_colors.dart';
import 'package:flutter/material.dart';

class ApodViewButton extends StatelessWidget {
  final IconData iconCustom;
  final String titleCustom;
  final String descriptionCustom;
  final Function()? onTapCustom;
  const ApodViewButton({
    super.key,
    required this.iconCustom,
    required this.titleCustom,
    required this.descriptionCustom,
    required this.onTapCustom,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapCustom,
      child: Container(
        width: 205,
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: CustomColors.black,
          borderRadius: BorderRadius.circular(30.0),
          border: Border.all(color: CustomColors.white.withValues(alpha: .6)),
        ),
        child: Column(
          children: [
            Icon(iconCustom, color: CustomColors.white, size: 50),
            Text(
              titleCustom,
              style: TextStyle(color: CustomColors.white, fontSize: 22),
            ),
            Text(
              descriptionCustom,
              style: TextStyle(color: CustomColors.white, fontSize: 10),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
