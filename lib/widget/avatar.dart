import 'package:flutter/material.dart';
import 'package:tiktuck/data/colors.dart';

class Avatar extends StatelessWidget {
  const Avatar({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        
        Container(margin: const EdgeInsets.only(bottom: 10),
        width: 50,
        height: 50,
        decoration: BoxDecoration(border: Border.all(color: Colors.white),borderRadius: BorderRadius.circular(25),image:const DecorationImage(image: AssetImage('img/logo.webp')))),
        Container(padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(color: followButton,borderRadius: BorderRadius.circular(20)),
        child: const Icon(Icons.add,color: Colors.white,size: 15,),)
      ],
    );
  }
}