import 'package:flutter/material.dart';

enum ScreenLocation {
  uppertext,
  lowertext,
  backgroundScreenColor,
  borderScreenColor,
}

class EditorScreenOption {
  int currentIndex = 0;
  int latestIndex = 0;
  bool isImageEdited = false;
  bool isScrollable = true;
  Color backgroundColor = Colors.white;
  Color borderColor = Colors.white;
}

class FontOption {
  String text;
  double size;
  double weightValue;
  FontWeight weight;
  Color color;
  TextEditingController controller;
  Map<String, dynamic> params;

  FontOption(this.size, this.weightValue, this.color) {
    text = "";
    weight = FontWeight.values[weightValue.round()];
    controller = TextEditingController();
    params = {};
  }

  void clear() {
    text = "";
    controller.clear();
  }

  void setWeight(double index) {
    weightValue = index;
    weight = FontWeight.values[weightValue.round()];
  }
}
