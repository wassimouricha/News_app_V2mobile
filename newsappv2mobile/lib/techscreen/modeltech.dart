class TechApiModel {
  String title, imageUrl, content, description, publishedAt, author, url;

  TechApiModel(
      {required this.title,
      required this.url,
      required this.description,
      required this.content,
      required this.publishedAt,
      required this.author,
      required this.imageUrl});

  factory TechApiModel.fromJson(Map<String, dynamic> jsonData) {
    return TechApiModel(
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
