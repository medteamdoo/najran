import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:najran/screens/services.dart';

class ServiceCard extends StatelessWidget {
  final String title;
  final String description;
  final double rating;
  final int reviews;
  final String iconPath;
  final VoidCallback? startService;
  final VoidCallback? descriptionService;

  const ServiceCard({
    Key? key,
    required this.title,
    required this.description,
    required this.rating,
    required this.reviews,
    required this.iconPath,
    this.startService,
    this.descriptionService,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 270,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: Color(0xFFD2D6DB), width: 1),
          ),

          margin: EdgeInsets.only(bottom: 16),
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 18,
                      backgroundColor: Color(0xFFf3fcf6),
                      child: SvgPicture.asset(
                        width: 15,
                        height: 15,
                        iconPath,
                        color: Color(0xFF1B8354),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
                ),
                SizedBox(height: 4),
                Text(description, style: TextStyle(fontSize: 14)),
                SizedBox(height: 8),
                RatingBarIndicator(
                  rating: rating,
                  itemBuilder: (context, index) =>
                      Icon(Icons.star, color: Colors.amber),
                  itemCount: 5,
                  itemSize: 20.0,
                ),
                SizedBox(width: 8),
                Text('$reviews تقييم', style: TextStyle(fontSize: 12)),

                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    OutlinedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ScrollableServicePage(),
                          ),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Colors.grey.shade400),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'وصف الخدمة',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    SizedBox(width: 12),
                    ElevatedButton(
                      onPressed: startService,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF1B8354),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'ابدأ الخدمة',
                        style: TextStyle(color: Colors.white),
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
