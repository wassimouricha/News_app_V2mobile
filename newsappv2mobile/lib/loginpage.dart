// ignore_for_file: avoid_print, camel_case_types

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:newsappv2mobile/const.dart';
import 'package:newsappv2mobile/model.dart';
import 'package:newsappv2mobile/news_api.dart';
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:newsappv2mobile/drawer.dart';
import 'package:newsappv2mobile/Animations/delayed_animation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsappv2mobile/signuppage.dart';
import 'package:newsappv2mobile/password.dart';
import 'package:newsappv2mobile/user_page.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<Login> {
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
  late GoogleSignInAccount userObj;
  final passwordController = TextEditingController();

  var _obscureText = true;
  //obscuretext est une propriété qui lorsque elle passe a true obscurcit le champ de texte
//la fonction future sign in ici indique que lorsque qu'on activeras la fonction
  Future signIn() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );
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
                  vertical: 20,
                  horizontal: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    delayedAnimation(
                      delay: 1000,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Connectez vous avec votre adresse mail",
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
                                  child: TextField(
                                    controller: emailController,
                                    decoration: InputDecoration(
                                      labelText: 'Votre mail',
                                      labelStyle: TextStyle(
                                        color: Colors.grey[400],
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 30),
                                delayedAnimation(
                                  delay: 2000,
                                  child: TextFormField(
                                    controller: passwordController,
                                    obscureText: _obscureText,
                                    decoration: InputDecoration(
                                      labelStyle: TextStyle(
                                        color: Colors.grey[400],
                                      ),
                                      labelText: 'Mot de passe',
                                      suffixIcon: IconButton(
                                        icon: const Icon(
                                          Icons.visibility,
                                          color: Colors.black,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _obscureText = !_obscureText;
                                          });
                                        },
                                      ),
                                    ),
                                    autovalidateMode: AutovalidateMode
                                        .onUserInteraction, //fonction permettant de montrer le text
                                    validator: (value) => value != null &&
                                            value.isEmpty
                                        ? "Entrer votre mot de passe est obligatoire. "
                                        : null, // ici si la taille du mot de passe n'est pas supérieur ou égal a 6  alors le message  s'afficheras ou alors le mdp est valide
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 15),
                          delayedAnimation(
                            delay: 3000,
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 10),
                              height: 100,
                              child: Column(
                                children: [
                                  Text(
                                    "Il est recommandé de connecter votre adresse mail afin que nous puissions protéger vos données personnelles.",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(
                                      color: Colors.grey,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          delayedAnimation(
                            delay: 3500,
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 40, vertical: 14),
                              child: Column(children: [
                                ElevatedButton(
                                    onPressed: signIn, //la fonction signIn
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
                                          "Confirmer",
                                          style: GoogleFonts.poppins(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    )),
                              ]),
                            ),
                          ),
                          delayedAnimation(
                            delay: 3500,
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 40, vertical: 14),
                              child: Column(children: [
                                ElevatedButton(
                                    onPressed: () async {
                                      await GoogleSignIn()
                                          .signIn()
                                          .then((value) {
                                        print(value);
                                        print(FirebaseAuth.instance.currentUser);
                                        setState(() {
                                          userObj = value!;
                                        });
                                      });
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const UserPage()));
                                    },
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
                                        const Icon(
                                          FontAwesomeIcons.google,
                                          color: Colors.red,
                                        ),
                                        const SizedBox(width: 10),
                                        Text(
                                          "Connexion Google",
                                          style: GoogleFonts.poppins(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    )),
                              ]),
                            ),
                          ),
                          delayedAnimation(
                            delay: 3500,
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 40, vertical: 2),
                              child: Column(
                                children: [
                                  RichText(
                                    text: TextSpan(
                                        style: const TextStyle(
                                            color: Colors.black),
                                        text: "Vous avez oublié votre ",
                                        children: [
                                          TextSpan(
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () => Navigator.of(
                                                      context)
                                                  .pushReplacement(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              const ForgotPassword())),
                                            text: "mot de passe ?",
                                            style: const TextStyle(
                                              decoration:
                                                  TextDecoration.underline,
                                              color: Colors.red,
                                            ),
                                          ),
                                        ]),
                                  )
                                ],
                              ),
                            ),
                          ),
                          delayedAnimation(
                            delay: 3700,
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 40, vertical: 2),
                              child: Column(
                                children: [
                                  RichText(
                                    text: TextSpan(
                                        style: const TextStyle(
                                            color: Colors.black),
                                        text: "Pas de compte ? ",
                                        children: [
                                          TextSpan(
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () => Navigator.of(
                                                      context)
                                                  .pushReplacement(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              const Signup())),
                                            text: "Inscrivez-vous",
                                            style: const TextStyle(
                                              decoration:
                                                  TextDecoration.underline,
                                              color: Colors.red,
                                            ),
                                          ),
                                        ]),
                                  )
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
