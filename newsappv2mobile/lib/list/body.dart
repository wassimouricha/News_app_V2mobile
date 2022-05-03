import 'package:newsappv2mobile/list/constant.dart';
import 'package:newsappv2mobile/list/product_image.dart';
import 'package:flutter/material.dart';
import 'modeles.dart';

// class DetailBlog extends StatefulWidget {
//   const DetailBlog({Key? key}) : super(key: key);

//   @override
//   State<DetailBlog> createState() => _DetailBlogState();
// }

// class _DetailBlogState extends State<DetailBlog> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         //ici je code mon app bar qui me redirige vers l'accueil
//         elevation: 0,
//         backgroundColor: Colors.transparent,
//         automaticallyImplyLeading: false,
//         title: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 25),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Align(
//                   alignment: Alignment.centerLeft,
//                   child: IconButton(
//                     onPressed: () => Navigator.of(context).pushReplacement(
//                         MaterialPageRoute(
//                             builder: (context) => const HomeScreen())),
//                     icon: const Icon(
//                       Icons.arrow_back_ios,
//                       color: Color.fromARGB(255, 57, 130, 173),
//                     ),
//                   ),
//                 ),
//                 Text(
//                   "WNews v2",
//                   style: GoogleFonts.poppins(
//                       fontSize: 15,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white),
//                 )
//               ],
//             )),
//         titleSpacing: 0,
//       ),
//       body: StreamBuilder<List<Users>>(
//           stream: readUsers(),
//           builder: (context, snapshot) {
//             if (snapshot.hasData) {
//               final users = snapshot.data!;

//               return ListView(
//                 children: users.map(buildUsers).toList(),
//               );
//             } else if (snapshot.hasError) {
//               // print(snapshot.error);
//               return const Text(" une erreur est survenue");
//             } else {
//               return const Center(
//                 child: CircularProgressIndicator(),
//               );
//             }
//           }),
//     );
//   }

class DetailBlog extends StatelessWidget {
  final Article model;

  const DetailBlog({required this.model, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          decoration: const BoxDecoration(
            color: kBackgroundColor,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(50),
              bottomRight: Radius.circular(50),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: ProductPoster(
                  size: size,
                  image: 'image/kyrie.png',
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
                child: Text(
                  "Titre : " + model.titre,
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
                child: Text(
                  "Description : " + model.description,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
                child: Text(
                  "Auteur : " + model.name,
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              const Text(
                "date",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: kSecondaryColor,
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
                child: Text(
                  "date",
                  style: TextStyle(color: kTextColor),
                ),
              ),
              const SizedBox(
                height: kDefaultPadding,
              ),
            ],
          ),
        ),
      ],
    );
  }

  String getTruncatedContent(String text, int truncatedNumber) {
    return text.length > truncatedNumber
        ? text.substring(0, truncatedNumber)
        : text;
  }
}
