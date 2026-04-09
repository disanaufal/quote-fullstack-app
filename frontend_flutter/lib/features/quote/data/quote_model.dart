class Quote {
  final int id;
  final String content;
  final String author;

  Quote({
    required this.id,
    required this.content,
    required this.author,
  });

  factory Quote.fromJson(Map<String, dynamic> json) {
    return Quote(
      id: json['id'],
      content: json['content'],
      author: json['author'],
    );
  }
}