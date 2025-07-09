import 'dart:convert';

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
                '${formatMentions(articleModel.mention ?? '')}Published on ${getCustomDate(articleModel.createdAt ?? DateTime.now())} ',
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

  String formatMentions(String mentionsJson) {
    try {
      // Step 1: Parse the JSON string into a List<String>
      final List<String> mentions =
          (jsonDecode(mentionsJson) as List).cast<String>();

      // Step 2: Format the mentions into a readable string
      if (mentions.isEmpty) {
        return "";
      } else if (mentions.length == 1) {
        return "By: ${mentions[0]}. ";
      } else {
        // Capitalize first letter of last mention
        final String lastMention = mentions.last[0].toUpperCase() +
            mentions.last.substring(1).toLowerCase();

        // Join all other mentions with commas
        final String otherMentions =
            mentions.sublist(0, mentions.length - 1).join(", ");

        return "By: $otherMentions, $lastMention. ";
      }
    } catch (e) {
      // Handle invalid JSON format
      return "";
    }
  }
}
