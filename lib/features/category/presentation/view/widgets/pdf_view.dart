import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:his/core/helpers/convert_drive_files.dart';
import 'package:his/core/helpers/nav_bar_visibility_provider.dart';
import 'package:his/core/widgets/build_app_bar.dart';
import 'package:provider/provider.dart';

class PdfView extends StatefulWidget {
  const PdfView({super.key, required this.url, this.isFromFile = false});
  final String url;
  final bool isFromFile;
  @override
  State<PdfView> createState() => _PdfViewState();
}

class _PdfViewState extends State<PdfView> {
  late NavBarVisibilityProvider _navBarProvider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Store the provider reference when dependencies change
    _navBarProvider =
        Provider.of<NavBarVisibilityProvider>(context, listen: false);
    // Hide navbar when this view appears
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _navBarProvider.hide();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(context, title: 'PDF', showBackButton: true),
      body: PopScope(
        canPop: true, // Prevents default back button behavior
        onPopInvokedWithResult: (bool didPop, _) async {
          _navBarProvider.show();
        },
        child: Center(
            child: widget.isFromFile
                ? const PDF().fromPath(widget.url)
                : const PDF().cachedFromUrl(
                    convertGoogleDriveUrl(widget.url),
                    errorWidget: (error) {
                      log(error.toString());
                      return Center(
                        child: Text('Error  ${error.toString()}'),
                      );
                    },
                    placeholder: (progress) {
                      return Center(
                        child: Text('$progress %'),
                      );
                    },
                  )),
      ),
    );
  }
}
