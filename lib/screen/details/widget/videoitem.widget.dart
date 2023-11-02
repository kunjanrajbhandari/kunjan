import 'package:flutter/material.dart';
import 'package:task/widget/select_media.widget.dart';

class VideoItem extends StatelessWidget {
  final String? title;
  final MediaEnum mediaenum;
  const VideoItem({super.key, required this.mediaenum, this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      padding: const EdgeInsets.fromLTRB(10, 10, 8, 4),
      width: 188,
      decoration: BoxDecoration(
        border: Border.all(color: Color(0x820f3c0c)),
        color: const Color(0xffffffff),
        borderRadius: BorderRadius.circular(11),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title ?? 'NABIN KRISHI PRABIDHI || Nepal Television 2079-04-23',
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              height: 1.302,
              decoration: TextDecoration.underline,
              color: Color(0xff000000),
              decorationColor: Color(0xff000000),
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(0, 4.7, 0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 6, 0, 9),
                  height: 22,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      selectMedia(mediaenum),
                      const Text(
                        '1 hour ago',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff000000),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(66, 35.49, 54, 35.49),
                  height: 128.99,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(4),
                        bottomRight: Radius.circular(4)),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(
                        'assets/image/cov.png',
                      ),
                    ),
                  ),
                  child: Container(
                    height: 55,
                    width: 55,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xffffffff),
                    ),
                    child: const Icon(
                      Icons.play_arrow_rounded,
                      size: 29,
                      color: Color(0xff3C4158),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
