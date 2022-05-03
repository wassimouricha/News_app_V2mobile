import 'package:flutter/material.dart';
import 'package:newsappv2mobile/sportscreen/modelsport.dart';
import 'package:newsappv2mobile/const.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:google_fonts/google_fonts.dart';

class Readingsport extends StatelessWidget {
  final SportApiModel model;

  const Readingsport({required this.model, Key? key}) : super(key: key);

  //ma fon,ction pour ouvrir le site de l'article
  void _launchURL() async {
    // ignore: deprecated_member_use
    if (!await launch(
      model.url,
      forceWebView: true,
      enableJavaScript: true,
    )) throw 'Impossible de lancer $model.url';
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
            backgroundColor: getColors[1],
            appBar: AppBar(
              //ici je code mon app bar qui me redirige vers l'accueil
              elevation: 0,
              backgroundColor: Colors.transparent,
              automaticallyImplyLeading: false,
              title: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(
                            Icons.arrow_back_ios,
                            color: Color.fromARGB(255, 57, 130, 173),
                          ),
                        ),
                      ),
                      Text(
                        "WNews v2",
                        style: GoogleFonts.poppins(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      )
                    ],
                  )),
              titleSpacing: 0,
            ),
            extendBodyBehindAppBar: true,
            body: SizedBox(
                width: double.maxFinite,
                child: Stack(children: [
                  //partie image
                  Positioned(
                    left: 0,
                    right: 0,
                    child: model.imageUrl != ""
                        ? Container(
                            width: double.maxFinite,
                            height: 300,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(model.imageUrl),
                                    fit: BoxFit.cover)),
                          )
                        : SizedBox(
                            width: double.maxFinite,
                            height: 350,
                            child: Text(
                              "Impossible de charger l'image",
                              style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                  ),
                  //partie text
                  Positioned(
                    top: 270,
                    child: Container(
                      padding:
                          const EdgeInsets.only(left: 20, right: 20, top: 20),
                      width: MediaQuery.of(context).size.width,
                      height: 500,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30))),
                      child: Column(children: [
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          width: size.width / 1.05,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(model.title,
                                    style: GoogleFonts.poppins(
                                      color: const Color.fromARGB(
                                          255, 57, 130, 173),
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                    )),
                              ),
                            ],
                          ),
                        ),
                        //auteur et date de publication
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              ("Auteur: ") +
                                  getTruncatedContent(model.author, 20),
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              ("Publié le ") +
                                  getTruncatedContent(model.publishedAt, 10),
                              style: const TextStyle(
                                fontSize: 13,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(
                          height: 10,
                        ),
                        //contenu de l'article
                        Text(
                          getTruncatedContent(model.content, 200),
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),

                        const SizedBox(height: 5),
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "Pour lire la suite de l'article  ",
                                style: GoogleFonts.poppins(
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 14),
                          child: Column(children: [
                            ElevatedButton(
                                onPressed: () async {
                                  _launchURL();
                                }, //la fonction signIn
                                style: ElevatedButton.styleFrom(
                                  shape: const StadiumBorder(),
                                  primary: Colors.black,
                                  padding: const EdgeInsets.all(14),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const SizedBox(width: 10),
                                    Text(
                                      "Cliquez ici",
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    )
                                  ],
                                )),
                          ]),
                        ),
                      ]),
                    ),
                  )
                ]))));
  }

  String getTruncatedContent(String text, int truncatedNumber) {
    return text.length > truncatedNumber
        ? text.substring(0, truncatedNumber)
        : text;
  }
}
