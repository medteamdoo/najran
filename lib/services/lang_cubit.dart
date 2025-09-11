import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:najran/services/local_service.dart';

class LanguageCubit extends Cubit<String> {
  final LocalizationService localizationService;

  LanguageCubit(this.localizationService) : super('ar');

  void toggleLanguage() {
    final newLanguage = state == 'ar' ? 'en' : 'ar';
    final newLocale = Locale(newLanguage);

    localizationService.load(newLocale);
    emit(newLanguage);
  }

  void setLanguage(String languageCode) {
    final newLocale = Locale(languageCode);
    localizationService.load(newLocale);
    emit(languageCode);
  }
}
