import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:his/core/utils/app_colors.dart';
import 'package:his/core/utils/assets.dart';
import 'package:his/features/category/data/model/media_model.dart';
import 'package:his/features/home/presentation/view/widgets/video_card_widget.dart';
import 'package:his/features/profile/presentation/view/widgets/pending_video_bottom_sheet.dart';

class PendingVideosSliverList extends StatelessWidget {
  const PendingVideosSliverList({
    super.key,
    required this.mediaList,
    this.isIconAppear = true,
  });
  final List<MediaModel> mediaList;
  final bool isIconAppear;
  @override
  Widget build(BuildContext context) {
    return SliverList.separated(
        separatorBuilder: (context, index) => const SizedBox(height: 24),
        itemCount: mediaList.length,
        itemBuilder: (context, index) => VideoCardWidget(
              mediaModel: mediaList[index],
              onIconTap: isIconAppear
                  ? () {
                      showModalBottomSheet(
                          showDragHandle: true,
                          isScrollControlled: true,
                          context: context,
                          backgroundColor: Colors.white,
                          builder: (context) =>
                              const PendingVideoBottomSheet());
                    }
                  : null,
              topRightIcon: isIconAppear
                  ? SvgPicture.asset(
                      Assets.assetsImagesInfo,
                      colorFilter: const ColorFilter.mode(
                          AppColors.primaryColor, BlendMode.srcIn),
                    )
                  : const SizedBox.shrink(),
              isDescriptionAppeared: false,
            ));
  }
}
