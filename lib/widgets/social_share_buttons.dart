import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';

class SocialShareButtons extends StatelessWidget {
  final String title;
  final String description;
  final String? url;
  final Uint8List? image; // image optionnelle

  const SocialShareButtons({
    Key? key,
    required this.title,
    required this.description,
    this.url,
    this.image,
  }) : super(key: key);

  Future<void> _shareContent(String platform) async {
    String content = "$title\n\n$description";
    if (url != null) {
      content += "\n\n$url";
    }

    if (image != null) {
      final tempDir = await getTemporaryDirectory();
      final file = await File('${tempDir.path}/shared_news.png').create();
      await file.writeAsBytes(image!);

      await Share.shareXFiles([XFile(file.path)], text: content);
    } else {
      await Share.share(content, subject: title);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildSocialButton(
          assetPath: "assets/icons/twitter.svg",
          onTap: () => _shareContent("twitter"),
        ),
        const SizedBox(width: 12),
        _buildSocialButton(
          assetPath: "assets/icons/instagram.svg",
          onTap: () => _shareContent("instagram"),
        ),
        const SizedBox(width: 12),
        _buildSocialButton(
          assetPath: "assets/icons/facebook.svg",
          onTap: () => _shareContent("facebook"),
        ),
      ],
    );
  }

  Widget _buildSocialButton({
    required String assetPath,
    required VoidCallback onTap,
  }) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: SvgPicture.asset(assetPath, width: 20, height: 20),
      ),
    );
  }
}
