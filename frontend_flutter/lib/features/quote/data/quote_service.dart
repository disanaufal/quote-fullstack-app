import 'package:flutter_quote_generator/features/quote/data/quote_model.dart';
import '../../../core/network/dio_client.dart';

Future<Quote> fatchQuote() async {
  final response = await dio.get('http://192.168.1.11:3000/quotes/random');
  return Quote.fromJson(response.data);
}