// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:newsappv2mobile/const.dart';
import 'package:newsappv2mobile/model.dart';
import 'package:newsappv2mobile/news_api.dart';
import 'package:newsappv2mobile/news_screen.dart';
import 'package:newsappv2mobile/sportscreen/sport_screen.dart';
import 'package:newsappv2mobile/santescreen/sante_screen.dart';
import 'package:newsappv2mobile/sciencescreen/science_screen.dart';
import 'package:newsappv2mobile/techscreen/tech_screen.dart';
import 'package:newsappv2mobile/entertainementscreen/ent_screen.dart';
import 'package:newsappv2mobile/businesscreen/biz_screen.dart';
import 'package:newsappv2mobile/drawer.dart';
import 'package:newsappv2mobile/messageac.dart';
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<NewsApiModel>? newsList;
  bool isLoading = true;
  var currentIndex = 0;

  void changePage(var index) {
    setState(() {
      currentIndex = index;
    });
  }

  late final List<BubbleBottomBarItem> items;
  @override
  void initState() {
    super.initState();
    getNews().then((value) {
      setState(() {
        if (value.isNotEmpty) {
          newsList = value;
          isLoading = false;
        } else {
          print("La liste est vide");
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: getColors[1],
      appBar: AppBar(
        //ici je code mon app bar qui me redirige vers mon drawer
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Builder(
                  builder: (context) => IconButton(
                    icon: Image.asset("image/pngegg.png"),
                    onPressed: () => Scaffold.of(context).openDrawer(),
                  ),
                ),
                Text("NewsApp v2",
                    style:
                        GoogleFonts.poppins(fontSize: 15, color: Colors.black)),
              ],
            )),
        titleSpacing: 0,
      ),
      drawer: const NavigationDraweer(),
      body: SingleChildScrollView(
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Column(
            children: [
              ExpansionTile(
                title: Text(
                  'G??n??ral',
                  style: GoogleFonts.poppins(
                      fontSize: 24, fontWeight: FontWeight.w400),
                  textAlign: TextAlign.center,
                ),
                children: [
                  ListTile(
                    title: Text(
                      'Sport',
                      style: GoogleFonts.poppins(
                          fontSize: 24, fontWeight: FontWeight.w400),
                      textAlign: TextAlign.center,
                    ),
                    onTap: () => Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                            builder: (context) => const SportScreen())),
                  ),
                  ListTile(
                    title: Text(
                      'Sant??',
                      style: GoogleFonts.poppins(
                          fontSize: 24, fontWeight: FontWeight.w400),
                      textAlign: TextAlign.center,
                    ),
                    onTap: () => Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                            builder: (context) => const SanteScreen())),
                  ),
                  ListTile(
                    title: Text(
                      'Science',
                      style: GoogleFonts.poppins(
                          fontSize: 24, fontWeight: FontWeight.w400),
                      textAlign: TextAlign.center,
                    ),
                    onTap: () => Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                            builder: (context) => const ScienceScreen())),
                  ),
                  ListTile(
                    title: Text(
                      'Tech',
                      style: GoogleFonts.poppins(
                          fontSize: 24, fontWeight: FontWeight.w400),
                      textAlign: TextAlign.center,
                    ),
                    onTap: () => Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                            builder: (context) => const TechScreen())),
                  ),
                  ListTile(
                    title: Text(
                      'Business',
                      style: GoogleFonts.poppins(
                          fontSize: 24, fontWeight: FontWeight.w400),
                      textAlign: TextAlign.center,
                    ),
                    onTap: () => Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                            builder: (context) => const BizScreen())),
                  ),
                  ListTile(
                    title: Text(
                      'Entertainement',
                      style: GoogleFonts.poppins(
                          fontSize: 24, fontWeight: FontWeight.w400),
                      textAlign: TextAlign.center,
                    ),
                    onTap: () => Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                            builder: (context) => const EntScreen())),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Center(child: WelcomeWidget()),
              const SizedBox(
                height: 10,
              ),
              const SizedBox(
                height: 10,
              ),
              isLoading
                  ? SizedBox(
                      height: size.height / 20,
                      width: size.height / 20,
                      child: const CircularProgressIndicator(),
                    )
                  : Expanded(
                      child: ListView.builder(
                        itemCount: newsList!.length,
                        itemBuilder: (context, index) {
                          return listItems(size, newsList![index]);
                        },
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Widget listItems(Size size, NewsApiModel model) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 8),
      child: GestureDetector(
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => ReadingNews(
              model: model,
            ),
          ),
        ),
        child: Container(
          padding: const EdgeInsets.only(bottom: 10),
          width: size.width / 1.15,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: Colors.grey[200]),
          child: Column(
            children: [
              Container(
                //le container de mon image
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                margin: const EdgeInsets.symmetric(vertical: 5),
                color: Colors.grey[200],
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: model.imageUrl != ""
                      ? Image.network(
                          model.imageUrl,
                          fit: BoxFit.cover,
                        )
                      : const Text("Impossible de charger"),
                ),
              ),
              Container(
                //le container de mon titre
                width: size.width / 1.1,
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Text(
                  model.title,
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Container(
                  //Mon container pour la partie date de publication en bas ?? droite
                  width: size.width / 1.1,
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        ("Auteur: ") + getTruncatedContent(model.author, 12),
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(
                        width: 1,
                      ),
                      Text(
                        ("Publi?? le ") +
                            getTruncatedContent(model.publishedAt, 10),
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }

  //ici je fais ma fonction getTruncatedContent afin de cacher la fin du texte trop cons??quent par rapport ?? mon container
  //si la longueur de mon text est sup??rieur au chiffre que j'indique alors le texte sera cach?? + j'ajoute "..." afin de montrer que le texte continue
  String getTruncatedContent(String text, int truncatedNumber) {
    return text.length > truncatedNumber
        ? text.substring(0, truncatedNumber) + "..."
        : text;
  }
}
