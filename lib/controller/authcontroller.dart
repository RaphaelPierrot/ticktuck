import 'dart:io';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import 'package:tiktuck/screen/login_screen.dart';
import 'package:tiktuck/screen/home_screen.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  late Rx<User?> _user; // Doit être initialisée correctement.
  late Rx<File?> _pickedImage =
      Rx<File?>(null); // Initialise avec une valeur nulle.

  File? get profilePhoto => _pickedImage.value;

  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(
        null); // Remplacez cela par la logique qui suit l'état de l'utilisateur.
    ever(_user, _setInitialScreen); // Moniteur de changement.
  }

  void _setInitialScreen(User? user) {
    if (user == null) {
      Get.offAll(() => LoginScreen());
    } else {
      Get.offAll(() => const HomeScreen());
    }
  }

  void pickImage() async {
    try {
      FilePickerResult? pickedImage = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: false,
      );

      if (pickedImage != null && pickedImage.files.isNotEmpty) {
        String? filePath = pickedImage.files.single.path;
        if (filePath != null) {
          _pickedImage.value = File(filePath);
          Get.snackbar('Profile Picture', 'Successfully uploaded');
        } else {
          Get.snackbar('Error', 'File path is null');
        }
      } else {
        Get.snackbar('Cancelled', 'No file selected');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
    }
  }

  void registerUser(
      String username, String email, String password, File? image) async {
    try {
      if (username.isNotEmpty &&
          email.isNotEmpty &&
          password.isNotEmpty &&
          image != null) {
        // Simuler la création d'un utilisateur
        Get.snackbar('Success', 'User registered successfully');
      } else {
        Get.snackbar('Error', 'Please fill in all fields');
      }
    } catch (e) {
      Get.snackbar('Error creating account', e.toString());
    }
  }

  void loginUser(String email, String password) async {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        // Simuler une connexion réussie
        Get.snackbar('Success', 'User logged in successfully');
      } else {
        Get.snackbar('Error', 'Please enter all the fields');
      }
    } catch (e) {
      Get.snackbar('Error Logging in', e.toString());
    }
  }
}

class User {
  final String uid;
  final String email;
  final String profileImageUrl;
  final String username;

  User({
    required this.uid,
    required this.email,
    required this.profileImageUrl,
    required this.username,
  });

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'profileImageUrl': profileImageUrl,
      'username': username,
    };
  }
}
