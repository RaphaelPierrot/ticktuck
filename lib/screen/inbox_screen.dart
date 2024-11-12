import 'package:flutter/material.dart';
import 'package:tiktuck/data/colors.dart';

class InboxScreen extends StatelessWidget {
  const InboxScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: tipo,
    );
  }
}