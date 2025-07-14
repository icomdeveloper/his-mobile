import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:his/core/utils/assets.dart';
import 'package:his/features/category/presentation/view/widgets/pdf_and_image_container.dart';

class ShowImageWidget extends StatelessWidget {
  const ShowImageWidget({
    super.key,
    required this.image,
    this.trailingIcon,
    this.errorWidget,
  });
  final Widget? trailingIcon;
  final String image;
  final Widget Function(BuildContext, String, Object)? errorWidget;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (_) => Container(
            margin: EdgeInsets.symmetric(horizontal: 24.w, vertical: 220.h),
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: CachedNetworkImage(
                imageUrl: image,
                errorWidget: errorWidget ??
                    (context, url, error) => const Icon(Icons.error),
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
        //     child: PhotoView(
        //         imageProvider: NetworkImage(
        //             widget.mediaModel!.image!)),
        //   ),
        // );
      },
      child: PDFAndImageContainer(
        title: 'Image',
        subTitle: 'image',
        trailingIcon:
            trailingIcon ?? SvgPicture.asset(Assets.assetsImagesImageView),
      ),
    );
  }
}
