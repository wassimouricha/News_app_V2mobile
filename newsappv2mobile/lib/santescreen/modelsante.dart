class SanteApiModel {
  String title, imageUrl, content, description, publishedAt, author, url;

  SanteApiModel(
      {required this.title,
      required this.url,
      required this.description,
      required this.content,
      required this.publishedAt,
      required this.author,
      required this.imageUrl});

  factory SanteApiModel.fromJson(Map<String, dynamic> jsonData) {
    return SanteApiModel(
      title: jsonData['title'] ?? "",
      description: jsonData['description'] ?? "",
      url: jsonData['url'] ?? "",
      publishedAt: jsonData['publishedAt'] ?? "",
      content: jsonData['content'] ?? "",
      author: jsonData['author'] ?? "",
      imageUrl: jsonData['urlToImage'] ?? "",
    );
  }
}
