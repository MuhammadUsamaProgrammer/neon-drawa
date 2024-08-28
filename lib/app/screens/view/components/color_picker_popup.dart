// ignore_for_file: prefer_const_constructors

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_hsvcolor_picker/flutter_hsvcolor_picker.dart';
import 'package:get/get.dart';
import 'package:neonTrail/app/screens/view/components/funky_overlay.dart';
import 'package:neonTrail/app/screens/viewModel/neon_draw_viewModel.dart';

class ColorPickerPopup extends StatelessWidget {
  Function callBack;
  Color clr;
  ColorPickerPopup({super.key, required this.callBack, required this.clr});
  final neonVM = Get.find<NeonVM>();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;

    return Stack(
      children: [
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            color: Colors.white.withOpacity(0.1),
            width: width,
            height: height,
          ),
        ),
        Center(
          child: FunkyOverlay(
            child: Dialog(
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  Container(
                    // height: height / 3.5,
                    width: width,
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: const [
                          BoxShadow(
                              color: Color.fromARGB(255, 65, 56, 56),
                              blurRadius: 15,
                              spreadRadius: 15)
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ColorPicker(
                        color: clr,
                        onChanged: (value) {
                          callBack(value);
                        },
                        initialPicker: Picker.paletteHue,
                      ),
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.close))
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
