import 'package:flutter/material.dart';
import 'package:his/features/category/presentation/view/widgets/comment_widget.dart';

class CommentsListView extends StatelessWidget {
  final ScrollController controller;

  const CommentsListView({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      controller: controller,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemCount: 4,
      itemBuilder: (context, index) => const CommentWidget(),
    );
  }
}
