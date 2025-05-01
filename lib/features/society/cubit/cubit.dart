import 'package:ataaby/features/login/data/models/login_model_lawyer.dart';
import 'package:ataaby/features/society/data/models/add_comment_from_post_model.dart';
import 'package:ataaby/features/society/data/models/add_post_model.dart';
import 'package:ataaby/features/society/data/models/add_reply_from_comment_or_reply_model.dart';
import 'package:ataaby/features/society/data/models/get_replies_models.dart';
import 'package:ataaby/features/society/data/models/posts_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../core/exports.dart';
import '../../login/data/models/login_model.dart';
import '../data/models/get_post_comment_model.dart';
import '../data/repos/repo_implementation.dart';
import 'state.dart';

class SocietyCubit extends Cubit<SocietyState> {
  SocietyCubit(this.api) : super(SocietyInitial());
  SocietyRepo api;

  TextEditingController postController = TextEditingController();
  TextEditingController commentController = TextEditingController();
  TextEditingController replyController = TextEditingController();

  PostsModel? postsModel;
  final formKey = GlobalKey<FormState>();
  getPostsData() async {
    emit(LoadingGetPostsData());
    final res = await api.getPostsData();
    res.fold((l) {
      emit(ErrorGetPostsData());
    }, (r) {
      postsModel = r;
      emit(LoadedGetPostsData());
    });
  }

  // حذف المنشور
  deletePostData({required int idPost}) async {
    emit(LoadingDeletePostData());
    final res = await api.deletePostData(id: idPost.toString());
    res.fold((l) {
      errorGetBar(l.toString());
      emit(ErrorDeletePostData());
    }, (r) {
      successGetBar(r.msg ?? '');
      getPostsData();
      emit(LoadedDeletePostData());
    });
  } // حذف الكومنت علي البوست

  deleteCommentFromPostData(
      {required int commentId, required int idPost}) async {
    emit(LoadingDeletePostData());
    final res = await api.deleteCommentFromPostData(id: commentId.toString());
    res.fold((l) {
      errorGetBar(l.toString());
      emit(ErrorDeletePostData());
    }, (r) {
      successGetBar(r.msg ?? '');
      getCommentPostData(idPost: idPost);
      emit(LoadedDeletePostData());
    });
  }

  // حذف الرد علي الكومنت
  deleteReplyFromCommentData(
      {required int replyId, required int idPost}) async {
    emit(LoadingDeletePostData());
    final res = await api.deleteReplyFromCommentData(id: replyId.toString());
    res.fold((l) {
      errorGetBar(l.toString());
      emit(ErrorDeletePostData());
    }, (r) {
      successGetBar(r.msg ?? '');
      getCommentPostData(idPost: idPost);

      emit(LoadedDeletePostData());
    });
  }

  PostModel? addPostModel;
  addPostData() async {
    emit(LoadingAddPostsData());
    final res = await api.addPostData(
      body: postController.text,
      images: profileImage,
    );
    res.fold((l) {
      emit(ErrorAddPostsData());
    }, (r) {
      addPostModel = r;
      successGetBar(r.msg ?? '');
      postController.clear();
      removeImage();
      getPostsData();
      emit(LoadedAddPostsData());
    });
  }

  AddReplyFromCommentOrReplyModel? addReplyFromCommentOrReplyModel;
  addReplyFromCommentOrReplyData(
      {required int idPost,
      required int commentId,
      required String reply}) async {
    emit(LoadingAddReplyFromCommentOrReplyData());
    final res = await api.addReplyFromCommentOrReply(
        commentId: commentId, reply: reply);
    res.fold((l) {
      emit(ErrorReplyFromCommentOrReplyData());
    }, (r) {
      addReplyFromCommentOrReplyModel = r;
      // successGetBar(r.msg ?? '');
      getRepliesData(idComment: commentId);
      replyController.clear();
      scrollToBottom();

      emit(LoadedReplyFromCommentOrReplyData());
    });
  }

  ScrollController scrollController = ScrollController();

  void scrollToBottom() {
    scrollController.animateTo(scrollController.position.maxScrollExtent,
        duration: const Duration(seconds: 1), curve: Curves.fastOutSlowIn);
  }

  GetCommentsModel? getCommentsModel;
  getCommentPostData({required int idPost}) async {
    emit(LoadingGetCommentPostData());
    final res = await api.getPostsCommentData(idPost: idPost);
    res.fold((l) {
      emit(ErrorGetCommentPostData());
    }, (r) {
      getCommentsModel = r;
      emit(LoadedGetCommentPostData());
    });
  }

  GetRepliesModel? getRepliesModel;
  getRepliesData({required int idComment}) async {
    emit(LoadingGetRepliesData());
    final res = await api.getRepliesData(idComment: idComment);
    res.fold((l) {
      emit(ErrorGetRepliesData());
    }, (r) {
      getRepliesModel = r;
      emit(LoadedGetRepliesData());
    });
  }

  AddCommentFromPostModel? addCommentFromPostModel;
  addCommentFromPost({required int blogId}) async {
    emit(LoadingAddCommentFromPostData());
    final res = await api.addCommentFromPostData(
      blogId: blogId,
      comment: commentController.text,
    );
    res.fold((l) {
      emit(ErrorAddCommentFromPostData());
    }, (r) {
      addCommentFromPostModel = r;
      commentController.clear();
      getCommentPostData(idPost: blogId);
      emit(LoadedAddCommentFromPostData());
    });
  }

  bool isEmojiVisible = false;
  void toggleEmojiKeyboard() {
    isEmojiVisible = !isEmojiVisible;
    emit(OntoggleEmojiSocietyState());
  }

  List<File>? profileImage;
  void removeImage() {
    profileImage = null;
    emit(FileRemovedSuccessfully());
  }

  Future<void> pickImageWithPermission(BuildContext context) async {
    final status = await Permission.camera.status;
    if (status.isGranted) {
      pickImage(context, isGallery: false);
    } else {
      final result = await Permission.camera.request();
      if (result.isGranted) {
        pickImage(context, isGallery: false);
      } else {
        emit(UpdateProfileError());
        Navigator.pop(context);
      }
    }
  }

  Future<void> pickImage(BuildContext context,
      {required bool isGallery}) async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(
        source: isGallery ? ImageSource.gallery : ImageSource.camera,
      );
      if (pickedFile != null) {
        await _handlePickedFile(pickedFile);
      } else {
        emit(FilePickCancelled());
      }
    } catch (e) {
      emit(UpdateProfileError());
    } finally {
      Navigator.pop(context);
    }
  }

  Future<void> _handlePickedFile(XFile pickedFile) async {
    profileImage = [File(pickedFile.path)]; // تحويل الملف إلى List
    emit(UpdateProfileImagePicked());
  }

  void showImagePickerOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "choose_an_option".tr(),
                style: TextStyle(
                    fontSize: 18.sp * textScaleFactor(context),
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16.h),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: Text("pick_from_gallery".tr()),
                onTap: () {
                  Navigator.pop(context);
                  pickImage(context, isGallery: true);
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: Text("take_a_photo".tr()),
                onTap: () {
                  Navigator.pop(context);
                  pickImage(context, isGallery: false);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  addPostAction(
      {String? reaction = 'like', required PostsModelData post}) async {
    emit(LoadingAddActionPostData());
    final res = await api.addPostAction(
        blogId: post.id?.toString() ?? 'like', reaction: reaction);
    res.fold((l) {
      emit(ErrorAddActionPostData());
    }, (r) {
      if (reaction == 'like') {
        if (post.isLiked == true) {
          // If already liked, unlike it
          post.isLiked = false;
          post.countLike = (post.countLike ?? 1) - 1;
        } else {
          // If not liked, like it
          post.isLiked = true;
          post.countLike = (post.countLike ?? 0) + 1;

          // If previously disliked, reset the dislike state
          if (post.isDisliked == true) {
            post.isDisliked = false;
            post.countDislike = (post.countDislike ?? 1) - 1;
          }
        }
      } else if (reaction == 'dislike') {
        if (post.isDisliked == true) {
          // If already disliked, undislike it
          post.isDisliked = false;
          post.countDislike = (post.countDislike ?? 1) - 1;
        } else {
          // If not disliked, dislike it
          post.isDisliked = true;
          post.countDislike = (post.countDislike ?? 0) + 1;

          // If previously liked, reset the like state
          if (post.isLiked == true) {
            post.isLiked = false;
            post.countLike = (post.countLike ?? 1) - 1;
          }
        }
      }

      emit(LoadedAddActionPostData());
    });
  }

  LoginModelLawyer? loginModelLawyer;
  Future<void> getDataFromSharedPreferences() async {
    emit(GetDataStateLoading());
    loginModelLawyer = await Preferences.instance.getLawyerModel();

    emit(GetDataStateLoaded());
  }

  LoginModel? loginUserModel;
  Future<void> getUserDataFromSharedPreferences() async {
    emit(GetDataStateLoading());
    loginUserModel = await Preferences.instance.getUserModel();
    emit(GetDataStateLoaded());
  }
}
