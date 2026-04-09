import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/quote_model.dart';
import '../data/quote_service.dart';

final quoteProvider = FutureProvider<Quote>((ref) async {
  return fatchQuote();
});