class User {
  final String username;
  final String profileImageUrl;
  final String uid;
  final String email;
  User(
      {required this.uid,
      required this.email,
      required this.profileImageUrl,
      required this.username});
  Map<String, dynamic> toJson() => {
        "username": username,
        "profileImageUrl": profileImageUrl,
        "uid": uid,
        "email": email
      };
}
