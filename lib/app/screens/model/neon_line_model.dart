import 'package:flutter/material.dart';

class NeonModel {
  List<Offset> offset;
  Color clr;
  double width;
  bool rainbow;
  bool neonEffect;
  NeonModel({
    required this.offset,
    this.clr = const Color(0xffffcdd2),
    required this.width,
    this.rainbow = false,
    this.neonEffect = true,
  });
}
