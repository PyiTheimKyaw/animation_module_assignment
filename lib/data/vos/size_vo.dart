import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

class SizeVO{
  String? size;
  bool? isSelected;
  AnimationController? sizeAnimationController;
  Animation<Color?>? colorAnimation;
  SizeVO({required this.size, this.isSelected=false,this.sizeAnimationController,this.colorAnimation});
}