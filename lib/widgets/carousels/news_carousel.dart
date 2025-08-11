import 'dart:async';
import 'package:flutter/material.dart';

class CustomCarousel extends StatefulWidget {
  final List<Widget> items;
  final Duration autoPlayInterval;

  const CustomCarousel({
    Key? key,
    required this.items,
    this.autoPlayInterval = const Duration(seconds: 4),
  }) : super(key: key);

  @override
  State<CustomCarousel> createState() => _CustomCarouselState();
}

class _CustomCarouselState extends State<CustomCarousel> {
  late final PageController _pageController;
  double currentPage = 0;
  Timer? _autoPlayTimer;

  @override
  void initState() {
    super.initState();

    _pageController = PageController(
      viewportFraction: 0.75,
    ); // cartes plus proches

    // Suivi de la page courante
    _pageController.addListener(() {
      setState(() {
        currentPage = _pageController.page ?? 0;
      });
    });

    // Démarrer l’autoplay
    _autoPlayTimer = Timer.periodic(widget.autoPlayInterval, (timer) {
      if (_pageController.hasClients && widget.items.isNotEmpty) {
        int nextPage = (_pageController.page?.round() ?? 0) + 1;
        if (nextPage >= widget.items.length) {
          nextPage = 0; // revenir au début
        }
        _pageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _autoPlayTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 280,
      child: PageView.builder(
        controller: _pageController,
        itemCount: widget.items.length,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          double scale = (1 - (currentPage - index).abs() * 0.1).clamp(
            0.9,
            1.0,
          );
          double opacity = (1 - (currentPage - index).abs() * 0.3).clamp(
            0.7,
            1.0,
          );

          return Padding(
            // contrôle l’espace horizontal
            padding: const EdgeInsets.symmetric(horizontal: 0.0),
            child: Transform.scale(
              scale: scale,
              child: Opacity(opacity: opacity, child: widget.items[index]),
            ),
          );
        },
      ),
    );
  }
}
