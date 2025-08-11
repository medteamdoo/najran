import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:najran/screens/nafadh_webview.dart';

class HomeServiceCard extends StatelessWidget {
  final String title;
  final String description;
  final double rating;
  final int reviews;
  final String iconPath;

  const HomeServiceCard({
    Key? key,
    required this.title,
    required this.description,
    required this.rating,
    required this.reviews,
    required this.iconPath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 240, // ⬅ largeur réduite
      height: 190, // ⬅ hauteur réduite
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(color: const Color(0xFFD2D6DB), width: 1),
          ),
          margin: const EdgeInsets.only(bottom: 12),
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(10), // ⬅ padding réduit
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Icône en haut
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 14, // ⬅ plus petit
                      backgroundColor: const Color(0xFFf3fcf6),
                      child: SvgPicture.asset(
                        width: 12,
                        height: 12,
                        iconPath,
                        color: const Color(0xFF1B8354),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),

                // Titre
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 14, // ⬅ réduit
                  ),
                ),
                const SizedBox(height: 2),

                // Description
                Text(
                  description,
                  style: const TextStyle(fontSize: 12), // ⬅ réduit
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),

                // Rating + nombre d'avis
                Row(
                  children: [
                    RatingBarIndicator(
                      rating: rating,
                      itemBuilder: (context, index) =>
                          const Icon(Icons.star, color: Colors.amber),
                      itemCount: 5,
                      itemSize: 14.0, // ⬅ réduit
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '$reviews تقييم',
                      style: const TextStyle(fontSize: 10), // ⬅ réduit
                    ),
                  ],
                ),
                const Spacer(),

                // Boutons
                Row(
                  children: [
                    OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size(60, 30), // ⬅ plus petit
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        side: BorderSide(
                          color: Colors.grey.shade400,
                          width: 0.8,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      child: const Text(
                        'وصف الخدمة',
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.black,
                        ), // ⬅ réduit
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const WebViewScreen(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(60, 30), // ⬅ plus petit
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        backgroundColor: const Color(0xFF1B8354),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      child: const Text(
                        'ابدأ الخدمة',
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.white,
                        ), // ⬅ réduit
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
