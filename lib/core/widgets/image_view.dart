import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:photo_view/photo_view.dart';

import '../../../core/utils/app_colors.dart';
import '../utils/assets_manager.dart';

class ImageView extends StatefulWidget {
  ImageView(
      {required this.image,
      this.isAsset = false,
      this.isFile = false,
      super.key});
  String? image;
  bool? isAsset;
  bool? isFile;

  @override
  State<ImageView> createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  @override
  Widget build(BuildContext context) {
    return Dismissible(
        key: const Key('some key here'),
        direction: DismissDirection.down,
        onDismissed: (_) => Navigator.pop(context),
        child: WillPopScope(
          onWillPop: () {
            Navigator.pop(context);
            return Future.value(false);
          },
          child: Scaffold(
              appBar: AppBar(
                  backgroundColor: Colors.transparent,
                  automaticallyImplyLeading: false,
                  actions: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.close_rounded,
                          color: AppColors.primary,
                        )),
                  ]),
              body: Container(
                margin: EdgeInsets.symmetric(
                  horizontal: 12.w,
                  vertical: 8.h,
                ),
                child: (widget.isFile == true && widget.image != null)
                    ? PhotoView(
                        imageProvider: FileImage(File(widget.image!)),
                        backgroundDecoration: const BoxDecoration(),
                        // enableRotation: true,
                        minScale: PhotoViewComputedScale.contained * 0.8,
                        maxScale: PhotoViewComputedScale.covered * 1.8,
                        initialScale: PhotoViewComputedScale.contained,
                        basePosition: Alignment.center,
                      )
                    : (widget.image == null || (widget.isAsset == true))
                        ? PhotoView(
                            imageProvider:
                                const AssetImage(ImageAssets.appIcon),
                            backgroundDecoration: const BoxDecoration(),
                            // enableRotation: true,
                            minScale: PhotoViewComputedScale.contained * 0.8,
                            maxScale: PhotoViewComputedScale.covered * 1.8,
                            initialScale: PhotoViewComputedScale.contained,
                            basePosition: Alignment.center,
                          )
                        : PhotoView(
                            imageProvider: NetworkImage(widget.image!),
                            backgroundDecoration: const BoxDecoration(),
                            // enableRotation: true,
                            minScale: PhotoViewComputedScale.contained * 0.8,
                            maxScale: PhotoViewComputedScale.covered * 1.8,
                            initialScale: PhotoViewComputedScale.contained,
                            basePosition: Alignment.center,
                          ),
              )),
        ));
  }
}
