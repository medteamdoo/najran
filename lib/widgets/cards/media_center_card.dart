import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:najran/screens/nafadh_webview.dart';

class MediaCenterCard extends StatelessWidget {
  final String title;
  final String iconPath;
  final String buttonTitle;

  const MediaCenterCard({
    Key? key,
    required this.title,
    required this.iconPath,
    required this.buttonTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
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
              SizedBox(height: 16),
              Text(
                title,
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
              ),

              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
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
                      backgroundColor: Color(0xFF1B8354),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      buttonTitle,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
