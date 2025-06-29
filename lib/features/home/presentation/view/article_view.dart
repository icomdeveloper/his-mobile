import 'package:flutter/material.dart';
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
                'By Suliman Ibrahim  . Published on ${getCustomDate(articleModel.createdAt ?? DateTime.now())} ',
                style: Styles.regularRoboto12
                    .copyWith(color: AppColors.primaryColor),
              ),
              const SizedBox(
                height: 24,
              ),
              Text(
                articleModel.description ?? '',
                style: Styles.regularPoppins14,
              ),
              // const SizedBox(
              //   height: 12,
              // ),
              // const Text(
              //   'Lorem ipsum dolor sit amet consectetur. Id non sem dignissim leo risus et volutpat elit integer. Mauris lectus non parturient nunc ipsum scelerisque. Nisl elementum orci orci ac. Consequat viverra elementum potenti imperdiet dignissim. Eu leo nulla platea enim cras nisi in. Mattis maecenas viverra suspendisse ut at cursus. Consequat ultrices ipsum bibendum in. Mattis nibh at ut ac augue. Diam massa mi maecenas netus. Nec sed dictum consequat vitae neque maecenas. Leo integer orci morbi dolor eu gravida.',
              //   style: Styles.regularPoppins14,
              // ),
              // const SizedBox(
              //   height: 12,
              // ),
              // const Text(
              //   'Lorem ipsum dolor sit amet consectetur. Id non sem dignissim leo risus et volutpat elit integer. Mauris lectus non parturient nunc ipsum scelerisque. Nisl elementum orci orci ac. Consequat viverra elementum potenti imperdiet dignissim. Eu leo nulla platea enim cras nisi in. Mattis maecenas viverra suspendisse ut at cursus. Consequat ultrices ipsum bibendum in. Mattis nibh at ut ac augue. Diam massa mi maecenas netus. Nec sed dictum consequat vitae neque maecenas. Leo integer orci morbi dolor eu gravida.',
              //   style: Styles.regularPoppins14,
              // ),
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
