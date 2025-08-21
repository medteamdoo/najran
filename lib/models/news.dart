import 'dart:convert';
import 'dart:typed_data';

class News {
  final int id;
  final String title;
  final String? attachment;
  final String? resume;
  final bool? type;
  final String? videoUrl;
  final String? descriptionText;
  final String? newsSource;
  final String? datePublished;
  final Uint8List? image;

  News({
    required this.id,
    required this.title,
    this.attachment,
    this.resume,
    this.type,
    this.videoUrl,
    this.descriptionText,
    this.newsSource,
    this.datePublished,
    this.image,
  });

  factory News.fromJson(Map<String, dynamic> json) {
    String? parseString(dynamic value) {
      return (value != null && value != false) ? value.toString() : null;
    }

    return News(
      id: json['id'] ?? 0,
      title: parseString(json['title']) ?? 'Sans titre',
      attachment: parseString(json['attachment']),
      resume: parseString(json['resume']),
      type: json['type'] is bool ? json['type'] : null,
      videoUrl: parseString(json['video_url']),
      descriptionText: parseString(json['description_text']),
      newsSource: parseString(json['news_source']),
      datePublished: parseString(json['date_published']),
      image: _parseImageData(json['image_1920']),
    );
  }
  static Uint8List? _parseImageData(dynamic imageData) {
    if (imageData == null || imageData is! String) return null;

    try {
      return base64Decode(imageData.split(',').last);
    } catch (e) {
      print('Erreur de décodage de l\'image: $e');
      return null;
    }
  }

  bool get isYoutubeVideo {
    return videoUrl != null;
  }

  String? get youtubeThumbnail {
    if (videoUrl == null) return null;

    try {
      final uri = Uri.tryParse(videoUrl!);
      if (uri == null) return null;

      String videoId;

      // Pour les URLs de type: https://www.youtube.com/watch?v=j02lAZqrics
      if (uri.host.contains('youtube.com')) {
        videoId = uri.queryParameters['v'] ?? '';
      }
      // Pour les URLs de type: https://youtu.be/j02lAZqrics
      else if (uri.host.contains('youtu.be')) {
        videoId = uri.pathSegments.first;
      }
      // Autres formats non supportés
      else {
        return null;
      }

      // Vérifier que l'ID est valide
      if (videoId.isEmpty) return null;

      return 'https://img.youtube.com/vi/$videoId/0.jpg';
    } catch (e) {
      return null;
    }
  }
}
