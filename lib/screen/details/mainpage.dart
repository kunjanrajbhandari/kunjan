import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task/screen/details/list/trending.dart';
import 'package:task/utils/kconstant/app.kconstant.dart';
import 'bloc/details.bloc.dart';
import 'list/apitask.dart';

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  final scrollbarController = ScrollController();
  List screen = [
    const TrendingScreen(),
    const APITaskScreen(),
    const TrendingScreen(),
    const TrendingScreen(),
    const TrendingScreen(),
    const TrendingScreen(),
    const TrendingScreen()
  ];
  int selectedIndex = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Appkconstant.appBarColor,
          title: const Text(
            "Video",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
          ),
          actions: <Widget>[
            const Icon(
              Icons.search,
              color: Colors.white,
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.share,
                color: Colors.white,
              ),
            ),
          ]),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Container(
                margin: Appkconstant.topDownPadding,
                width: MediaQuery.of(context).size.width - 11,
                height: 42,
                decoration: const BoxDecoration(
                  color: Color(0xffffffff),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x1e000000),
                      offset: Offset(0, 12),
                      blurRadius: 4,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SliderVideoTopic(
                          title: "Trending",
                          isSelected: selectedIndex == 0 ? true : false,
                          onTap: () {
                            selectedIndex = 0;
                            setState(() {});
                          },
                        ),
                        SliderVideoTopic(
                          title: "API Task",
                          isSelected: selectedIndex == 1 ? true : false,
                          onTap: () {
                            selectedIndex = 1;
                            setState(() {});
                          },
                        ),
                        SliderVideoTopic(
                          isSelected: selectedIndex == 2 ? true : false,
                          title: "Trending feature",
                          onTap: () {
                            selectedIndex = 2;
                            setState(() {});
                          },
                        ),
                        SliderVideoTopic(
                          isSelected: selectedIndex == 3 ? true : false,
                          title: "Trending",
                          onTap: () {
                            selectedIndex = 3;
                            setState(() {});
                          },
                        ),
                        SliderVideoTopic(
                          isSelected: selectedIndex == 4 ? true : false,
                          title: "Trending",
                          onTap: () {
                            selectedIndex = 4;
                            setState(() {});
                          },
                        ),
                        SliderVideoTopic(
                          isSelected: selectedIndex == 5 ? true : false,
                          title: "Trending",
                          onTap: () {
                            selectedIndex = 5;
                            setState(() {});
                          },
                        ),
                        SliderVideoTopic(
                          isSelected: selectedIndex == 6 ? true : false,
                          title: "Trending",
                          onTap: () {
                            selectedIndex = 6;
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Scrollbar(
                thumbVisibility: false,
                thickness: 05, //width of scrollbar
                radius: const Radius.circular(20), //corner radius of scrollbar
                scrollbarOrientation: ScrollbarOrientation.right,
                controller: scrollbarController,
                child: RefreshIndicator(
                  onRefresh: () async {
                    ref.read(isRefreshIndicatorOn.notifier).state = true;
                    ref.read(detailsProvider).fetchData();
                    await Future.delayed(const Duration(seconds: 1));
                    ref.read(isRefreshIndicatorOn.notifier).state = false;
                    setState(() {});
                  },
                  child: SingleChildScrollView(
                    controller: scrollbarController,
                    scrollDirection: Axis.vertical,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 12, right: 12, top: 12, bottom: 12),
                      child: screen[selectedIndex],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SliderVideoTopic extends StatelessWidget {
  final String title;
  final bool isSelected;
  final Function onTap;
  const SliderVideoTopic(
      {super.key,
      required this.title,
      this.isSelected = false,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        height: 22,
        decoration: BoxDecoration(
            color: Colors.transparent,
            border: isSelected
                ? const Border(
                    bottom: BorderSide(
                    color: Appkconstant.sliderColor,
                    width: 3.0,
                  ))
                : null),
        margin: Appkconstant.allPadding,
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 12.5,
            fontWeight: FontWeight.w500,
            color: Color(0xff000000),
          ),
        ),
      ),
    );
  }
}
