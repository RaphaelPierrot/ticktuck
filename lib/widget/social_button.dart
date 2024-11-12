import 'package:flutter/material.dart';
import 'package:tiktuck/data/colors.dart';

class SocialButton extends StatelessWidget {
  final Icon icon;
  final int number;
  const SocialButton({super.key,required this.icon,required this.number});

  @override
  Widget build(BuildContext context) {
    return Column(children: [icon,Text('$number',style: TextStyle(fontWeight: FontWeight.w600,color: tipo,fontSize: 12),)],);
  }
}