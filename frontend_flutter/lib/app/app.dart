import 'package:flutter/material.dart';
import '../features/quote/presentation/pages/quote_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: QuotePage(),
    );
  }
}