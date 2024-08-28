import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NeonVM extends GetxController {
  RxList<List<Offset>> lines = <List<Offset>>[].obs;
  RxList<List<List<Offset>>> linesHistory = <List<List<Offset>>>[].obs;
  RxList<Offset> currentLine = <Offset>[].obs;
  RxBool isErasing = false.obs;

  void switchEraseMode(bool v) {
    isErasing.value = v;
  }

  Rx<Color> clr = Color(0xffffcdd2).obs;

  void changeClr(Color c) {
    clr.value = c;
  }

  void undo() {
    if (linesHistory.isNotEmpty) {
      lines.value = linesHistory.removeLast();
      lines.refresh();
    }
  }

  void saveState() {
    linesHistory.add(lines.map((line) => List<Offset>.from(line)).toList());
    linesHistory.refresh();
  }

  void eraseLine(Offset point) {
    List<List<Offset>> newLines = [];

    for (var line in lines) {
      List<Offset> newLineSegment = [];

      for (var p in line) {
        if ((p - point).distance >= 20.0) {
          newLineSegment.add(p);
        } else if (newLineSegment.isNotEmpty) {
          newLines.add(newLineSegment);
          newLineSegment = [];
        }
      }

      if (newLineSegment.isNotEmpty) {
        newLines.add(newLineSegment);
      }
    }

    lines.value = newLines;
    lines.refresh();
  }
}
