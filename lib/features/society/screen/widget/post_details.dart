import 'package:ataaby/core/utils/custom_loading.dart';
import 'package:ataaby/features/society/cubit/state.dart';
import 'package:ataaby/features/society/screen/widget/post_cart.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../core/exports.dart';
import '../../../../core/widgets/custom_appbar_title_and_back.dart';
import '../../../lawyer/profile_lawyer/cubit/profile_lawyer_cubit.dart';
import '../../cubit/cubit.dart';
import '../../data/models/posts_model.dart';

class PostDetailsScreen extends StatefulWidget {
  final SocietyCubit cubit;

  final int idPost;
  final PostsModelData postsModelData;
  final bool isLawyer;
  const PostDetailsScreen(
      {super.key,
      required this.cubit,
      required this.idPost,
      required this.postsModelData,
      required this.isLawyer});

  @override
  State<PostDetailsScreen> createState() => _PostDetailsScreenState();
}

class _PostDetailsScreenState extends State<PostDetailsScreen> {
  String? replyTo; // 🔹 تخزين اسم الشخص الذي يتم الرد عليه

  @override
  void initState() {
    context.read<SocietyCubit>().getDataFromSharedPreferences();
    context.read<SocietyCubit>().getUserDataFromSharedPreferences();
    context.read<SocietyCubit>().getCommentPostData(idPost: widget.idPost);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomAppBarTitleAndbackButton(
                title: 'society'.tr(),
                isLawyer: widget.isLawyer ? true : false),
            ListView(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: [
                PostCard(
                  cubit: widget.cubit,
                  isDetails: true,
                  postsModelData: widget.postsModelData,
                ),
                10.h.verticalSpace,
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                  child: Text(
                    "comments".tr(),
                    style:
                        TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                  ),
                ),
                BlocBuilder<SocietyCubit, SocietyState>(
                  builder: (context, state) {
                    var postFromComment =
                        context.read<SocietyCubit>().getCommentsModel?.data;
                    return (state is LoadingGetCommentPostData ||
                            postFromComment == null)
                        ? Center(child: CustomLoadingIndicator())
                        : postFromComment.isEmpty
                            ? Center(child: Text("no_comment".tr()))
                            : ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: postFromComment.length,
                                itemBuilder: (context, index) {
                                  var comment = postFromComment[index];

                                  return Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 8.h, horizontal: 10.w),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            CircleAvatar(
                                              radius: 18.r,
                                              backgroundImage: NetworkImage(
                                                  comment.author?.image ?? ""),
                                            ),
                                            SizedBox(width: 10.w),
                                            Expanded(
                                              child: Container(
                                                padding: EdgeInsets.all(10.w),
                                                decoration: BoxDecoration(
                                                  color: Colors.grey.shade200,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.r),
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Text(
                                                          comment.author
                                                                  ?.name ??
                                                              '',
                                                          style: TextStyle(
                                                              fontSize: 14.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        const Spacer(),
                                                        widget
                                                                    .cubit
                                                                    .loginModelLawyer
                                                                    ?.data
                                                                    ?.id ==
                                                                comment
                                                                    .author?.id
                                                            ? PopupMenuButton<
                                                                int>(
                                                                icon: Icon(
                                                                  Icons
                                                                      .more_vert,
                                                                  size: 18.sp,
                                                                  color: const Color
                                                                      .fromRGBO(
                                                                      142,
                                                                      163,
                                                                      172,
                                                                      1),
                                                                ),
                                                                onSelected:
                                                                    (value) async {
                                                                  if (value ==
                                                                      1) {
                                                                    bool?
                                                                        confirmDelete =
                                                                        await showDialog(
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (context) =>
                                                                              AlertDialog(
                                                                        title: Text(
                                                                            "confirm_delete".tr()),
                                                                        content:
                                                                            Text("do_you_delete_comment".tr()),
                                                                        actions: [
                                                                          TextButton(
                                                                            onPressed: () =>
                                                                                Navigator.pop(context, false), // ❌ إلغاء
                                                                            child:
                                                                                Text("cancel".tr()),
                                                                          ),
                                                                          TextButton(
                                                                            onPressed: () =>
                                                                                Navigator.pop(context, true), // ✅ تأكيد
                                                                            child:
                                                                                Text("delete".tr(), style: const TextStyle(color: Colors.red)),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    );

                                                                    if (confirmDelete ==
                                                                        true) {
                                                                      await widget
                                                                          .cubit
                                                                          .deleteCommentFromPostData(
                                                                        commentId:
                                                                            comment.id ??
                                                                                0,
                                                                        idPost:
                                                                            widget.idPost ??
                                                                                0,
                                                                      );
                                                                    }
                                                                  }
                                                                },
                                                                itemBuilder:
                                                                    (context) =>
                                                                        [
                                                                  PopupMenuItem<
                                                                      int>(
                                                                    value: 1,
                                                                    child: Row(
                                                                      children: [
                                                                        Text(
                                                                            "delete_comment"
                                                                                .tr(),
                                                                            style:
                                                                                TextStyle(color: AppColors.blackLight)), // 🔹 ترجمة "حذف التعليق"
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              )
                                                            : const SizedBox()
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      children: [
                                                        Expanded(
                                                          child: Text(
                                                            comment.comment ??
                                                                '',
                                                            style: TextStyle(
                                                                fontSize: 14.sp,
                                                                color: Colors
                                                                    .black),
                                                          ),
                                                        ),
                                                        InkWell(
                                                          onTap: () async {
                                                            await widget.cubit
                                                                .getRepliesData(
                                                                    idComment:
                                                                        comment.id ??
                                                                            0);
                                                            showReplyPopup(
                                                                idPost: widget
                                                                        .idPost ??
                                                                    0,
                                                                context,
                                                                idComment:
                                                                    comment.id ??
                                                                        0);
                                                          },
                                                          child: Text(
                                                            "  ${'replies'.tr()}",
                                                            style: TextStyle(
                                                                fontSize: 14.sp,
                                                                color: AppColors
                                                                    .gray),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BlocBuilder<SocietyCubit, SocietyState>(
        builder: (context, state) {
          var cubit = context.read<SocietyCubit>();
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(color: Colors.grey.shade300, blurRadius: 5)
              ],
            ),
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: 2.0.h, bottom: 0.h, right: 5.w, left: 5.w),
                  child: CircleAvatar(
                    backgroundColor: AppColors.white,
                    backgroundImage: NetworkImage(context
                            .read<ProfileLawyerCubit>()
                            .loginModelLawyer
                            ?.data
                            ?.image ??
                        "https://static.vecteezy.com/system/resources/previews/013/215/160/non_2x/picture-profile-icon-male-icon-human-or-people-sign-and-symbol-vector.jpg"),
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: TextField(
                    controller: cubit.commentController,
                    decoration: InputDecoration(
                      hintText: replyTo != null
                          ? "@$replyTo "
                          : "write_your_comment".tr(),
                      hintStyle: TextStyle(fontSize: 14.sp, color: Colors.grey),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    if (cubit.commentController.text.isEmpty) {
                      return;
                    } else {
                      cubit.addCommentFromPost(blogId: widget.idPost);
                      setState(() {
                        cubit.commentController.text =
                            replyTo != null ? "@$replyTo " : "";
                      });
                    }
                  },
                  icon: Icon(Icons.send,
                      color: (state is LoadingAddCommentFromPostData)
                          ? AppColors.gray
                          : AppColors.secondPrimary),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

void showReplyPopup(BuildContext context,
    {required int idComment, required int idPost}) {
  showModalBottomSheet(
    backgroundColor: AppColors.white,
    context: context,
    useRootNavigator: true,
    showDragHandle: true,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return BlocBuilder<SocietyCubit, SocietyState>(builder: (context, state) {
        var cubit = context.read<SocietyCubit>();

        return Padding(
          padding:
              EdgeInsets.only(bottom: 10.h, left: 10.w, right: 10.w, top: 10.h),
          child: Container(
            padding: EdgeInsets.all(10.w),
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.6,
            ),
            child:
                // ( state is LoadingGetRepliesData|| cubit.getRepliesModel?.data == null)?
                // Center(child: CustomLoadingIndicator(),):
                //
                Column(
              children: [
                (cubit.getRepliesModel?.data?.length == 0)
                    ? Flexible(
                        child: Center(
                            child: Text(
                        'no_replies'.tr(),
                        style: TextStyle(fontSize: 16.sp),
                      )))
                    : Flexible(
                        fit: FlexFit.tight,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 10.h,
                            horizontal: 10.w,
                          ),
                          child: ListView.builder(
                            shrinkWrap: true,
                            padding: EdgeInsets.only(
                              bottom: 80.h,
                            ),
                            controller: cubit.scrollController,
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemCount: cubit.getRepliesModel?.data?.length ?? 0,
                            itemBuilder: (context, index) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    radius: 18.r,
                                    backgroundImage: NetworkImage(cubit
                                            .getRepliesModel
                                            ?.data?[index]
                                            .author
                                            ?.image ??
                                        ''),
                                  ),
                                  SizedBox(width: 10.w),
                                  Expanded(
                                    child: Container(
                                      padding: EdgeInsets.only(
                                          top: 10.h,
                                          bottom: 10.h,
                                          left: 10.w,
                                          right: 10.w),
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade200,
                                        borderRadius:
                                            BorderRadius.circular(8.r),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            cubit.getRepliesModel?.data?[index]
                                                    .author?.name ??
                                                '',
                                            style: TextStyle(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            cubit.getRepliesModel?.data?[index]
                                                    .reply ??
                                                '',
                                            style: TextStyle(
                                                fontSize: 14.sp,
                                                color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: cubit.replyController,
                        keyboardType: TextInputType.multiline,
                        textInputAction:
                            TextInputAction.newline, // يسمح بإضافة أسطر جديدة
                        minLines: 1, // يبدأ بسطر واحد
                        maxLines: 2, // يتمدد تلقائيًا
                        decoration: InputDecoration(
                          hintText: "اكتب ردك هنا...",
                          hintStyle:
                              TextStyle(fontSize: 14.sp, color: Colors.grey),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.r),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 10.w, vertical: 10.h),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.send,
                          color:
                              (state is LoadingAddReplyFromCommentOrReplyData)
                                  ? AppColors.gray
                                  : AppColors.secondPrimary),
                      onPressed: () {
                        if (cubit.replyController.text.isNotEmpty) {
                          cubit.addReplyFromCommentOrReplyData(
                            idPost: idPost,
                            commentId: idComment,
                            reply: cubit.replyController.text,
                          );
                        }
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      });
    },
  );
}
