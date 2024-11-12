import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:tiktuck/data/global.dart';
import 'package:tiktuck/models/user.dart' as model;
import 'package:image_picker/image_picker.dart';
import 'package:tiktuck/screen/login_screen.dart';
import 'package:tiktuck/screen/home_screen.dart';

class AuthController extends GetxController{

  static AuthController instance=Get.find();
  late Rx<User?> _user;
  late Rx<File?>_pickedImage;
  File? get profilePhoto=>_pickedImage.value;
  @override
  void onReady(){
    super.onReady();
    _user=Rx<User?>(firebaseAuth.currentUser);
    _user.bindStream(firebaseAuth.authStateChanges());
    ever(_user, _setInitialScreen);
  }
  _setInitialScreen(User? user){
    if (user==null) {
      Get.offAll(()=> LoginScreen());
    } else {
      Get.offAll(()=>const HomeScreen());
    }
  }
  void pickImage() async{
    final pickedImage= await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage!=null) {
      Get.snackbar('Profile Picture', 'Succefuly upload');
    }
    _pickedImage=Rx<File?>(File(pickedImage!.path));
  }
  Future<String> _uploadToStorage(File image) async{
    Reference ref=firebaseStorage.ref().child('profilePics').child(firebaseAuth.currentUser!.uid);
    UploadTask uploadTask=ref.putFile(image);
    TaskSnapshot snap= await uploadTask;
    String downloadUrl= await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  void registerUser(String username,String email,String password,File? image) async{
    try {if (username.isNotEmpty && email.isNotEmpty && password.isNotEmpty && image!=null) {
      UserCredential cred=await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);

      String downloadUrl=await _uploadToStorage(image!);
      model.User user= model.User(uid: cred.user!.uid, email: email, profileImageUrl: downloadUrl, username: username);
      await firestore.collection('users').doc(cred.user!.uid).set(user.toJson());
    }
    } catch (e) {
      Get.snackbar('error creating account' 'please enter all the fields', e.toString());
    }
  }
  void loginUser(String email, String password) async{
      try {
        if (email.isNotEmpty&&password.isNotEmpty){        
          await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
          Get.snackbar('Error Logging in', 'Please enter all the');
          }      
      } catch (e) { Get.snackbar('Error Logging in', e.toString());
      }
    }
  

}