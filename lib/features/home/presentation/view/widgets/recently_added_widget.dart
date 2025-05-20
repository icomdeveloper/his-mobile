import 'package:flutter/material.dart';
import 'package:his/core/utils/app_text_styles.dart';
import 'package:his/core/utils/assets.dart';

class RecentlyAddedWidget extends StatelessWidget {
  const RecentlyAddedWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.35,
              child: AspectRatio(
                aspectRatio: 1.1,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(Assets.assetsImagesDoctestimage,
                      fit: BoxFit.fill),
                ),
              ),
            ),
            const SizedBox(width: 12),
            ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width -
                    (MediaQuery.of(context).size.width * 0.4) -
                    32 -
                    10,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Lorem ipsum dolor sit amet consectetur.',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 4,
                    style: Styles.semiBoldPoppins14,
                  ),
                  Text(
                    'Lorem ipsum dolor sit amet consectetur. Nunc morbi pharetra et sit.',
                    style: Styles.regularRoboto12.copyWith(
                      color: const Color(0xffADADAD),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'May 10 , 2025 . 9.2K Views ',
                    style: Styles.semiBoldRoboto12.copyWith(
                      color: const Color(0xff999999),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 5),
        const Divider(color: Color(0xFFEEEEEE), thickness: 2),
      ],
    );
  }
}
