class PostModel {
  int id;
  String? post;
  String? postImage;
  String userName;
  String userImage;
  DateTime dateTime;
  bool isLiked;
  bool isDisLiked;
  PostModel({
    required this.id,
    this.post,
    this.isLiked = false,
    this.isDisLiked = false,
    this.postImage,
    required this.userName,
    required this.userImage,
    required this.dateTime,
  });
}
