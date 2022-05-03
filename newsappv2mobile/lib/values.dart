class News {
  String title;
  String description;
  String image;
  String sourceImage;
  String source;
  String time;

  News(
      {required this.title,
      required this.description,
      required this.image,
      required this.sourceImage,
      required this.source,
      required this.time});
}

class StaticValues {
  List<News> news = [
    News(
        title: "Lancement de Liberty !",
        description:
            " Lancement de l'application liberty réalisé par l'entreprise QR code protect situé à douai",
        image: "image/liberty.jpg",
        source: "The Economic Times",
        sourceImage:
            "https://yt3.ggpht.com/ytc/AAUvwngucVKXeH6T2_0PfZbyB2XJ3Toff5CfTnZ1alshs_4=s900-c-k-c0x00ffffff-no-rj",
        time: "à 8:28 AM"),
    News(
        title: "Que nous préparent Panam et Johnny cette année ?",
        image: "image/cyberpunk-207.jpg",
        source: "Daily Buggle",
        sourceImage: "https://static.toiimg.com/photo/47529300.cms",
        time: "Il y à 3 jours",
        description:
            " Les deux aldecaldos sont connu pour leurs coups d'éclats lors des festivités de night city"),
    News(
        title: "Allen Iverson sort de sa retraite !",
        image: "image/Allen-Iverson.jpg",
        source: "Daily Buggle",
        sourceImage: "https://static.toiimg.com/photo/47529300.cms",
        time: "Il y a 3 jours",
        description:
            "Allen iverson sort de sa retraite pour aider les Sixers à remporter le titre cette anée !"),
  ];

//   List<Category> categories = [
//     Category(
//       name: "Economie",
//     ),
//     Category(
//       name: "Crypto",
//     ),
//     Category(
//       name: "Tech",
//     ),
//     Category(
//       name: "Sport",
//     ),
//     Category(
//       name: "Business",
//     ),
//     Category(
//       name: "Anime",
//     ),
//     Category(
//       name: "Politique",
//     ),
//   ];
}
