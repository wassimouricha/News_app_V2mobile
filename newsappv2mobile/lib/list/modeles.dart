class Article {
  String name, titre, description;

  Article({
    required this.name,
    required this.titre,
    required this.description,
  });

  static Article fromJson(Map<String, dynamic> json) => Article(
      name: json["auteur"],
      titre: json["titre"],
      description: json["description"]);
}
