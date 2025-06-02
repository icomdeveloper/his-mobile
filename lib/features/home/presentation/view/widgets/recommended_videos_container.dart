import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:his/core/utils/app_colors.dart';
import 'package:his/core/utils/app_text_styles.dart';
import 'package:his/core/utils/assets.dart';
import 'package:his/features/home/presentation/view/video_view.dart';

class RecommendedVideosContainer extends StatelessWidget {
  const RecommendedVideosContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: const BorderSide(color: AppColors.lightGrey, width: 1)),
      ),
      child: Column(
        children: [
          Stack(
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const VideoView();
                  }));
                },
                child: AspectRatio(
                  aspectRatio: 342 / 112,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12)),
                    child: Image.asset(
                      Assets.assetsImagesDoctestimage,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 0,
                left: 0,
                bottom: 0,
                top: 0,
                child: InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const VideoView();
                    }));
                  },
                  child: const Center(
                    child: CircleAvatar(
                        radius: 21,
                        backgroundColor: AppColors.primaryColor,
                        child: Icon(
                          Icons.play_arrow,
                          color: Colors.white,
                          size: 32,
                        )),
                  ),
                ),
              ),
              Positioned(
                right: 12,
                top: 12,
                child: SvgPicture.asset(
                  Assets.assetsImagesBookmarked,
                  colorFilter: const ColorFilter.mode(
                      AppColors.primaryColor, BlendMode.srcIn),
                ),
              ),
              Positioned(
                right: 13,
                bottom: 8,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
                    child: Text(
                      '10:14',
                      style:
                          Styles.regularRoboto8.copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Lorem ipsum dolor sit amet consectetur, Et in non nulla sed mi felis cursus .',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                  style: Styles.semiBoldPoppins14,
                ),
                Text(
                  'Lorem ipsum dolor sit amet consectetur. Lacus condimentum hendrerit euismod donec feugiat eu placerat. Cursus sed pellentesque lobortis auctor .',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                  style: Styles.regularRoboto12,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
