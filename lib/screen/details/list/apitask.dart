import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task/screen/details/bloc/details.bloc.dart';
import 'package:task/screen/details/single_page/singlepage.details.dart';
import 'package:task/screen/details/widget/videoitem.widget.dart';
import 'package:task/utils/api/response_handle.api.dart';
import 'package:task/utils/kconstant/app.kconstant.dart';
import 'package:task/widget/select_media.widget.dart';

final isRefreshIndicatorOn = StateProvider<bool>((ref) => false);

class APITaskScreen extends ConsumerStatefulWidget {
  const APITaskScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _APITaskScreenState();
}

class _APITaskScreenState extends ConsumerState<APITaskScreen> {
  @override
  void initState() {
    super.initState();
    initData();
  }

  initData() async {
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      ref.read(detailsProvider).fetchData();
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    double itemHeight = 266;
    final double itemWidth = size.width / 2;
    final detailsList = ref.watch(detailsProvider).detailsList;
    final detailsListResponse = ref.watch(detailsProvider).detailsApiResponse;
    if (detailsListResponse.status == Status.loading &&
        ref.watch(isRefreshIndicatorOn) == false) {
      return SizedBox(
          height: MediaQuery.of(context).size.height - 299,
          width: MediaQuery.of(context).size.width,
          child: const Column(
            // crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(
                color: Appkconstant.appBarColor,
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: 18.0,
                  left: 18,
                ),
                child: Text(
                  "Loading...",
                  style: TextStyle(
                      fontWeight: FontWeight.w500, color: Colors.grey),
                ),
              )
            ],
          ));
    }
    return GridView.count(
      crossAxisSpacing: 12,
      mainAxisSpacing: 14,
      crossAxisCount: 2,
      childAspectRatio: (itemWidth / itemHeight),
      controller: ScrollController(keepScrollOffset: false),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      children: detailsList.map((e) {
        return SizedBox(
          height: MediaQuery.of(context).size.height,
          child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => YoutubeVideoPlayer(
                          title: e.title,
                          description: e.body,
                        )));
              },
              child: VideoItem(
                title: e.title,
                mediaenum: getMedia(),
              )),
        );
      }).toList(),
    );
  }
}

getMedia() {
  Random random = Random();
  int randomNumber = random.nextInt(4) + 1; //
  if (randomNumber == 1) {
    return MediaEnum.abcNews;
  } else if (randomNumber == 2) {
    return MediaEnum.topNews;
  } else if (randomNumber == 3) {
    return MediaEnum.youtube;
  } else {
    return MediaEnum.facebook;
  }
}
