class YoutubeVideo {
  final int id;
  final String title;
  final String videoUrl;
  final String videoImage; // ✅ nouvelle propriété

  YoutubeVideo({
    required this.id,
    required this.title,
    required this.videoUrl,
    required this.videoImage,
  });

  factory YoutubeVideo.fromJson(Map<String, dynamic> json) {
    String parseString(dynamic value) {
      return value != null ? value.toString() : '';
    }

    final videoUrl = parseString(json['url']);
    final videoImage = _generateThumbnail(videoUrl);

    return YoutubeVideo(
      id: json['id'] ?? 0,
      title: parseString(json['title']),
      videoUrl: videoUrl,
      videoImage: videoImage,
    );
  }

  static String _generateThumbnail(String videoUrl) {
    try {
      final uri = Uri.tryParse(videoUrl);
      if (uri == null) return '';

      String videoId = '';

      if (uri.host.contains('youtube.com')) {
        videoId = uri.queryParameters['v'] ?? '';
      } else if (uri.host.contains('youtu.be')) {
        videoId = uri.pathSegments.first;
      }

      if (videoId.isEmpty) return '';

      return 'https://img.youtube.com/vi/$videoId/0.jpg';
    } catch (e) {
      return '';
    }
  }

  bool get isYoutubeVideo {
    return videoUrl.contains("youtube.com") || videoUrl.contains("youtu.be");
  }
}
