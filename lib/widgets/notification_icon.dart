import 'package:flutter/material.dart';
import 'package:najran/widgets/circle_svg_icon.dart';

Widget buildNotificationIcon(BuildContext context, int notifCount) {
  return Stack(
    clipBehavior: Clip.none,
    children: [
      GestureDetector(
        onTap: () {
          _showNotificationsMenu(context); // fonction qu’on va créer
        },
        child: CircleSvgIcon(assetPath: 'assets/icons/notif.svg'),
      ),
      if (notifCount > 0)
        Positioned(
          right: -2,
          top: -2,
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
            constraints: const BoxConstraints(minWidth: 20, minHeight: 20),
            child: Text(
              notifCount.toString(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
    ],
  );
}

void _showNotificationsMenu(BuildContext context) {
  final RenderBox overlay =
      Overlay.of(context).context.findRenderObject() as RenderBox;

  showMenu(
    context: context,
    position: RelativeRect.fromLTRB(
      overlay.size.width, // à droite
      80, // un peu sous l’appbar
      16,
      0,
    ),
    items: [
      PopupMenuItem(
        child: ListTile(
          leading: Icon(Icons.notifications),
          title: Text("إشعار 1"),
          onTap: () {
            Navigator.pop(context); // ferme le menu
            // 👉 naviguer vers un détail
          },
        ),
      ),
      PopupMenuItem(
        child: ListTile(
          leading: Icon(Icons.notifications),
          title: Text("إشعار 2"),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ),
    ],
  );
}
