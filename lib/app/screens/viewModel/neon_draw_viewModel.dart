import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neonTrail/app/screens/model/neon_line_model.dart';

class NeonVM extends GetxController {
  RxList<NeonModel> lines = <NeonModel>[].obs;
  RxList<List<NeonModel>> linesHistory = <List<NeonModel>>[].obs;
  Rx<NeonModel> currentLine = NeonModel(offset: [], width: 3).obs;
  RxBool isErasing = false.obs;

  void switchEraseMode(bool v) {
    isErasing.value = v;
  }

  Rx<Color> clr = Colors.red.obs;

  void changeClr(Color c) {
    clr.value = c;
  }

  Rx<Color> backgroundClr = Color(0xff000000).obs;

  void changeBackgroundClr(Color c) {
    backgroundClr.value = c;
  }

  RxDouble brushWidth = 8.0.obs;

  void changeBrushWidth(double w) {
    brushWidth.value = w;
  }

  RxDouble erazerWidth = 20.0.obs;

  void changeErazerWidth(double w) {
    erazerWidth.value = w;
  }

  RxBool isRainbow = false.obs;

  void changeRainbow(bool v) {
    isRainbow.value = v;
  }

  RxBool isNeonEffect = true.obs;

  void toogleNeonEffect(bool v) {
    isNeonEffect.value = v;
  }

  void undo() {
    if (linesHistory.isNotEmpty) {
      lines.value = linesHistory.removeLast();
      lines.refresh();
    }
  }

  void saveState() {
    linesHistory.add(lines
        .map((line) => NeonModel(
              offset: List<Offset>.from(line.offset),
              clr: line.clr,
              width: (brushWidth.value) / 2,
              rainbow: isRainbow.value,
              neonEffect: isNeonEffect.value,
            ))
        .toList());
    linesHistory.refresh();
  }

  void eraseLine(Offset point) {
    List<NeonModel> newLines = [];

    for (var model in lines) {
      List<Offset> newLineSegment = [];

      for (var p in model.offset) {
        if ((p - point).distance >= (erazerWidth.value) / 2) {
          newLineSegment.add(p);
        } else if (newLineSegment.isNotEmpty) {
          newLines.add(NeonModel(
              offset: newLineSegment,
              clr: model.clr,
              width: model.width,
              rainbow: model.rainbow));
          newLineSegment = [];
        }
      }

      if (newLineSegment.isNotEmpty) {
        newLines.add(NeonModel(
            offset: newLineSegment,
            clr: model.clr,
            width: model.width,
            rainbow: model.rainbow));
      }
    }

    lines.value = newLines;
    lines.refresh();
  }
}
