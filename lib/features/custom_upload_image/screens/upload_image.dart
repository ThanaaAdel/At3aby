import 'package:dotted_border/dotted_border.dart';
import 'package:ataaby/core/exports.dart';
import '../cubit/upload_image_cubit.dart';
import '../cubit/upload_image_state.dart';

class ImageCustom extends StatefulWidget {
  const ImageCustom({super.key, this.color});

  final Color? color;
  @override
  State<ImageCustom> createState() => _ImageCustomState();
}

class _ImageCustomState extends State<ImageCustom> {
  @override
  void initState() {
    context.read<UploadImageCubit>().removeImage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<UploadImageCubit>();

    return BlocBuilder<UploadImageCubit, UploadImageState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 10.h),
          child: GestureDetector(
            onTap: () {
              cubit.showImageSourceDialog(context);
            },
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(5.0.sp),
                  child: DottedBorder(
                    color: Colors.black.withOpacity(0.2),
                    strokeWidth: 1,
                    borderType: BorderType.RRect,
                    radius: const Radius.circular(8),
                    dashPattern: const [12, 3],
                    child: SizedBox(
                      height: 70.h,
                      width: 70.w,
                      child: Stack(
                        children: [
                          // Display either the placeholder or the uploaded image
                          cubit.profileImage == null
                              ? Center(
                                  child: Icon(Icons.add,
                                      size: 20.sp * textScaleFactor(context),
                                      color: AppColors.primary),
                                )
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(12.r),
                                  child: Image.file(
                                    File(cubit.profileImage!.path),
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    height: 150.h,
                                    errorBuilder:
                                        (context, error, stackTrace) => Center(
                                      child: Padding(
                                        padding: EdgeInsets.all(
                                          20.sp * textScaleFactor(context),
                                        ),
                                        child: Image.asset(
                                          ImageAssets.splashLogoImage,
                                          color: AppColors.primary,
                                          width: 40.w,
                                          height: 40.h,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                          // Show remove button only if an image is uploaded
                          if (cubit.profileImage != null)
                            Positioned(
                              top: 10.h,
                              right: 10.w,
                              child: GestureDetector(
                                onTap: cubit.removeImage,
                                child: CircleAvatar(
                                  backgroundColor: Colors.red,
                                  radius: 15.r,
                                  child: Icon(
                                    Icons.close_rounded,
                                    color: Colors.white,
                                    size: 18.sp * textScaleFactor(context),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
