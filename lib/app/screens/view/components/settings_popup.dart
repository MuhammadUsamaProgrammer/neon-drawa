// ignore_for_file: prefer_const_constructors

import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neonTrail/app/screens/view/components/color_picker_popup.dart';
import 'package:neonTrail/app/screens/view/components/funky_overlay.dart';
import 'package:neonTrail/app/screens/viewModel/neon_draw_viewModel.dart';

class SettingsPopup extends StatelessWidget {
  SettingsPopup({
    super.key,
  });
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
                    height: 370,
                    width: width,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: const [
                          BoxShadow(
                              color: Color.fromARGB(144, 65, 56, 56),
                              blurRadius: 15,
                              spreadRadius: 15)
                        ]),
                    child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 10),
                        child: Obx(
                          () => Column(
                            children: [
                              SizedBox(
                                height: 30,
                                child: Row(
                                  children: const [
                                    Icon(Icons.settings),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Text(
                                      'Settings',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          'Background Color',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Spacer(),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5.0),
                                          child: GestureDetector(
                                            onTap: () {
                                              showDialog(
                                                barrierDismissible: true,
                                                useRootNavigator: false,
                                                barrierColor:
                                                    Colors.transparent,
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return ColorPickerPopup(
                                                      callBack: (v) {
                                                        neonVM
                                                            .changeBackgroundClr(
                                                                v);
                                                      },
                                                      clr: neonVM
                                                          .backgroundClr.value);
                                                },
                                              );
                                            },
                                            child: Container(
                                              height: 35,
                                              width: 35,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: neonVM
                                                          .backgroundClr.value,
                                                      width: 2),
                                                  color: Colors.transparent,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100)),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                child: Container(
                                                  height: 30,
                                                  width: 30,
                                                  decoration: BoxDecoration(
                                                      color: neonVM
                                                          .backgroundClr.value,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              100)),
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    Divider(
                                      height: 1,
                                      thickness: 1,
                                      color: Colors.grey,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'Neon Effect',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Spacer(),
                                        CupertinoSwitch(
                                            value: neonVM.isNeonEffect.value,
                                            onChanged: (v) {
                                              neonVM.toogleNeonEffect(v);
                                            }),
                                      ],
                                    ),
                                    Divider(
                                      height: 1,
                                      thickness: 1,
                                      color: Colors.grey,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'Rainbow',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Spacer(),
                                        CupertinoSwitch(
                                            value: neonVM.isRainbow.value,
                                            onChanged: (v) {
                                              neonVM.changeRainbow(v);
                                            }),
                                      ],
                                    ),
                                    if (!neonVM.isRainbow.value)
                                      Divider(
                                        height: 1,
                                        thickness: 1,
                                        color: Colors.grey,
                                      ),
                                    if (!neonVM.isRainbow.value)
                                      Row(
                                        children: [
                                          Text(
                                            'Drawing Color',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Spacer(),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 5.0),
                                            child: GestureDetector(
                                              onTap: () {
                                                showDialog(
                                                  barrierDismissible: true,
                                                  useRootNavigator: false,
                                                  barrierColor:
                                                      Colors.transparent,
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return ColorPickerPopup(
                                                        callBack: (v) {
                                                          neonVM.changeClr(v);
                                                        },
                                                        clr: neonVM.clr.value);
                                                  },
                                                );
                                              },
                                              child: Container(
                                                height: 35,
                                                width: 35,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: neonVM.clr.value,
                                                        width: 2),
                                                    color: Colors.transparent,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100)),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(5.0),
                                                  child: Container(
                                                    height: 30,
                                                    width: 30,
                                                    decoration: BoxDecoration(
                                                        color: neonVM.clr.value,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(100)),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    Divider(
                                      height: 1,
                                      thickness: 1,
                                      color: Colors.grey,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'Brush',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Spacer(),
                                        Slider(
                                            activeColor: Colors.black54,
                                            thumbColor: Colors.grey,
                                            max: 20,
                                            min: 1,
                                            value: neonVM.brushWidth.value,
                                            onChanged: (v) {
                                              neonVM.changeBrushWidth(v);
                                            }),
                                      ],
                                    ),
                                    Divider(
                                      height: 1,
                                      thickness: 1,
                                      color: Colors.grey,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'Erazer',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Spacer(),
                                        Slider(
                                            activeColor: Colors.black54,
                                            thumbColor: Colors.grey,
                                            max: 100,
                                            min: 20,
                                            value: neonVM.erazerWidth.value,
                                            onChanged: (v) {
                                              neonVM.changeErazerWidth(v);
                                            }),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )),
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
