import 'dart:math';

import 'package:flutter/material.dart';

class RandomColorModel {
  Random random = Random();
  Color getColor() {
    return Color.fromARGB(random.nextInt(800), random.nextInt(600),
        random.nextInt(700), random.nextInt(100));
  }
}
