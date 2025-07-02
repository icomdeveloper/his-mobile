import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:his/constants.dart';
import 'package:his/core/helpers/likes_manager.dart';
import 'package:his/core/services/shared_preferences.dart';
import 'package:his/core/utils/app_colors.dart';
import 'package:his/core/utils/app_text_styles.dart';
import 'package:his/core/utils/assets.dart';
import 'package:his/core/widgets/text_container_widget.dart';
import 'package:his/features/authentication/presentation/view/login_view.dart';
import 'package:his/features/home/data/models/article_model.dart';
import 'package:his/features/home/presentation/view/article_view.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../bookmarks/presentation/cubits/bookmarks_cubit/bookmarks_cubit.dart';

class ArticleWidget extends StatefulWidget {
  const ArticleWidget(
      {super.key, required this.articleModel, this.isbookmark = false});
  final ArticleModel articleModel;
  final bool isbookmark;

  @override
  State<ArticleWidget> createState() => _ArticleWidgetState();
}

class _ArticleWidgetState extends State<ArticleWidget> {
  late bool isBookmark;
  @override
  void initState() {
    isBookmark = widget.isbookmark;
    _loadBookmarkStatus();
    super.initState();
  }

  Future<void> _loadBookmarkStatus() async {
    final isbookmarked = await LikesManager.isLiked(
        widget.articleModel.id!, PrefsKeys.bookmarks);
    setState(() {
      isBookmark = isbookmarked;
    });
  }

  Future<void> _toggleBookmark() async {
    await LikesManager.toggleLike(widget.articleModel.id!, PrefsKeys.bookmarks);
    setState(() {
      isBookmark = !isBookmark;
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (!Prefs.getBool(PrefsKeys.isLoggedIn)) {
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (_, __, ___) => const LoginView(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) =>
                      FadeTransition(
                opacity: animation,
                child: child,
              ),
            ),
          );
        } else {
          Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (_, __, ___) => ArticleView(
                  articleModel: widget.articleModel,
                ),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) =>
                        FadeTransition(
                  opacity: animation,
                  child: child,
                ),
              ));
        }
      },
      child: Container(
        decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: const BorderSide(
                  color: AppColors.lightGrey,
                  width: 0.5,
                )),
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
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                  style: Styles.semiBoldPoppins12
                      .copyWith(color: AppColors.grey, fontSize: 10.sp),
                ),
                const Spacer(),
                IconButton(
                    onPressed: () {
                      if (!isBookmark) {
                        context
                            .read<BookmarksCubit>()
                            .addToBookmarks(articleId: widget.articleModel.id);
                      } else {
                        context.read<BookmarksCubit>().removeFromBookmarks(
                            articleId: widget.articleModel.id);
                      }
                      _toggleBookmark();
                    },
                    icon: Icon(
                      isBookmark
                          ? Icons.bookmark
                          : Icons.bookmark_border_outlined,
                      color: AppColors.primaryColor,
                      size: 18,
                    )),
              ],
            ),
            Text(
              widget.articleModel.title!,
              style: Styles.semiBoldPoppins14,
            ),
            Text(
              widget.articleModel.description!,
              style: Styles.regularPoppins12
                  .copyWith(color: AppColors.grey, fontSize: 10.sp),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
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
                InkWell(
                  onTap: () {
                    if (widget.articleModel.hyperlink != null) {
                      launchUrl(Uri.parse(widget.articleModel.hyperlink!));
                    }
                  },
                  child: Text(
                    widget.articleModel.hyperlink ?? '',
                    style: Styles.regularPoppins12.copyWith(
                        color: const Color(0xff2463B6), fontSize: 10.sp),
                  ),
                ),
              ],
            )
          ]),
        ),
      ),
    );
  }
}
