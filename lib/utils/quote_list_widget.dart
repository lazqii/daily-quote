import 'package:daily_quote/models/quote.dart';
import 'package:flutter/material.dart';
import 'package:daily_quote/services/quote_service.dart';
import 'package:daily_quote/utils/custom_list_tile.dart';

class QuoteListWidget extends StatelessWidget {
  final List<Quote> quotes;

  const QuoteListWidget({super.key, required this.quotes});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: quotes.length,
      itemBuilder: (context, index) {
        final quote = quotes[index];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: CustomListTile(
            leadingIcon: Icons.format_quote_rounded,
            title: '"${quote.text}"',
            subtitle: '\n${quote.author}',
            trailingIcon: Icons.arrow_outward_rounded,
          ),
        );
      },
    );
  }
}
