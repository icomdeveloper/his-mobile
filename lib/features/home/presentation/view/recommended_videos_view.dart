import 'package:flutter/material.dart';

class RecommendedVideosView extends StatelessWidget {
  const RecommendedVideosView({super.key});
  static const String routeName = '/recommended-videos';
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('RecommendedVideosView')),
    );
  }
}
