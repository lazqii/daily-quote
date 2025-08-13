import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:daily_quote/models/quote.dart';

// // Model Quote
// class QuoteService {
//   final String text;
//   final String author;

//   QuoteService({required this.text, required this.author});

//   factory QuoteService.fromJson(Map<String, dynamic> json) {
//     return QuoteService(text: json['q'], author: json['a']);
//   }
// }

// Service untuk ambil quote
// Future<QuoteService> fetchRandomQuote() async {
//   final response = await http.get(Uri.parse('https://zenquotes.io/api/random'));

//   if (response.statusCode == 200) {
//     print("sukses");
//     final List<dynamic> data = json.decode(response.body);
//     return QuoteService.fromJson(data[0]); // Ambil quote pertama dari array
//   } else {
//     print("gagal");
//     throw Exception('Failed to load quote');
//   }
// }

Future<List<Quote>> fetchMultipleQuotes(int count) async {
  final response = await http.get(Uri.parse('https://zenquotes.io/api/quotes'));

  if (response.statusCode == 200) {
    final List<dynamic> data = json.decode(response.body);
    return data.take(count).map((json) => Quote.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load quotes');
  }
}
