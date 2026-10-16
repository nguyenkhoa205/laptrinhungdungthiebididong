import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  final CarouselSliderController _controller = CarouselSliderController();
  final FocusNode _focusNode = FocusNode();

  final List<String> imgList = [
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQbNau3izdIRlqJ3GkvHsWokruuD_wRp6sO5WhDvCF_2g&s=10',
    'https://images.unsplash.com/photo-1506744038136-46273834b3fb?w=800',
    'https://marketplace.canva.com/MADFf6O5thI/1/thumbnail_large/canva-beautiful-natural-background.-MADFf6O5thI.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRB76ExMcvKJUVxQGdzlK_dgnDrd1XtWJqRpeS7f4mlcQ&s=10',
    'https://marketplace.canva.com/HCuXc/MAEzXIHCuXc/1/tl/canva--a-beautiful-scenery-of-a-mountain-range-MAEzXIHCuXc.jpg',
  ];

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _handleKeyEvent(KeyEvent event) {
    if (event is KeyDownEvent) {
      if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
        _controller.previousPage();
      } else if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
        _controller.nextPage();
      }
    }
  }

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
      body: KeyboardListener(
        focusNode: _focusNode,
        autofocus: true,
        onKeyEvent: _handleKeyEvent,
        child: Column(
          children: [
            const SizedBox(height: 20),

            // Carousel Slider chỉ hiển thị hình ảnh và nhãn chữ
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
                    ],
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 12),

            // HÀNG NÚT MŨI TÊN VÀ DẤU CHẤM NẰM CÙNG MỘT HÀNG BÊN DƯỚI
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Nút mũi tên Trái
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new, size: 18, color: Colors.blueAccent),
                  onPressed: () => _controller.previousPage(),
                ),

                const SizedBox(width: 8),

                // Hàng 5 dấu chấm chỉ số
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: imgList.asMap().entries.map((dotEntry) {
                    return GestureDetector(
                      onTap: () => _controller.animateToPage(dotEntry.key),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        width: _currentIndex == dotEntry.key ? 12.0 : 8.0,
                        height: 8.0,
                        margin: const EdgeInsets.symmetric(horizontal: 4.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _currentIndex == dotEntry.key
                              ? Colors.blueAccent
                              : Colors.grey.shade400,
                        ),
                      ),
                    );
                  }).toList(),
                ),

                const SizedBox(width: 8),

                // Nút mũi tên Phải
                IconButton(
                  icon: const Icon(Icons.arrow_forward_ios, size: 18, color: Colors.blueAccent),
                  onPressed: () => _controller.nextPage(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}