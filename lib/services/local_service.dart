import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

class LocalizationService {
  late Map<String, dynamic> _localizedStrings;

  Future<void> load(Locale locale) async {
    String jsonString = await rootBundle.loadString(
      'assets/translations/${locale.languageCode}.json',
    );
    _localizedStrings = json.decode(jsonString);
  }

  String translate(String key) {
    return _localizedStrings[key] ?? key;
  }

  static const supportedLocales = [Locale('en', 'US'), Locale('ar', 'SA')];

  static const fallbackLocale = Locale('ar', 'SA');
}
