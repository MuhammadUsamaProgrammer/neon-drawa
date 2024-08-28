import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neonTrail/app/screens/model/neon_line_model.dart';
import 'package:neonTrail/app/screens/view/components/custom_painter.dart';
import 'package:neonTrail/app/screens/view/components/settings_popup.dart';
import 'package:neonTrail/app/screens/viewModel/neon_draw_viewModel.dart';

class NeonTrailScreen extends StatelessWidget {
  final neonVM = Get.put(NeonVM());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Obx(
        () => Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const SizedBox(width: 30),
            FloatingActionButton(
              onPressed: () {
                showDialog(
                  barrierDismissible: true,
                  useRootNavigator: false,
                  barrierColor: Colors.transparent,
                  context: context,
                  builder: (BuildContext context) {
                    return SettingsPopup();
                  },
                );
              },
              backgroundColor: Colors.red.shade100,
              child: const Icon(Icons.settings),
            ),
            Spacer(),
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
      body: Obx(
        () => Container(
          color: neonVM.backgroundClr.value,
          child: GestureDetector(
            onPanStart: (details) {
              neonVM.saveState();
              if (!neonVM.isErasing.value) {
                neonVM.currentLine.value = NeonModel(
                    offset: [details.localPosition],
                    clr: neonVM.clr.value,
                    width: (neonVM.brushWidth.value) / 2,
                    rainbow: neonVM.isRainbow.value,
                    neonEffect: neonVM.isNeonEffect.value);
              }
            },
            onPanUpdate: (details) {
              if (neonVM.isErasing.value) {
                neonVM.eraseLine(details.localPosition);
              } else {
                neonVM.currentLine.value.offset.add(details.localPosition);
                neonVM.currentLine.refresh();
              }
            },
            onPanEnd: (details) {
              if (!neonVM.isErasing.value) {
                neonVM.lines.add(neonVM.currentLine.value);
                neonVM.currentLine.value = NeonModel(offset: [], width: 6);
              }
            },
            child: CustomPaint(
              painter: NeonTrailPainter(
                  neonVM.lines.value, neonVM.currentLine.value),
              child: Container(),
            ),
          ),
        ),
      ),
    );
  }
}
