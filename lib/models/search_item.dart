import 'package:flutter/material.dart';

class SearchItem {
  final String title;
  final Function(BuildContext) onTap;

  SearchItem({required this.title, required this.onTap});
}
