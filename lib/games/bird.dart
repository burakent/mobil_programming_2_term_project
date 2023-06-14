import 'package:flutter/cupertino.dart';

class MyBird extends StatelessWidget {
  final birdY;
  final double birdWidth;
  final double birdHeight;
  MyBird({
    this.birdY,
    required this.birdWidth,
    required this.birdHeight,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(0, (2 * birdY - birdHeight) / (2 - birdHeight)),
      child: Image.network(
        'https://art.pixilart.com/b0f4ca051aa111f.png',
        width: MediaQuery.of(context).size.height * birdWidth / 2,
        height: MediaQuery.of(context).size.height * 3 / 4 * birdHeight / 2,
        fit: BoxFit.fill,
      ),
    );
  }
}
