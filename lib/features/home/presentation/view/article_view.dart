import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:his/core/helpers/calculate_time_ago.dart';
import 'package:his/core/utils/app_colors.dart';
import 'package:his/core/utils/app_text_styles.dart';
import 'package:his/core/widgets/build_app_bar.dart';
import 'package:his/features/home/data/models/article_model.dart';

class ArticleView extends StatelessWidget {
  const ArticleView({super.key, required this.articleModel});
  final ArticleModel articleModel;
  @override
  Widget build(BuildContext context) {
    final text = articleModel.description ?? '';
    final isHtml = text.contains(RegExp(r'<[a-z][\s\S]*>'));
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(context, title: '', centerTitle: false),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                articleModel.title ?? '',
                style: Styles.semiBoldPoppins14,
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                'Published on ${getCustomDate(articleModel.createdAt ?? DateTime.now())} ',
                style: Styles.regularPoppins12
                    .copyWith(color: AppColors.primaryColor),
              ),
              const SizedBox(
                height: 24,
              ),
              isHtml
                  ? Html(data: articleModel.description ?? '', style: {
                      "p": Style(
                          padding: HtmlPaddings.zero,
                          margin: Margins.zero,
                          color: Colors.black,
                          fontSize: FontSize(14.sp),
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Poppins')
                    })
                  : Text(
                      articleModel.description ?? '',
                      style: Styles.regularPoppins14,
                    ),
              const SizedBox(
                height: 12,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
