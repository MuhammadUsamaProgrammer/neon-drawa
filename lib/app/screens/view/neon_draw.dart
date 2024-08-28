// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neonTrail/app/screens/view/components/color_picker_popup.dart';
import 'package:neonTrail/app/screens/view/components/custom_painter.dart';
import 'package:neonTrail/app/screens/viewModel/neon_draw_viewModel.dart';

class NeonTrailScreen extends StatelessWidget {
  final neonVM = Get.put(NeonVM());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      floatingActionButton: Obx(
        () => Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              onPressed: neonVM.undo,
              backgroundColor: neonVM.linesHistory.isNotEmpty
                  ? Colors.red.shade100
                  : Colors.red.shade100.withOpacity(0.5),
              child: const Icon(Icons.undo),
            ),
            const SizedBox(width: 16),
            FloatingActionButton(
              onPressed: () {
                showDialog(
                  barrierDismissible: true,
                  useRootNavigator: false,
                  barrierColor: Colors.transparent,
                  context: context,
                  builder: (BuildContext context) {
                    return ColorPickerPopup();
                  },
                );
              },
              backgroundColor: neonVM.clr.value,
              child: const Icon(Icons.color_lens_outlined),
            ),
            const SizedBox(width: 16),
            FloatingActionButton(
              onPressed: () {
                neonVM.switchEraseMode(true);
              },
              backgroundColor: neonVM.isErasing.value
                  ? Colors.red.shade100
                  : Colors.red.shade100.withOpacity(0.5),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Image.asset("images/erase.png"),
              ),
            ),
            const SizedBox(width: 16),
            FloatingActionButton(
              onPressed: () {
                neonVM.switchEraseMode(false);
              },
              backgroundColor: !neonVM.isErasing.value
                  ? Colors.red.shade100
                  : Colors.red.shade100.withOpacity(0.5),
              child: const Icon(Icons.brush),
            ),
          ],
        ),
      ),
      body: GestureDetector(
        onPanStart: (details) {
          neonVM.saveState();
          if (!neonVM.isErasing.value) {
            neonVM.currentLine.value = [details.localPosition];
          }
        },
        onPanUpdate: (details) {
          if (neonVM.isErasing.value) {
            neonVM.eraseLine(details.localPosition);
          } else {
            neonVM.currentLine.add(details.localPosition);
          }
        },
        onPanEnd: (details) {
          if (!neonVM.isErasing.value) {
            neonVM.lines.add(neonVM.currentLine.value);
            neonVM.currentLine.value = [];
          }
        },
        child: Obx(
          () => CustomPaint(
            painter:
                NeonTrailPainter(neonVM.lines.value, neonVM.currentLine.value),
            child: Container(),
          ),
        ),
      ),
    );
  }
}
