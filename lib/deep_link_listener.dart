import 'dart:developer';

import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:his/constants.dart';
import 'package:his/core/services/shared_preferences.dart';
import 'package:his/features/home/presentation/view/video_view.dart';
import 'package:his/features/main_screen/presentation/view/main_view.dart';

import 'features/category/data/model/media_model.dart';

class DeepLinkListener extends StatefulWidget {
  const DeepLinkListener({super.key, required this.child});
  final Widget child;

  @override
  State<DeepLinkListener> createState() => _DeepLinkListenerState();
}

class _DeepLinkListenerState extends State<DeepLinkListener> {
  @override
  initState() {
    final appLinks = AppLinks(); // AppLinks is singleton

// Subscribe to all events (initial link and further)
    final sub = appLinks.uriLinkStream.listen((uri) {
      log('uri: ${uri.toString()}');
      if (uri.pathSegments.first == 'media') {
        if (!Prefs.getBool(PrefsKeys.isOnBoardingSeen) ||
            !Prefs.getBool(PrefsKeys.isLoggedIn)) return;
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const MainView()));
        final id = uri.pathSegments.lastOrNull;
        if (id != null && int.tryParse(id) != null) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => VideoView(
                        mediaModel: MediaModel(id: int.parse(id)),
                      )));
        }
      }
      // Do something (navigation, ...)
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
