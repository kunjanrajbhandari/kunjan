import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task/utils/kconstant/app.kconstant.dart';
import 'package:task/widget/select_media.widget.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

/// Homepage
class YoutubeVideoPlayer extends StatefulWidget {
  final String? title;
  final String? description;
  const YoutubeVideoPlayer({super.key, this.title, this.description});
  @override
  _YoutubeVideoPlayerState createState() => _YoutubeVideoPlayerState();
}

class _YoutubeVideoPlayerState extends State<YoutubeVideoPlayer> {
  late YoutubePlayerController _controller;
  late TextEditingController _idController;
  late TextEditingController _seekToController;

  late PlayerState _playerState;
  late YoutubeMetaData _videoMetaData;
  // double _volume = 100;
  // bool _muted = false;
  bool _isPlayerReady = false;

  final List<String> _ids = [
    'Pmg2PtMwhgs',
  ];

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: _ids.first,
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: true,
      ),
    )..addListener(listener);
    _idController = TextEditingController();
    _seekToController = TextEditingController();
    _videoMetaData = const YoutubeMetaData();
    _playerState = PlayerState.unknown;
  }

  void listener() {
    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
      setState(() {
        _playerState = _controller.value.playerState;
        _videoMetaData = _controller.metadata;
      });
    }
  }

  @override
  void deactivate() {
    // Pauses video while navigating to next page.
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    _idController.dispose();
    _seekToController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      onExitFullScreen: () {
        // The player forces portraitUp after exiting fullscreen. This overrides the behaviour.
        SystemChrome.setPreferredOrientations(DeviceOrientation.values);
      },
      player: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
        progressIndicatorColor: Colors.blueAccent,
        topActions: <Widget>[
          const SizedBox(width: 8.0),
          Expanded(
            child: Text(
              _controller.metadata.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.settings,
              color: Colors.white,
              size: 25.0,
            ),
            onPressed: () {
              log('Settings Tapped!');
            },
          ),
        ],
        onReady: () {
          _isPlayerReady = true;
        },
        onEnded: (data) {
          _controller
              .load(_ids[(_ids.indexOf(data.videoId) + 1) % _ids.length]);
          _showSnackBar('Next Video Started!');
        },
      ),
      builder: (context, player) => Scaffold(
        appBar: AppBar(
            backgroundColor: Appkconstant.appBarColor,
            title: const Text(
              "Post",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
            ),
            iconTheme: IconThemeData(color: Colors.white),
            actions: <Widget>[
              const Icon(
                Icons.favorite,
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
        body: ListView(
          children: [
            player,
            Content(
              title: widget.title,
              description: widget.description,
            )
          ],
        ),
      ),
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontWeight: FontWeight.w300,
            fontSize: 16.0,
          ),
        ),
        backgroundColor: Colors.blueAccent,
        behavior: SnackBarBehavior.floating,
        elevation: 1.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
      ),
    );
  }
}

class Content extends ConsumerWidget {
  final String? title;
  final String? description;
  const Content({super.key, this.title, this.description});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 12.0, right: 12, top: 12, bottom: 12),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              selectMedia(MediaEnum.youtube, isArrow: true),
              Text(
                '1 hour ago',
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff000000),
                ),
              ),
            ],
          ),
          Container(
            margin: Appkconstant.topPadding,
            child: Text(
              title ?? 'NABIN KRISHI PRABIDHI || Nepal Television 2079-04-23',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: const Color(0xff000000),
              ),
            ),
          ),
          Container(
            margin: Appkconstant.topPadding * 1.5,
            child: Align(
              // viewsaug112022ntvnewsntvplusne (101:149)
              alignment: Alignment.topLeft,
              child: SizedBox(
                child: description != null
                    ? Text(
                        description.toString(),
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xff000000).withOpacity(0.7),
                          decorationColor: Color(0xff000000),
                        ),
                      )
                    : RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            height: 1.0833333333,
                            color: const Color(0xff000000).withOpacity(0.7),
                          ),
                          children: [
                            TextSpan(
                              text: '2,401 views  Aug 11, 2022  ',
                            ),
                            TextSpan(
                              text: '#ntvnews',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                height: 2.0833333333,
                                decoration: TextDecoration.underline,
                                color: const Color(0xff000000).withOpacity(0.7),
                                decorationColor: Color(0xff000000),
                              ),
                            ),
                            TextSpan(
                              text: ' ',
                            ),
                            TextSpan(
                              text: '#ntvplus',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                height: 2.0833333333,
                                decoration: TextDecoration.underline,
                                color: const Color(0xff000000).withOpacity(0.7),
                                decorationColor: Color(0xff000000),
                              ),
                            ),
                            TextSpan(
                              text: ' ',
                            ),
                            TextSpan(
                              text: '#nepal\n',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                height: 2.0833333333,
                                decoration: TextDecoration.underline,
                                color: const Color(0xff000000).withOpacity(0.7),
                                decorationColor: Color(0xff000000),
                              ),
                            ),
                            TextSpan(
                              text: '#nabinkrishi',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                height: 2.0833333333,
                                decoration: TextDecoration.underline,
                                color: const Color(0xff000000).withOpacity(0.7),
                                decorationColor: Color(0xff000000),
                              ),
                            ),
                            TextSpan(
                              text: ' ',
                            ),
                            TextSpan(
                              text: '#krishiprabidhi',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                height: 2.0833333333,
                                decoration: TextDecoration.underline,
                                color: const Color(0xff000000).withOpacity(0.7),
                                decorationColor: Color(0xff000000),
                              ),
                            ),
                            TextSpan(
                              text: ' ',
                            ),
                            TextSpan(
                              text: '#krishinepal',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                height: 2.0833333333,
                                decoration: TextDecoration.underline,
                                color: const Color(0xff000000).withOpacity(0.7),
                                decorationColor: Color(0xff000000),
                              ),
                            ),
                            TextSpan(
                              text: ' ',
                            ),
                            TextSpan(
                              text: '#nepalkrishi',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                height: 2.0833333333,
                                decoration: TextDecoration.underline,
                                color: const Color(0xff000000).withOpacity(0.7),
                                decorationColor: Color(0xff000000),
                              ),
                            ),
                            TextSpan(
                              text: ' ',
                            ),
                            TextSpan(
                              text: '#krishi',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                height: 2.0833333333,
                                decoration: TextDecoration.underline,
                                color: const Color(0xff000000).withOpacity(0.7),
                                decorationColor: Color(0xff000000),
                              ),
                            ),
                            TextSpan(
                              text: ' ',
                            ),
                            TextSpan(
                              text: '#ntvkrishi',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                height: 2.0833333333,
                                decoration: TextDecoration.underline,
                                color: const Color(0xff000000).withOpacity(0.7),
                                decorationColor: Color(0xff000000),
                              ),
                            ),
                            TextSpan(
                              text: '  ',
                            ),
                            TextSpan(
                              text: '#ntvplus',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                height: 2.0833333333,
                                decoration: TextDecoration.underline,
                                color: const Color(0xff000000).withOpacity(0.7),
                                decorationColor: Color(0xff000000),
                              ),
                            ),
                            TextSpan(
                              text: ' ',
                            ),
                            TextSpan(
                              text: '#ntvnews',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                height: 2.0833333333,
                                decoration: TextDecoration.underline,
                                color: const Color(0xff000000).withOpacity(0.7),
                                decorationColor: Color(0xff000000),
                              ),
                            ),
                            TextSpan(
                              text: ' ',
                            ),
                            TextSpan(
                              text: '#nepaltelevision',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                height: 2.0833333333,
                                decoration: TextDecoration.underline,
                                color: const Color(0xff000000).withOpacity(0.7),
                                decorationColor: Color(0xff000000),
                              ),
                            ),
                            TextSpan(
                              text: ' ',
                            ),
                            TextSpan(
                              text: '#nepal',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                height: 2.0833333333,
                                decoration: TextDecoration.underline,
                                color: const Color(0xff000000).withOpacity(0.7),
                                decorationColor: Color(0xff000000),
                              ),
                            ),
                            TextSpan(
                              text:
                                  '\n\nSubscribe to our YouTube Channel and get daily program updates of NTV, NTV PLUS, and NTV NEWS.\nSTAY TUNED FOR MORE UPCOMING PROGRAMS FROM NEPAL TELEVISION !!!\n\nNepal Television HD',
                            ),
                            TextSpan(
                              text: ' को सबै ',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                height: 2.0833333333,
                                color: const Color(0xff000000).withOpacity(0.7),
                              ),
                            ),
                            TextSpan(
                              text:
                                  'Channel (NTV News, NTV Khohalpur, NTV Plus)',
                            ),
                            TextSpan(
                              text: 'को सम्पूर्ण कार्यक्रम',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w800,
                                height: 2.0833333333,
                                color: Color(0xff000000),
                              ),
                            ),
                            TextSpan(
                              text: ' ',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w800,
                                height: 2.0833333333,
                                color: const Color(0xff000000).withOpacity(0.7),
                              ),
                            ),
                            TextSpan(
                              text: 'Youtube ',
                            ),
                            TextSpan(
                              text:
                                  'मा समयमै हेर्न र कार्यक्रम बारे जानकारी प्राप्त गर्न हामीलाई ',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                height: 2.0833333333,
                                color: const Color(0xff000000).withOpacity(0.7),
                              ),
                            ),
                            TextSpan(
                              text: 'Youtube',
                            ),
                            TextSpan(
                              text: ' मा ',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                height: 2.0833333333,
                                color: const Color(0xff000000).withOpacity(0.7),
                              ),
                            ),
                            TextSpan(
                              text: 'subscribe ',
                            ),
                            TextSpan(
                              text: 'गर्नुहोस',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                height: 2.0833333333,
                                color: const Color(0xff000000).withOpacity(0.7),
                              ),
                            ),
                            TextSpan(
                              text: '',
                            ),
                            TextSpan(
                              text: '\nनेपाल टेलिभिजनको',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                height: 2.0833333333,
                                color: const Color(0xff000000).withOpacity(0.7),
                              ),
                            ),
                            TextSpan(
                              text: ' App Download',
                            ),
                            TextSpan(
                              text: ' गर्नुहोस साथै हामीलाई ',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                height: 2.0833333333,
                                color: const Color(0xff000000).withOpacity(0.7),
                              ),
                            ),
                            TextSpan(
                              text: 'Facebook, Instagram ',
                            ),
                            TextSpan(
                              text: 'मा ',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                height: 2.0833333333,
                                color: const Color(0xff000000).withOpacity(0.7),
                              ),
                            ),
                            TextSpan(
                              text: 'Follow',
                            ),
                            TextSpan(
                              text: ' गर्न पनी नभुल्नु होला',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                height: 2.0833333333,
                                color: const Color(0xff000000).withOpacity(0.7),
                              ),
                            ),
                            TextSpan(
                              text: '  ।  \nMobile App ',
                            ),
                            TextSpan(
                              text: 'http//bit.ly/nepaltelevision​',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                height: 2.0833333333,
                                decoration: TextDecoration.underline,
                                color: const Color(0xff000000).withOpacity(0.7),
                                decorationColor:
                                    const Color(0xff000000).withOpacity(0.7),
                              ),
                            ),
                            TextSpan(
                              text: ' \nOnline Website ',
                            ),
                            TextSpan(
                              text: 'https//nepaltvonline.com/​',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                height: 2.0833333333,
                                decoration: TextDecoration.underline,
                                color: const Color(0xff000000).withOpacity(0.7),
                                decorationColor:
                                    const Color(0xff000000).withOpacity(0.7),
                              ),
                            ),
                            TextSpan(
                              text: ' \nWebsite ',
                            ),
                            TextSpan(
                              text: 'http//ntv.org.np/​',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                height: 2.0833333333,
                                decoration: TextDecoration.underline,
                                color: const Color(0xff000000).withOpacity(0.7),
                                decorationColor:
                                    const Color(0xff000000).withOpacity(0.7),
                              ),
                            ),
                            TextSpan(
                              text: ' \nFacebook ',
                            ),
                            TextSpan(
                              text: 'https//www.facebook.com/neptv2041/​',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                height: 2.0833333333,
                                decoration: TextDecoration.underline,
                                color: const Color(0xff000000).withOpacity(0.7),
                                decorationColor:
                                    const Color(0xff000000).withOpacity(0.7),
                              ),
                            ),
                            TextSpan(
                              text: ' \nInstagram ',
                            ),
                            TextSpan(
                              text: 'https//www.instagram.com/nepaltelevi...',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                height: 2.0833333333,
                                decoration: TextDecoration.underline,
                                color: const Color(0xff000000).withOpacity(0.7),
                                decorationColor:
                                    const Color(0xff000000).withOpacity(0.7),
                              ),
                            ),
                            TextSpan(
                              text:
                                  ' \n\n(NTV. Digital Platform is Managed by NEW IT VENTURE CORPORATION www.newitventure.com)',
                            ),
                          ],
                        ),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
