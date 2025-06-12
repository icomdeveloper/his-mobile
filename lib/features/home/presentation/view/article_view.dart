import 'package:flutter/material.dart';
import 'package:his/core/utils/app_colors.dart';
import 'package:his/core/utils/app_text_styles.dart';
import 'package:his/core/widgets/build_app_bar.dart';

class ArticleView extends StatelessWidget {
  const ArticleView({super.key});
  static const routeName = 'ArticleView';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(context,
          title: 'Lorem ipsum Article ', centerTitle: false),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Lorem ipsum dolor : sit amet consectetur. Aliquam mattis cursus iaculis elementum ut sit aliquam senectus mauris.',
                style: Styles.semiBoldPoppins14,
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                'By Suliman Ibrahim  . Published on 24May, 2025 ',
                style: Styles.regularRoboto12
                    .copyWith(color: AppColors.primaryColor),
              ),
              const SizedBox(
                height: 24,
              ),
              const Text(
                'Lorem ipsum dolor sit amet consectetur. Id non sem dignissim leo risus et volutpat elit integer. Mauris lectus non parturient nunc ipsum scelerisque. Nisl elementum orci orci ac. Consequat viverra elementum potenti imperdiet dignissim. Eu leo nulla platea enim cras nisi in. Mattis maecenas viverra suspendisse ut at cursus. Consequat ultrices ipsum bibendum in. Mattis nibh at ut ac augue. Diam massa mi maecenas netus. Nec sed dictum consequat vitae neque maecenas. Leo integer orci morbi dolor eu gravida.',
                style: Styles.regularPoppins14,
              ),
              const SizedBox(
                height: 12,
              ),
              const Text(
                'Lorem ipsum dolor sit amet consectetur. Id non sem dignissim leo risus et volutpat elit integer. Mauris lectus non parturient nunc ipsum scelerisque. Nisl elementum orci orci ac. Consequat viverra elementum potenti imperdiet dignissim. Eu leo nulla platea enim cras nisi in. Mattis maecenas viverra suspendisse ut at cursus. Consequat ultrices ipsum bibendum in. Mattis nibh at ut ac augue. Diam massa mi maecenas netus. Nec sed dictum consequat vitae neque maecenas. Leo integer orci morbi dolor eu gravida.',
                style: Styles.regularPoppins14,
              ),
              const SizedBox(
                height: 12,
              ),
              const Text(
                'Lorem ipsum dolor sit amet consectetur. Id non sem dignissim leo risus et volutpat elit integer. Mauris lectus non parturient nunc ipsum scelerisque. Nisl elementum orci orci ac. Consequat viverra elementum potenti imperdiet dignissim. Eu leo nulla platea enim cras nisi in. Mattis maecenas viverra suspendisse ut at cursus. Consequat ultrices ipsum bibendum in. Mattis nibh at ut ac augue. Diam massa mi maecenas netus. Nec sed dictum consequat vitae neque maecenas. Leo integer orci morbi dolor eu gravida.',
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
