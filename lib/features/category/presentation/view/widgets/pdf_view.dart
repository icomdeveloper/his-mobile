import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:his/core/helpers/nav_bar_visibility_provider.dart';
import 'package:provider/provider.dart';

class PdfView extends StatefulWidget {
  const PdfView({super.key, required this.url});
  final String url;

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
      body: PopScope(
        canPop: true, // Prevents default back button behavior
        onPopInvokedWithResult: (bool didPop, _) async {
          _navBarProvider.show();
        },
        child: Center(
            child: const PDF().cachedFromUrl(
          "https://ontheline.trincoll.edu/images/bookdown/sample-local-pdf.pdf",
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
