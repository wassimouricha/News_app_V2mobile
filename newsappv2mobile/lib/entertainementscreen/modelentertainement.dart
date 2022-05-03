class EntApiModel {
  String title, imageUrl, content, description, publishedAt, author, url;

  EntApiModel(
      {required this.title,
      required this.url,
      required this.description,
      required this.content,
      required this.publishedAt,
      required this.author,
      required this.imageUrl});

  factory EntApiModel.fromJson(Map<String, dynamic> jsonData) {
    return EntApiModel(
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
