import 'dart:io';
import 'package:flutter/material.dart';

class ImageContainer extends StatelessWidget {
  const ImageContainer(
      {Key? key,
      required this.screenWidth,
      required this.onTap,
      required this.file,
      required this.onLongPress})
      : super(key: key);
  final double screenWidth;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  final File file;
  @override
  Widget build(BuildContext context) {
    double imageSizeS = screenWidth / 4 - 15;
    double imageSizeM = screenWidth / 6 - 15;
    double imageSizeL = screenWidth / 8 - 15;
    double imageSizeXL = screenWidth / 12 - 15;
    return InkWell(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Container(
        height: screenWidth < 600
            ? imageSizeS
            : screenWidth < 1200
                ? imageSizeM
                : screenWidth < 1600
                    ? imageSizeL
                    : imageSizeXL,
        width: screenWidth < 600
            ? imageSizeS
            : screenWidth < 1200
                ? imageSizeM
                : screenWidth < 1600
                    ? imageSizeL
                    : imageSizeXL,
        decoration: BoxDecoration(
          color: const Color(0xFFF7F7F8),
          borderRadius: BorderRadius.circular(4),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: Image.file(file).image,
          ),
        ),
      ),
    );
  }
}
