import 'package:flutter/material.dart';
import 'package:tiktuck/data/colors.dart';

class TextInputField extends StatelessWidget {
  const TextInputField({super.key, required this.controller, required this.labeltext, required this.icon,  this.isObscure= false});
  final TextEditingController controller;
  final String labeltext;
  final IconData icon;
  final bool isObscure;


  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(labelText: labeltext,prefixIcon: Icon(icon),labelStyle: TextStyle(fontSize: 20),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5),borderSide: BorderSide(color: tipoUnselected)),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5),borderSide: BorderSide(color: tipoUnselected))),
      obscureText: isObscure,
    );
  }
}