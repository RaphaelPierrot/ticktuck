
import 'package:tiktuck/models/user.dart';

class Post{
  User postedBy;
  String caption;
  String video;
  int like;
  int shared;
  int comment;
  int bookmarks;
  String audioName;
  Post({required this.caption,required this.postedBy,required this.comment,required this.like,required this.shared,required this.video,required this.bookmarks,required this.audioName});
}