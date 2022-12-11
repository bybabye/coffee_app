import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:sizer/sizer.dart';

class CardVideo extends StatefulWidget {
  const CardVideo(
      {super.key,
      required this.url,
      required this.isCheck,
      required this.photoURL});
  final String url;
  final bool isCheck;
  final String photoURL;
  @override
  State<CardVideo> createState() => _CardVideoState();
}

class _CardVideoState extends State<CardVideo> {
  late VideoPlayerController _controller;
  bool isVolume = false;
  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
      widget.url,
    );
    if (!mounted) {
      _controller.pause();
    }

    _controller.initialize();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Stack(
        alignment:
            widget.isCheck ? Alignment.bottomRight : Alignment.bottomLeft,
        children: [
          FittedBox(
            fit: BoxFit.cover,
            child: Row(
              children: [
                if (!widget.isCheck)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 24),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(widget.photoURL),
                    ),
                  ),
                Container(
                  height: 37.h,
                  width: 51.w,
                  padding: const EdgeInsets.all(4),
                  margin: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                  ),
                  child: widget.url.isEmpty
                      ? SizedBox(
                          height: 5.h,
                          width: 12.w,
                          child:
                              const Center(child: CircularProgressIndicator()))
                      : Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: VideoPlayer(_controller),
                            ),
                            Center(
                              child: InkWell(
                                onTap: () {
                                  if (_controller.value.isPlaying) {
                                    setState(() {
                                      _controller.pause();
                                    });
                                  } else {
                                    setState(() {
                                      _controller.play();
                                    });
                                  }
                                },
                                child: _controller.value.isPlaying
                                    ? SizedBox(
                                        height: 37.h,
                                        width: 51.w,
                                      )
                                    : Container(
                                        height: 5.h,
                                        width: 12.w,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white.withOpacity(.1),
                                          border: Border.all(
                                            color: Colors.white,
                                            width: 2,
                                          ),
                                        ),
                                        child: const Icon(
                                          Icons.play_arrow,
                                          size: 30,
                                          color: Colors.white,
                                        ),
                                      ),
                              ),
                            ),
                            Container(
                              width: 48.w,
                              margin: const EdgeInsets.all(12),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 11,
                                    child: VideoProgressIndicator(
                                      _controller,
                                      allowScrubbing: true,
                                      colors: const VideoProgressColors(
                                        backgroundColor: Colors.transparent,
                                        playedColor: Colors.blueAccent,
                                        bufferedColor: Colors.grey,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          isVolume = !isVolume;
                                        });
                                        _controller.setVolume(isVolume ? 0 : 1);
                                      },
                                      icon: Icon(
                                        isVolume
                                            ? Icons.volume_off
                                            : Icons.volume_down,
                                        color: Colors.white.withOpacity(.8),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
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
