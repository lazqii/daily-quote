import 'dart:ffi';
import 'dart:io';
import 'package:daily_quote/models/quote.dart';
import 'package:flutter/material.dart';
import 'package:daily_quote/utils/custom_list_tile.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

class QuoteListWidget extends StatefulWidget {
  final List<Quote> quotes;

  const QuoteListWidget({super.key, required this.quotes});

  @override
  State<QuoteListWidget> createState() => _QuoteListWidgetState();
}

class _QuoteListWidgetState extends State<QuoteListWidget> {
  final List<ScreenshotController> controllers = [];

  @override
  void initState() {
    super.initState();
    controllers.addAll(
      List.generate(widget.quotes.length, (_) => ScreenshotController()),
    );
  }

  Future<void> _captureAndShare(int index) async {
    final controller = controllers[index];
    final image = await controller.capture();

    if (image != null) {
      final directory = await getTemporaryDirectory();
      final imagePath =
          await File('${directory.path}/quote_$index.png').create();
      await imagePath.writeAsBytes(image);

      await Share.shareXFiles([
        XFile(imagePath.path),
      ], text: 'Kutipan harian dari DailyQuote');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.quotes.length,
      itemBuilder: (context, index) {
        final quote = widget.quotes[index];
        final controller = controllers[index];

        return GestureDetector(
          onTap: () => _captureAndShare(index),
          child: Screenshot(
            controller: controller,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: CustomListTile(
                leadingIcon: Icons.format_quote_rounded,
                title: '"${quote.text}"',
                subtitle: '\n- ${quote.author}',
                trailingIcon: Icons.arrow_outward_rounded,
              ),
            ),
          ),
        );
      },
    );
  }
}
