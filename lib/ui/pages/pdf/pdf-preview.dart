import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mobile_app/constants/colors.dart';
import 'package:mobile_app/themes/themes.dart';
import 'package:pdf_flutter/pdf_flutter.dart';

class PDFPreviewPage extends StatefulWidget {
  final File pdfFile;

  PDFPreviewPage({@required this.pdfFile});

  @override
  _PDFPreviewPageState createState() => _PDFPreviewPageState();
}

class _PDFPreviewPageState extends State<PDFPreviewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          widget.pdfFile.path.split('/').last,
          style: CustomThemes.darkGrayGreenTheme.textTheme.subtitle1,
        ),
        iconTheme: IconThemeData(
          color: CustomColors.darkGrayGreenColor,
        ),
      ),
      body: Container(
        child: PDF.file(widget.pdfFile,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width),
      ),
    );
  }
}
