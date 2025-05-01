import 'package:ataaby/core/utils/custom_loading.dart';
import 'package:ataaby/core/widgets/image_view.dart';
import 'package:ataaby/features/society/data/models/posts_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import '../../../../core/exports.dart';
import '../../cubit/cubit.dart';

class PostCard extends StatefulWidget {
  PostCard({
    required this.cubit,

    super.key,
    required this.postsModelData,
    this.isDetails = false,
  });
  SocietyCubit cubit;
  bool isDetails;
  PostsModelData postsModelData;

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  @override
  void initState() {
    super.initState();
    context.read<SocietyCubit>().getDataFromSharedPreferences();
    context.read<SocietyCubit>().getUserDataFromSharedPreferences();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 5.h, left: 14.w, right: 14.w),
      child: Material(
        borderRadius: BorderRadius.circular(10.r),
        elevation: 2,
        shadowColor: Colors.grey.shade50,
        color: AppColors.white,
        child: Container(
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 1),
                color: Colors.grey.shade300,
              ),
            ],
            color: AppColors.white,
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Column(
            children: [
              10.h.verticalSpace,
             Column(
               children: [

                 Row(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   mainAxisAlignment: MainAxisAlignment.start,
                   children: [
                     InkWell(
                       onTap: () {
                         Navigator.push(
                             context,
                             MaterialPageRoute(
                                 builder: (context) => ImageView(
                                   isAsset: false,
                                   image:
                                   widget.postsModelData.author?.image ??
                                       "",
                                 )));
                       },
                       child: CircleAvatar(
                         backgroundColor: AppColors.primary,
                         radius: 23.r,
                         child: CircleAvatar(
                           radius: 21.r,
                           backgroundImage: NetworkImage(
                               widget.postsModelData.author?.image ?? ""),
                         ),
                       ),
                     ),
                     Flexible(
                       fit: FlexFit.tight,
                       child: Padding(
                         padding: const EdgeInsetsDirectional.only(start: 5.0),
                         child: Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             Text(
                               widget.postsModelData.author?.name ?? '',
                               style: TextStyle(
                                   fontSize: 14.sp * textScaleFactor(context),
                                   color: const Color(0xff35373B)),
                             ),
                             Text(
                               widget.postsModelData.authorType ?? '',
                               style: TextStyle(
                                 height: 1.2,
                                 color: AppColors.textGreyColor,
                                 fontSize: 10.sp * textScaleFactor(context),
                               ),
                             ),
                             Text(
                               widget.postsModelData.createdAt ?? "",
                               style: TextStyle(
                                 color: AppColors.textGreyColor,
                                 fontSize: 10.sp * textScaleFactor(context),
                               ),
                             ),
                           ],
                         ),
                       ),
                     ),
                     (widget.cubit.loginModelLawyer?.data?.id ==
                         widget.postsModelData.author?.id ||
                         widget.cubit.loginUserModel?.data?.id ==
                             widget.postsModelData.author?.id)
                         ? PopupMenuButton<int>(
                       icon: Icon(
                         Icons.more_vert, // 🔹 أيقونة النقاط الثلاث
                         size: 20.sp,
                         color: const Color.fromRGBO(142, 163, 172, 1),
                       ),
                       onSelected: (value) async {
                         if (value == 1) {
                           // اختيار "حذف المنشور"
                           bool? confirmDelete = await showDialog(
                             context: context,
                             builder: (context) => AlertDialog(
                               title: Text("confirm_delete".tr()),
                               content: Text("do_you_delete_post".tr()),
                               actions: [
                                 TextButton(
                                   onPressed: () => Navigator.pop(
                                       context, false), // ❌ إلغاء
                                   child: Text("cancel".tr()),
                                 ),
                                 TextButton(
                                   onPressed: () => Navigator.pop(
                                       context, true), // ✅ تأكيد
                                   child: Text("delete".tr(),
                                       style: const TextStyle(
                                           color: Colors.red)),
                                 ),
                               ],
                             ),
                           );

                           if (confirmDelete == true) {
                             if (widget.isDetails) {
                               Navigator.pop(context);
                             }
                             await widget.cubit.deletePostData(
                                 idPost: widget.postsModelData.id ?? 0);
                           }
                         }
                       },
                       itemBuilder: (context) => [
                         PopupMenuItem<int>(
                           value: 1,
                           child: Row(
                             children: [
                               Text("delete_post".tr(),
                                   style: TextStyle(
                                       color: AppColors
                                           .blackLight)), // 🔹 ترجمة "حذف المنشور"
                             ],
                           ),
                         ),
                       ],
                     )
                         : SizedBox()
                   ],
                 ),
                 10.h.verticalSpace,
                 Align(
                   alignment: Alignment.topRight,
                   child: Text(
                     widget.postsModelData.body ?? '',
                     style: TextStyle(
                       fontSize: 14.sp * textScaleFactor(context),
                       color: AppColors.blackLiteColor,
                     ),
                   ),
                 ),
                 10.h.verticalSpace,
                 if (widget.postsModelData.files?.isNotEmpty ?? false)
                   SizedBox(
                     height: 200.h,
                     child: ListView.builder(
                       shrinkWrap: true,
                       physics: const NeverScrollableScrollPhysics(),
                       itemCount: widget.postsModelData.files!.length,
                       itemBuilder: (context, index) {
                         String? imageUrl =
                             widget.postsModelData.files![index].file;
                         if (imageUrl == null || imageUrl.isEmpty) {
                           return const SizedBox(); // لا تعرض شيء إذا كان الرابط فارغ
                         }
                         return InkWell(
                           onTap: () {
                             Navigator.push(
                               context,
                               MaterialPageRoute(
                                 builder: (context) =>
                                     ImageView(isAsset: false, image: imageUrl),
                               ),
                             );
                           },
                           child: ClipRRect(
                               borderRadius: BorderRadius.circular(10.r),
                               child: CachedNetworkImage(
                                 imageUrl:
                                 widget.postsModelData.files?[index].file ??
                                     "",
                                 placeholder: (context, url) =>
                                     Center(child: CustomLoadingIndicator()),
                                 errorWidget: (context, url, error) => Image.network(
                                     "https://img.freepik.com/premium-vector/404-error-page-found-concept-illustration_108061-173.jpg?semt=ais_hybrid"),
                               )),
                         );
                       },
                     ),
                   ),
               ],
             ),
              10.h.verticalSpace,
              Padding(
                padding: EdgeInsets.all(12.0.w),
                child: Row(
                  children: [
                    Column(
                      children: [
                        InkWell(
                            onTap: () {
                              widget.cubit.addPostAction(
                                  reaction: 'like',
                                  post: widget.postsModelData);
                            },
                            child: Icon(
                              CupertinoIcons.hand_thumbsup_fill,
                              color: widget.postsModelData.isLiked == true
                                  ? AppColors.primary
                                  : const Color.fromRGBO(142, 163, 172, 1),
                            )),
                        Text(
                          widget.postsModelData.countLike.toString() ?? "",
                          style: TextStyle(
                              fontSize: 12.sp, color: AppColors.textGreyColor),
                        ),
                      ],
                    ),
                    10.w.horizontalSpace,
                    Column(
                      children: [
                        InkWell(
                            onTap: () {
                              widget.cubit.addPostAction(
                                  reaction: 'dislike',
                                  post: widget.postsModelData);
                            },
                            child: Icon(
                              CupertinoIcons.hand_thumbsdown_fill,
                              color: widget.postsModelData.isDisliked == true
                                  ? AppColors.primary
                                  : const Color.fromRGBO(142, 163, 172, 1),
                            )),
                        Text(
                          widget.postsModelData.countDislike.toString() ?? "",
                          style: TextStyle(
                              fontSize: 12.sp, color: AppColors.textGreyColor),
                        ),
                      ],
                    ),
                    10.w.horizontalSpace,
                    //********************************* messages from model *******************************
                    Column(
                      children: [
                        InkWell(
                            onTap: () {},
                            child: const Icon(
                              CupertinoIcons.chat_bubble_2,
                              color: Color.fromRGBO(142, 163, 172, 1),
                            )),
                        Text(
                          widget.postsModelData.commentCount.toString() ?? "",
                          style: TextStyle(
                              fontSize: 12.sp, color: AppColors.textGreyColor),
                        ),
                      ],
                    ),
                    10.w.horizontalSpace,
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
