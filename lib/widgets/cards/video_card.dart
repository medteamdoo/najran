import 'package:flutter/material.dart';
import 'package:najran/models/video.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoCard extends StatefulWidget {
  final YoutubeVideo video;

  const VideoCard({Key? key, required this.video}) : super(key: key);

  @override
  State<VideoCard> createState() => _VideoCardState();
}

class _VideoCardState extends State<VideoCard> {
  YoutubePlayerController? _controller;
  bool _isPlayerReady = false;
  bool _isPlaying = false;

  void _playVideo() {
    if (!_isPlaying && widget.video.isYoutubeVideo) {
      final videoId = YoutubePlayer.convertUrlToId(widget.video.videoUrl) ?? '';
      _controller =
          YoutubePlayerController(
            initialVideoId: videoId,
            flags: const YoutubePlayerFlags(autoPlay: true, mute: false),
          )..addListener(() {
            if (_controller != null &&
                _isPlayerReady &&
                !_controller!.value.isFullScreen) {
              setState(() {});
            }
          });

      setState(() {
        _isPlaying = true;
      });
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final video = widget.video;

    return Card(
      color: Colors.white,
      margin: const EdgeInsets.all(12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // zone clicable pour lancer la vidéo
          GestureDetector(
            onTap: _playVideo,
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  height: 200,
                  width: double.infinity,
                  child: _isPlaying && _controller != null
                      ? YoutubePlayer(
                          controller: _controller!,
                          showVideoProgressIndicator: true,
                          onReady: () {
                            _isPlayerReady = true;
                          },
                        )
                      : Stack(
                          fit: StackFit.expand,
                          children: [
                            video.videoImage.isNotEmpty
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.network(
                                      video.videoImage,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : Container(
                                    color: Colors.grey.shade300,
                                    child: const Center(
                                      child: Text("لا توجد فيديوهات متاحة"),
                                    ),
                                  ),
                            // Icône Play au centre
                            Center(
                              child: Image.asset(
                                'assets/images/video_player.png',
                                width: 80,
                                height: 80,
                              ),
                            ),
                          ],
                        ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Text(
              (video.title.isNotEmpty && video.title != 'false')
                  ? video.title
                  : 'بدون عنوان',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }
}
