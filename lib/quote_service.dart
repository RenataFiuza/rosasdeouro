import 'dart:convert';
import 'package:http/http.dart' as http;

class Quote {
  final String content;
  final String author;

  Quote({required this.content, required this.author});

  factory Quote.fromJson(Map<String, dynamic> json) {
    return Quote(
      content: json['content'],
      author: json['author'],
    );
  }
}

class QuoteService {
  final String apiUrl = 'https://api.quotable.io/random';

  Future<Quote?> fetchRandomQuote() async {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      return Quote.fromJson(jsonDecode(response.body));
    }
    return null;
  }
}
