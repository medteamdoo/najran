import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart' as cs;

class CarouselExample extends StatefulWidget {
  const CarouselExample({super.key});

  @override
  State<CarouselExample> createState() => _CarouselExampleState();
}

class _CarouselExampleState extends State<CarouselExample> {
  final cs.CarouselSliderController _controller = cs.CarouselSliderController();

  final List<String> imagePaths = [
    'assets/images/najran.jpg',
    'assets/images/najran.jpg',
    'assets/images/najran.jpg',
  ];

  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        SizedBox(
          height: 200,
          child: cs.CarouselSlider(
            items: imagePaths.map((path) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  path,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              );
            }).toList(),
            options: cs.CarouselOptions(
              height: 200,
              viewportFraction: 0.9,
              enlargeCenterPage: true,
              autoPlay: true,
              onPageChanged: (index, reason) {
                setState(() => _current = index);
              },
            ),
            carouselController: _controller,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          alignment: WrapAlignment.center,
          children: imagePaths.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => _controller.animateToPage(entry.key),
              child: Container(
                width: 12,
                height: 12,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _current == entry.key
                      ? Color(0xFF1B8354)
                      : Colors.grey,
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
