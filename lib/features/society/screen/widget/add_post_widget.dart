import 'package:ataaby/core/utils/custom_loading.dart';
import 'package:ataaby/features/society/cubit/state.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart' as tr;
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import '../../../../core/exports.dart';
import '../../../../core/widgets/image_view.dart';
import '../../cubit/cubit.dart';

class AddPostCard extends StatelessWidget {
  const AddPostCard({required this.cubit, super.key});
  final SocietyCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.card,
      elevation: 2,
      shadowColor: Colors.grey.shade50,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
        ),
        decoration: BoxDecoration(
          color: AppColors.white,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            20.h.verticalSpace,
            if (cubit.profileImage != null)
              Padding(
                padding: EdgeInsets.only(bottom: 8.h),
                child: Container(
                  padding: EdgeInsets.all(5.0.sp),
                  child: DottedBorder(
                    color: Colors.black.withOpacity(0.2),
                    strokeWidth: 1,
                    borderType: BorderType.RRect,
                    radius: const Radius.circular(8),
                    dashPattern: const [12, 3],
                    child: SizedBox(
                      height: 150.h,
                      width: double.infinity,
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12.r),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ImageView(
                                      isFile: true,
                                      image: cubit.profileImage?.first.path,
                                    ),
                                  ),
                                );
                              },
                              child: Image.file(
                                File(cubit.profileImage!.first.path),
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: 150.h,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 2.h,
                            right: 2.w,
                            child: GestureDetector(
                              onTap: cubit.removeImage,
                              child: CircleAvatar(
                                backgroundColor: Colors.red,
                                radius: 12.r,
                                child: Icon(
                                  Icons.close_rounded,
                                  color: Colors.white,
                                  size: 12.sp,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            Form(
              key: cubit.formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 2.0, vertical: 12.0),
                    child: DynamicTextField(controller: cubit.postController),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.only(
                      end: 16.0.w,
                      top: 8.0.h,
                      bottom: 8.0.h,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Spacer(),
                        InkWell(
                          onTap: () {
                            cubit.showImagePickerOptions(context);
                          },
                          child: Container(
                              width: 37.w,
                              height: 37.w,
                              padding: EdgeInsets.all(8.w),
                              decoration: BoxDecoration(
                                  color: AppColors.greenLight,
                                  borderRadius: BorderRadius.circular(12.r)),
                              child: MySvgWidget(
                                  path: ImageAssets.gallaryIcon,
                                  imageColor: AppColors.white,
                                  size: 20.w)),
                        ),
                        10.horizontalSpace,
                        InkWell(
                          onTap: () {
                            _showBottomSheet(context);
                          },
                          child: Container(
                              width: 37.w,
                              height: 37.w,
                              padding: EdgeInsets.all(8.w),
                              decoration: BoxDecoration(
                                  color: AppColors.orangeLight,
                                  borderRadius: BorderRadius.circular(12.r)),
                              child: MySvgWidget(
                                  path: ImageAssets.emojiIcon,
                                  imageColor: AppColors.white,
                                  size: 20.w)),
                        ),
                        10.horizontalSpace,
                        BlocBuilder<SocietyCubit, SocietyState>(
                          builder: (context, state) {
                            return GestureDetector(
                              onTap: () {
                                if (!cubit.formKey.currentState!.validate() ||
                                    state is LoadingAddPostsData) {
                                  return;
                                } else {
                                  cubit.addPostData();
                                }
                              },
                              child: Container(
                                height: 37.5.h,
                                width: 72.w,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: AppColors.primary,
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                                child: (state is LoadingAddPostsData)
                                    ? Center(
                                        child: CustomLoadingIndicator(
                                            color: AppColors.white))
                                    : Text(
                                        'post'.tr(),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize:
                                              14.sp * textScaleFactor(context),
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      barrierColor: Colors.transparent,
      builder: (BuildContext context) {
        return Offstage(
          offstage: cubit.isEmojiVisible,
          child: SizedBox(
            height: 300.h, // Adjust the height as needed
            child: EmojiPicker(
              onEmojiSelected: (category, emoji) {
                cubit.postController.text += emoji.emoji;
              },
              textEditingController: cubit.postController,
              config: Config(
                  bottomActionBarConfig: BottomActionBarConfig(
                backgroundColor: AppColors.primary,
              )),
            ),
          ),
        );
      },
    );
  }
}

class DynamicTextField extends StatefulWidget {
  TextEditingController controller;

  DynamicTextField({required this.controller, super.key});

  @override
  _DynamicTextFieldState createState() => _DynamicTextFieldState();
}

class _DynamicTextFieldState extends State<DynamicTextField> {
  TextAlign _textAlign = TextAlign.right;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_updateTextAlign);
  }

  void _updateTextAlign() {
    if (!mounted) return;

    if (widget.controller.text.isNotEmpty) {
      final firstChar = widget.controller.text.characters.first;
      if (mounted) {
        // Ensure the widget is still mounted before calling setState
        setState(() {
          _textAlign = _isArabic(firstChar) ? TextAlign.right : TextAlign.left;
        });
      }
    } else {
      if (mounted) {
        setState(() {
          _textAlign = TextAlign.right;
        });
      }
    }
  }

  @override
  void dispose() {
    widget.controller
        .removeListener(_updateTextAlign); // Remove listener when disposed
    super.dispose();
  }

  bool _isArabic(String character) {
    final arabicRegex = RegExp(r'[\u0600-\u06FF]');
    return arabicRegex.hasMatch(character);
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      textAlign: _textAlign,
      decoration: InputDecoration(
        hintText: 'enter_post'.tr(),
        border: InputBorder.none,
        hintStyle: TextStyle(color: Colors.grey.shade400),
      ),
      maxLines: 5,
      minLines: 1,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return "يجب كتابة محتوى المنشور"; // Validation message
        }
        return null;
      },
    );
  }
}
