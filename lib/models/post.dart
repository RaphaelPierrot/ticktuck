import 'package:tiktuck/models/user.dart';

class Post {
  User postedBy;
  String caption;
  String video;
  int like;
  int shared;
  int comment;
  int bookmarks;
  String audioName;
  Post(
      {required this.caption,
      required this.postedBy,
      required this.comment,
      required this.like,
      required this.shared,
      required this.video,
      required this.bookmarks,
      required this.audioName});
  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      caption: json['description'],
      video: 'http://localhost:3000/api' + json['videoUrl'],
      audioName: json['music'] ?? '',
      like: json['likes'],
      comment: json['comments'],
      shared: json['shares'],
      bookmarks: 0,
      postedBy: User(
        uid: '', // Si pas fourni dans l'API
        email: '', // Si pas fourni dans l'API
        username: json['username'],
        profileImageUrl: '', // Fournissez un URL par défaut
      ),
    );
  }
}
