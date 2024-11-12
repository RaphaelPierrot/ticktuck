import 'package:flutter/material.dart';
import 'package:tiktuck/data/colors.dart';

class ProgressBar extends StatelessWidget {
  const ProgressBar({super.key, required this.progress, this.onTap});
  final double progress;
  final Function(double)? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapUp: (TapUpDetails details) {
        if(onTap!=null) {
          onTap!(double.parse((details.globalPosition.dx/MediaQuery.of(context).size.width).toStringAsFixed(2)));}
      },
      child: Stack(children: [
        Container(height: 6,width: double.infinity,decoration: BoxDecoration(color:progressBarColor ),),
      Row(
        children: [
          Container(height: 4,width: MediaQuery.of(context).size.width*progress,decoration: BoxDecoration(color:progressBarProgessColor ),),
          Container(height: 6,width: 6,decoration: BoxDecoration(color: progressBarProgessColor,shape: BoxShape.circle),)
        ],
      ),
        
      ],),
    );
  }
}