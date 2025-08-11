import 'package:flutter/material.dart';
import 'package:najran/models/news.dart';

class HomeNewsCard extends StatelessWidget {
  final News news;
  final VoidCallback? onTap;

  const HomeNewsCard({Key? key, required this.news, this.onTap})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          elevation: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize:
                MainAxisSize.min, // ⬅ Empêche le Card de prendre trop de place
            children: [
              _buildImageOrVideoThumbnail(),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  news.title,
                  maxLines: 2, // ⬅ Limite à 2 lignes
                  overflow: TextOverflow.ellipsis, // ⬅ Ajoute "..."
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageOrVideoThumbnail() {
    if (news.image != null && news.image!.isNotEmpty) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.memory(
            news.image!,
            width: double.infinity,
            height: 130, // ⬅ Réduction hauteur
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => _fallbackThumbnail(),
          ),
        ),
      );
    } else if (news.isYoutubeVideo && news.youtubeThumbnail != null) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.network(
            news.youtubeThumbnail!,
            width: double.infinity,
            height: 130, // ⬅ Réduction hauteur
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => _fallbackThumbnail(),
          ),
        ),
      );
    } else {
      return _fallbackThumbnail();
    }
  }

  Widget _fallbackThumbnail() {
    return Container(
      height: 130,
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Center(child: Icon(Icons.broken_image)),
    );
  }
}
