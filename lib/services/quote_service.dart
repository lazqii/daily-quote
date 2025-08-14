import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:daily_quote/models/quote.dart';

Future<List<Quote>> fetchMultipleQuotes(int count) async {
  final response = await http.get(Uri.parse('https://zenquotes.io/api/quotes'));

  if (response.statusCode == 200) {
    final List<dynamic> data = json.decode(response.body);
    return data.take(count).map((json) => Quote.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load quotes');
  }
}
