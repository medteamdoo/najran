import 'dart:convert';
import 'dart:typed_data';

class ImageModel {
  final int id;
  final String title;
  final Uint8List? image;

  ImageModel({required this.id, required this.title, this.image});

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    String parseString(dynamic value) {
      return value != null ? value.toString() : '';
    }

    return ImageModel(
      id: json['id'] ?? 0,
      title: parseString(json['title']),
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
}
