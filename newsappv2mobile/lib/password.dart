// ignore_for_file: avoid_print, camel_case_types

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:newsappv2mobile/const.dart';
import 'package:newsappv2mobile/model.dart';
import 'package:newsappv2mobile/news_api.dart';
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:newsappv2mobile/drawer.dart';
import 'package:newsappv2mobile/Animations/delayed_animation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:email_validator/email_validator.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<ForgotPassword> {
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
                    icon: Image.asset("image/drawer.png"),
                    onPressed: () => Scaffold.of(context).openDrawer(),
                  ),
                ),
                const Text("Wassim News App v2",
                    style: TextStyle(fontSize: 15, color: Colors.black)),
              ],
            )),
        titleSpacing: 0,
      ),
      drawer: const NavigationDraweer(),
      body: const connexionPage(),
    );
  }
}

//mon widget de login

class connexionPage extends StatefulWidget {
  const connexionPage({Key? key}) : super(key: key);

  @override
  State<connexionPage> createState() => _connexionPageState();
}

class _connexionPageState extends State<connexionPage> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  Future resetPassword() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Scaffold(
                body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(children: [
                Text(
                  "l'email à été envoyé",
                  style: Theme.of(context).textTheme.headline6,
                ),
              ]),
            )));
        
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: emailController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      print(e);

      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => Scaffold(
                  body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(children: [
                  Text(
                    "une erreur est survenue",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ]),
              )));

    
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(
                  vertical: 40,
                  horizontal: 30,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 120),
                    delayedAnimation(
                      delay: 1000,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Recevez un Email pour reset votre mot de passe ",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 25,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 35),
                          Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 30,
                            ),
                            child: Column(
                              children: [
                                delayedAnimation(
                                  delay: 1500,
                                  child: TextFormField(
                                    controller: emailController,
                                    decoration: InputDecoration(
                                      labelText: 'Votre mail',
                                      labelStyle: TextStyle(
                                        color: Colors.grey[400],
                                      ),
                                    ),
                                    autovalidateMode: AutovalidateMode
                                        .onUserInteraction, //fonction permettant de montrer le texte
                                    validator: (email) => email != null &&
                                            !EmailValidator.validate(email)
                                        ? "entrer une adresse mail valide"
                                        : null, //on ajoute le package email validator afin de confirmer les informations et donc ici si l'email n'est pas valide alors le message  s'afficheras ou le mail est valide
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 25),
                          delayedAnimation(
                            delay: 2000,
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 10),
                              height: 200,
                              child: Column(
                                children: [
                                  const SizedBox(height: 35),
                                  delayedAnimation(
                                    delay: 2500,
                                    child: Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 40, vertical: 14),
                                      child: Column(children: [
                                        ElevatedButton(
                                            onPressed:
                                                resetPassword, //la fonction resetPassword
                                            style: ElevatedButton.styleFrom(
                                              shape: const StadiumBorder(),
                                              primary: Colors.black,
                                              padding: const EdgeInsets.all(14),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                const SizedBox(width: 10),
                                                Text(
                                                  "Changer de mot de passe",
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
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
// TODO Implement this library.