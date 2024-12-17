import 'package:flutter/material.dart';
import 'package:landlord_portal/features/statements/view_model/statement_view_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';

class PdfViewer extends StatelessWidget {
  const PdfViewer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<StatementProvider>(
        builder: (context, value, child) => const PDF(
          swipeHorizontal: true,
        ).cachedFromUrl(
          value.pdfLink,
        ),
      ),
    );
  }
}
