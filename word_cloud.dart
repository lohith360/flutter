import 'dart:math';
import 'package:flutter/material.dart';

void main() => runApp(WordCloudApp());

class WordCloudApp extends StatefulWidget {
  @override
  _WordCloudAppState createState() => _WordCloudAppState();
}

class _WordCloudAppState extends State<WordCloudApp>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<String> words = ["Flutter", "Dart", "UI", "Code", "Creative", "Fun"];
  final random = Random();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Offset randomOffset(Size size) {
    return Offset(random.nextDouble() * size.width,
        random.nextDouble() * size.height);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: AnimatedBuilder(
          animation: _controller,
          builder: (context, _) {
            return LayoutBuilder(
              builder: (context, constraints) {
                return Stack(
                  children: words.map((word) {
                    final offset = randomOffset(constraints.biggest);
                    return Positioned(
                      left: offset.dx,
                      top: offset.dy,
                      child: Text(
                        word,
                        style: TextStyle(
                          color: Colors.primaries[random.nextInt(Colors.primaries.length)],
                          fontSize: 24 + random.nextDouble() * 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  }).toList(),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
