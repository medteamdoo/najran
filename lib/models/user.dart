import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';

class User {
  final int id;
  final String name;
  final String email;
  final String login;
  final Company company;
  final Uint8List? image;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.login,
    required this.company,
    this.image,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      name: json['name'] as String,
      email: json['email'] as String,
      login: json['login'] as String,
      company: Company.fromJson(json['company_id'] as Map<String, dynamic>),
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

  ImageProvider? get imageProvider {
    return image != null ? MemoryImage(image!) : null;
  }
}

class Company {
  final String name;

  Company({required this.name});

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(name: json['name'] as String);
  }
}
