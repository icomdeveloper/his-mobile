import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:his/core/utils/app_colors.dart';
import 'package:his/core/utils/app_text_styles.dart';
import 'package:his/core/utils/assets.dart';
import 'package:his/core/widgets/text_container_widget.dart';

class ArticleWidget extends StatefulWidget {
  const ArticleWidget({super.key});

  @override
  State<ArticleWidget> createState() => _ArticleWidgetState();
}

class _ArticleWidgetState extends State<ArticleWidget> {
  bool isBookmarked = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          shadows: const [
            BoxShadow(
              color: Color(0x11000000),
              blurRadius: 6.10,
              offset: Offset(0, 0),
              spreadRadius: 0,
            )
          ]),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          AspectRatio(
            aspectRatio: 294 / 68,
            child: Image.asset(
              Assets.assetsImagesDoctestimage,
              fit: BoxFit.cover,
            ),
          ),
          Row(
            children: [
              const TextContainerWidget(text: 'Nutrition'),
              SizedBox(
                width: 11.w,
              ),
              Text(
                '8 Mins read',
                style: Styles.semiBoldRoboto10.copyWith(color: AppColors.grey),
              ),
              const Spacer(),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.share_outlined,
                      color: AppColors.primaryColor, size: 18)),
              IconButton(
                  onPressed: () {
                    setState(() {
                      isBookmarked = !isBookmarked;
                    });
                  },
                  icon: Icon(
                    isBookmarked
                        ? Icons.bookmark
                        : Icons.bookmark_border_outlined,
                    color: AppColors.primaryColor,
                    size: 18,
                  )),
            ],
          ),
          const Text(
            'Essential Vitamins for Male Reproductive Health .',
            style: Styles.semiBoldPoppins14,
          ),
          Text(
            'Lorem ipsum dolor sit amet consectetur. Dolor quis nullam et id sapien vulputate tempus tellus. Euismod tortor rutrum nibh lacus. Sit hendrerit libero felis quis magna pretium turpis aliquet et.',
            style: Styles.regularRoboto10.copyWith(color: AppColors.grey),
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            children: [
              SvgPicture.asset(Assets.assetsImagesLink),
              const SizedBox(
                width: 8,
              ),
              Text(
                'Loremipsumdolorsitametconsectetur ',
                style: Styles.regularRoboto10
                    .copyWith(color: const Color(0xff2463B6)),
              ),
            ],
          )
        ]),
      ),
    );
  }
}
