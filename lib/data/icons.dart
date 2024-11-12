import 'dart:io';
import 'package:image/image.dart';

Image? sprite= decodeImage(File('img/icons.jpeg').readAsBytesSync());
// Extraire chaque icône
  List<Image> icons = [];
Image homeIcon=copyCrop(sprite!, x: 0, y: 50, width: 20, height: 20);
