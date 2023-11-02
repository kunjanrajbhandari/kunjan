import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task/screen/details/single_page/singlepage.details.dart';
import 'package:task/screen/details/widget/videoitem.widget.dart';
import 'package:task/widget/select_media.widget.dart';

class TrendingScreen extends ConsumerWidget {
  const TrendingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Widget> widgetList = [
      const VideoItem(mediaenum: MediaEnum.youtube),
      const VideoItem(mediaenum: MediaEnum.facebook),
      const VideoItem(mediaenum: MediaEnum.abcNews),
      const VideoItem(mediaenum: MediaEnum.topNews),
      const VideoItem(mediaenum: MediaEnum.youtube),
      const VideoItem(mediaenum: MediaEnum.youtube),
    ];
    var size = MediaQuery.of(context).size;
    double itemHeight = 266;
    final double itemWidth = size.width / 2;
    return GridView.count(
      crossAxisSpacing: 12,
      mainAxisSpacing: 14,
      crossAxisCount: 2,
      childAspectRatio: (itemWidth / itemHeight),
      controller: ScrollController(keepScrollOffset: false),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      children: widgetList.map((e) {
        return GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => YoutubeVideoPlayer()));
            },
            child: e);
      }).toList(),
    );
  }
}
