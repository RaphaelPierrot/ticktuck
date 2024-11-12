
import 'package:cloud_firestore/cloud_firestore.dart';

class User{
  final String username;
  final String profileImageUrl;
  final String uid;
  final String email;
  User(  {required this.uid, required this.email,required this.profileImageUrl,required this.username});
  Map<String, dynamic>  toJson() =>{"username":username, "profileImageUrl":profileImageUrl,"uid":uid,"email":email};
  static User fromSnap(DocumentSnapshot snap){
    var snapshot= snap.data() as Map<String,dynamic>;
    return User(uid: snapshot['uid'], email: snapshot['email'], profileImageUrl: snapshot['profileImageUrl'], username: snapshot['username']);
  }

}