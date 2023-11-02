import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as fs;
import 'package:task/utils/kconstant/app.kconstant.dart';

class MediaWidget extends StatelessWidget {
  final Color mediaColor;
  final String mediaTitle;
  final String svgIconName;
  final bool isArrow;
  const MediaWidget(
      {super.key,
      required this.mediaTitle,
      required this.mediaColor,
      this.isArrow = false,
      required this.svgIconName});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: Appkconstant.rightPadding,
      padding: const EdgeInsets.fromLTRB(9, 3, 13, 3),
      decoration: BoxDecoration(
        color: mediaColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          !isArrow
              ? Container(
                  margin: const EdgeInsets.fromLTRB(0, 0, 8.04, 0),
                  child: Image(
                    image: fs.Svg('assets/icon/$svgIconName'),
                    color: Colors.white,
                  ))
              : Container(
                  margin: const EdgeInsets.fromLTRB(0, 0, 8.04, 0),
                  child: const Icon(Icons.arrow_forward_ios,
                      color: Colors.white, size: 14)),
          Center(
            // suggestionZPZ (I101:69;101:90;2306:3967)
            child: Text(
              mediaTitle,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 10.5,
                fontWeight: FontWeight.w400,
                height: 1.3025,
                color: Color(0xffffffff),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget selectMedia(MediaEnum mediaEnum, {bool isArrow = false}) {
  if (mediaEnum == MediaEnum.youtube) {
    return MediaWidget(
      mediaColor: const Color(0xffe21f27),
      svgIconName: 'youtubesvg.svg',
      mediaTitle: 'YouTube',
      isArrow: isArrow,
    );
  } else if (mediaEnum == MediaEnum.facebook) {
    return MediaWidget(
      mediaColor: const Color(0xff0f5ea2),
      svgIconName: 'facebooksvg.svg',
      mediaTitle: 'Facebook',
      isArrow: isArrow,
    );
  } else if (mediaEnum == MediaEnum.abcNews) {
    return MediaWidget(
        mediaColor: const Color(0xff17af4e),
        svgIconName: 'abcsvg.svg',
        isArrow: isArrow,
        mediaTitle: 'ABC news');
  } else if (mediaEnum == MediaEnum.topNews) {
    return MediaWidget(
        mediaColor: const Color(0xff812082),
        svgIconName: 'topsvg.svg',
        isArrow: isArrow,
        mediaTitle: 'TOP NEWS');
  }
  return const SizedBox();
}

enum MediaEnum { youtube, facebook, abcNews, topNews }
