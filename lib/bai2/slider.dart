import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MySliderPage(),
  ));
}

class MySliderPage extends StatefulWidget {
  const MySliderPage({super.key});

  @override
  State<MySliderPage> createState() => _MySliderPageState();
}

class _MySliderPageState extends State<MySliderPage> {
  int _currentIndex = 0;

  // SỬA TẠI ĐÂY: Sử dụng CarouselSliderController thay cho CarouselController
  final CarouselSliderController _controller = CarouselSliderController();

  final List<String> imgList = [
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSHm5aeQ6pRHEndfAvbDPefIPpbCL6qjfOXQu-4lLV8lQ&s',
    'https://images.unsplash.com/photo-1506744038136-46273834b3fb?w=800',
    'https://marketplace.canva.com/MADFf6O5thI/1/thumbnail_large/canva-beautiful-natural-background.-MADFf6O5thI.jpg',
    'https://images.unsplash.com/photo-1469474968028-56623f02e42e?w=800',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {},
        ),
        title: const Text(
          'Complicated image slider demo',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          CarouselSlider(
            carouselController: _controller,
            options: CarouselOptions(
              height: 240.0,
              initialPage: 0,
              enlargeCenterPage: true,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 3),
              viewportFraction: 0.8,
              onPageChanged: (index, reason) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
            items: imgList.asMap().entries.map((entry) {
              int index = entry.key;
              String imageUrl = entry.value;

              return ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey[300],
                          child: const Center(
                            child: Icon(Icons.broken_image, size: 50),
                          ),
                        );
                      },
                    ),
                    // Nhãn chữ "No. X image"
                    Positioned(
                      bottom: 12,
                      left: 12,
                      child: Text(
                        'No. $index image',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(
                              offset: const Offset(1, 1),
                              blurRadius: 4,
                              color: Colors.black.withOpacity(0.8),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Dấu chấm chỉ số
                    Positioned(
                      bottom: 12,
                      right: 12,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: imgList.asMap().entries.map((dotEntry) {
                          return GestureDetector(
                            onTap: () => _controller.animateToPage(dotEntry.key),
                            child: Container(
                              width: 8.0,
                              height: 8.0,
                              margin: const EdgeInsets.symmetric(horizontal: 3.0),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _currentIndex == dotEntry.key
                                    ? Colors.redAccent
                                    : Colors.white.withOpacity(0.6),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}