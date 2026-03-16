import 'package:flutter/material.dart';

enum Direction {
  horizontal,
  vertical,
}

class FbGap extends StatelessWidget {
  const FbGap({super.key, this.direction});

  final Direction? direction;

  @override
  Widget build(BuildContext context) {
    double w = 0;
    double h = 0;

    if (direction == Direction.horizontal) {
      w = 16.0;
    } else {
      h = 16.0;
    }

    return SizedBox(width: w, height: h);
  }
}
