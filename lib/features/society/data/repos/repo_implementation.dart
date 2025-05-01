import 'package:ataaby/core/exports.dart';
import 'package:ataaby/features/new_register/data/model/default_model.dart';
import 'package:ataaby/features/society/data/models/add_comment_from_post_model.dart';
import 'package:ataaby/features/society/data/models/add_post_model.dart';
import 'package:ataaby/features/society/data/models/add_reply_from_comment_or_reply_model.dart';
import 'package:ataaby/features/society/data/models/get_replies_models.dart';
import 'package:ataaby/features/society/data/models/posts_model.dart';
import 'package:dio/dio.dart';

import '../models/get_post_comment_model.dart';

class SocietyRepo {
  BaseApiConsumer dio;
  SocietyRepo(this.dio);

  Future<Either<Failure, PostsModel>> getPostsData() async {
    try {
      final response = await dio.get(EndPoints.getPostsUrl);

      return Right(PostsModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
// حذف المنشور
  Future<Either<Failure, DefaultMainModel>> deletePostData(
      {required String id}) async {
    try {
      final response = await dio.get(EndPoints.deletePostUrl + id);

      return Right(DefaultMainModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  // comment from post حذف
  Future<Either<Failure, DefaultMainModel>> deleteCommentFromPostData(
      {required String id}) async {
    try {
      final response = await dio.get(EndPoints.deleteCommentFromPostUrl + id);

      return Right(DefaultMainModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
  // reply from comment حذف
  Future<Either<Failure, DefaultMainModel>> deleteReplyFromCommentData(
      {required String id}) async {
    try {
      final response = await dio.get(EndPoints.deleteReplyFromCommentUrl + id);

      return Right(DefaultMainModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, GetCommentsModel>> getPostsCommentData(
      {required int idPost}) async {
    try {
      final response =
          await dio.get(EndPoints.getPostCommentUrl + idPost.toString());

      return Right(GetCommentsModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
  Future<Either<Failure, GetRepliesModel>> getRepliesData(
      {required int idComment}) async {
    try {
      final response =
          await dio.get(EndPoints.getCommentsRepliesUrl + idComment.toString());

      return Right(GetRepliesModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  // اضافة تعليق
  Future<Either<Failure, AddCommentFromPostModel>> addCommentFromPostData({
    required int blogId,
    required String comment,
  }) async {
    try {
      final response = await dio.post(EndPoints.addCommentFromPostUrl, body: {
        "blog_id": blogId,
        "comment": comment,
      });

      return Right(AddCommentFromPostModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
  // اضافة رد علي  التعليق
  Future<Either<Failure, AddReplyFromCommentOrReplyModel>> addReplyFromCommentOrReply({
    required int commentId,
    required String reply,
  }) async {
    try {
      final response = await dio.post(EndPoints.addReplyFromCommentUrlOrReply, body: {
        "comment_id": commentId,
        "reply": reply,
      });

      return Right(AddReplyFromCommentOrReplyModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, PostModel>> addPostData({
    required String body,
    List<File>? images,
  }) async {
    try {
      final Map<String, dynamic> bodyData = {
        "body": body,
      };

      // إضافة الصور فقط إذا لم تكن القائمة فارغة
      if (images != null && images.isNotEmpty) {
        for (int i = 0; i < images.length; i++) {
          bodyData["files[$i]"] = MultipartFile.fromFileSync(
            images[i].path,
            filename: images[i].path.split('/').last,
          );
        }
      }

      final response = await dio.post(
        EndPoints.addPostUrl,
        formDataIsEnabled: true,
        body: bodyData,
      );

      return Right(PostModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, DefaultMainModel>> addPostAction({
    required String blogId,
    String? reaction,
  }) async {
    try {
      final response = await dio.post(
        EndPoints.addPostActionUrl,
        body: {"reaction": reaction, "blog_id": blogId},
      );

      return Right(DefaultMainModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
