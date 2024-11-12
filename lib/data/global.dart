
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:tiktuck/controller/authcontroller.dart';

Duration videoDuration=Duration(seconds: 0);
bool autoPlay=false;
// FIREBASE
var firebaseAuth= FirebaseAuth.instance;
var firebaseStorage= FirebaseStorage.instance;
var firestore= FirebaseFirestore.instance;

// CONTROLLER
var authController = AuthController.instance;