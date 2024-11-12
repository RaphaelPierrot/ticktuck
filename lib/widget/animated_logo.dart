import 'package:flutter/material.dart';
import 'dart:math';

import 'package:tiktuck/models/post.dart';
class AnimatedLogo extends StatefulWidget {
  final Post item;
  const AnimatedLogo({super.key,required this.item});

  @override
  State<AnimatedLogo> createState() => _AnimatedLogoState();
}

class _AnimatedLogoState extends State<AnimatedLogo> with SingleTickerProviderStateMixin{
  late AnimationController _controller;
  @override
  void initState() {
    _controller=AnimationController(duration: Duration(milliseconds: 4000),vsync: this);
    _controller.repeat();
    super.initState();
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      child: Container(height: 45,width: 45,padding: EdgeInsets.all(5),decoration: BoxDecoration(borderRadius: BorderRadius.circular(25),image: DecorationImage(image: AssetImage('img/disc_icon.png'))),
      child: Image.asset(widget.item.postedBy.profileImageUrl)),
      builder: (BuildContext context, Widget? child) {
        return Transform.rotate(angle: _controller.value*2*pi,child: child,) ;
      },
    );
  }
}