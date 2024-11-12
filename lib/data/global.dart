import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tiktuck/controller/authcontroller.dart';

Duration videoDuration = Duration(seconds: 0);
bool autoPlay = false;
var firestore = FirebaseFirestore.instance;

// CONTROLLER
var authController = AuthController.instance;
