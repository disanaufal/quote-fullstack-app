import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/quote_provider.dart';

class QuotePage extends ConsumerWidget {
  const QuotePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quoteAsync = ref.watch(quoteProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Quote Generator')),
      body: Center(
        child: quoteAsync.when(
          data: (quote) => Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  quote.content,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 10),
                Text('- ${quote.author}'),
              ],
            ),
          ),
          loading: () => const CircularProgressIndicator(),
          error: (err, stack) => Text(err.toString()),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => ref.invalidate(quoteProvider),
        child: const Icon(Icons.refresh),
      ),
    );
  }
}