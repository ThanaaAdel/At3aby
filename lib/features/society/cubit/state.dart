abstract class SocietyState {}

class SocietyInitial extends SocietyState {}

class OntoggleEmojiSocietyState extends SocietyState {}

class FilePickError extends SocietyState {
  final String message;

  FilePickError(this.message);
}

class FilePickCancelled extends SocietyState {}

class FilePickedSuccessfully extends SocietyState {
  final String filePath;
  final String base64String;

  FilePickedSuccessfully(this.filePath, this.base64String);
}

class FileRemovedSuccessfully extends SocietyState {}

class UpdateProfileError extends SocietyState {}

class UpdateProfileImagePicked extends SocietyState {}

class MakingLikeForPost extends SocietyState {}

class MakingDisLikeForPost extends SocietyState {}

class AddNewPostState extends SocietyState {}

class LoadedGetPostsData extends SocietyState {}

class ErrorGetPostsData extends SocietyState {}

class LoadingGetPostsData extends SocietyState {}

class LoadedAddPostsData extends SocietyState {}

class ErrorAddPostsData extends SocietyState {}

class LoadingAddPostsData extends SocietyState {}

class LoadingGetCommentPostData extends SocietyState {}

class ErrorGetCommentPostData extends SocietyState {}

class LoadedGetCommentPostData extends SocietyState {}

class LoadedAddCommentFromPostData extends SocietyState {}

class ErrorAddCommentFromPostData extends SocietyState {}

class LoadingAddCommentFromPostData extends SocietyState {}

class LoadedDeletePostData extends SocietyState {}

class ErrorDeletePostData extends SocietyState {}

class LoadingDeletePostData extends SocietyState {}

class LoadedAddActionPostData extends SocietyState {}

class LoadingAddActionPostData extends SocietyState {}

class ErrorAddActionPostData extends SocietyState {}

class LoadedReplyFromCommentOrReplyData extends SocietyState {}

class ErrorReplyFromCommentOrReplyData extends SocietyState {}

class LoadingAddReplyFromCommentOrReplyData extends SocietyState {}

class GetDataStateLoaded extends SocietyState {}

class GetDataStateLoading extends SocietyState {}
class LoadedGetRepliesData extends SocietyState {}

class ErrorGetRepliesData extends SocietyState {}

class LoadingGetRepliesData extends SocietyState {}
