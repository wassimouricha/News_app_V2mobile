// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:newsappv2mobile/blog/bloghome.dart';
import 'package:newsappv2mobile/home_screen.dart';
import 'package:newsappv2mobile/user_profile/user_page_v2.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsappv2mobile/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:newsappv2mobile/signup.dart';


//mon drawer = ma sidebar

class NavigationDraweer extends StatelessWidget {
  const NavigationDraweer({Key? key}) : super(key: key);
  get user => FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.transparent,
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return const Center(child: Text("une erreur s'est produite"));
            } else if (snapshot.hasData) {
              return Drawer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
//le widget du header du drawer/sidebar
                    Material(
                      color: Colors.black,
                      child: InkWell(
                        onTap: () {
                          //pour fermer le navigation drawer
                          Navigator.pop(context);
                          //pour rediriger vers la page
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>  const UserPageV2(),
                          ));
                        },
                        child: Container(
                          padding: EdgeInsets.only(
                            top: 24 + MediaQuery.of(context).padding.top,
                            bottom: 24,
                          ),
                          child: Column(
                            children: [
                              const CircleAvatar(
                                radius: 52,
                                backgroundImage: NetworkImage(
                                    'https://media-exp1.licdn.com/dms/image/D4E03AQHKyal9OiD12g/profile-displayphoto-shrink_800_800/0/1648624925960?e=2147483647&v=beta&t=NimRdFpaBcn7mrK3Abem2USfCRhEsZ8K7-h8NAQ9xYY'),
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              // Text(
                              //   "Nom de l'utilisateur",
                              //   style: GoogleFonts.poppins(
                              //       fontSize: 20, color: Colors.white),
                              // ), mettre le display name
                              const SizedBox(
                                height: 12,
                              ),
                              Text(
                                 user.email,
                                style: GoogleFonts.poppins(
                                    fontSize: 15, color: Colors.white),
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    buildMenuItems(context),
                  ],
                ),
              );
            } else {
              return Drawer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
//le widget du header du drawer/sidebar
                    Material(
                      color: Colors.black,
                      child: InkWell(
                        onTap: () {
                          //pour fermer le navigation drawer
                          Navigator.pop(context);
                          //pour rediriger vers la page
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const UserPageV2(),
                          ));
                        },
                        child: Container(
                          padding: EdgeInsets.only(
                            top: 24 + MediaQuery.of(context).padding.top,
                            bottom: 24,
                          ),
                          child: Column(
                            children: [
                              const CircleAvatar(
                                radius: 52,
                                backgroundImage: NetworkImage(
                                    'https://media-exp1.licdn.com/dms/image/D4E03AQHKyal9OiD12g/profile-displayphoto-shrink_800_800/0/1648624925960?e=2147483647&v=beta&t=NimRdFpaBcn7mrK3Abem2USfCRhEsZ8K7-h8NAQ9xYY'),
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              // Text(
                              //   "Nom de l'utilisateur",
                              //   style: GoogleFonts.poppins(
                              //       fontSize: 20, color: Colors.white),
                              // ), mettre le display name
                              const SizedBox(
                                height: 12,
                              ),
                              Text(
                                "mail ",
                                style: GoogleFonts.poppins(
                                    fontSize: 15, color: Colors.white),
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    buildMenuItems(context),
                  ],
                ),
              );
            }
          }));
}

//le widget du menu du drawer/sidebar
Widget buildMenuItems(BuildContext context) => Wrap(
      runSpacing: 16, //espace vertical
      children: [
        ListTile(
          leading: const Icon(Icons.home_outlined),
          title: Text(
            'Accueil',
            style: GoogleFonts.poppins(fontSize: 15, color: Colors.black),
          ), //je peux remplacement pushreplacement par push pour avoir le bouton en haut a gauche pour revenir
          //il faut cependant ajouter Navigator.pop(context); pour que le drawer se ferme lorsque l'on va revenir sur la page
          onTap: () => Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const HomeScreen())),
        ),
        ListTile(
          leading: const Icon(Icons.favorite_border),
          title: Text(
            'Inscription',
            style: GoogleFonts.poppins(fontSize: 15, color: Colors.black),
          ),
          onTap: () =>  Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const Signuped())),
        ),
        ListTile(
          leading: const Icon(Icons.login),
          title: Text(
            'Connexion',
            style: GoogleFonts.poppins(fontSize: 15, color: Colors.black),
          ),
          onTap: () => Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const loginaid())),
        ),
          ListTile(
          leading: const Icon(Icons.post_add),
          title: Text(
            'Blog',
            style: GoogleFonts.poppins(fontSize: 15, color: Colors.black),
          ),
          onTap: () => Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const BlogHome())),
        ),
        InkWell(
          borderRadius: BorderRadius.circular(500),
          splashColor: Colors.black,
          onTap: () {
            //pour fermer le drawer
            Navigator.of(context).pop();
          },
          child: const Center(
            child: CircleAvatar(
              radius: 20,
              backgroundColor: Colors.black,
              child: Icon(Icons.arrow_back, color: Colors.white),
            ),
          ),
        ),
        const Divider(
          color: Colors.black,
        ),
        // Expanded(
        //     child: Align(
        //       alignment: Alignment.bottomCenter,
        //       child: Container(
        //         height: 65,
        //         width: MediaQuery.of(context).size.width,
        //         color: Colors.black,
        //         child: Center(
        //           //premet de mettre l'enfant du widget et donc ce qu'il y à a l'interieur au centre
        //           child: Text(
        //             "v1.0.3",
        //             style: TextStyle(
        //                 fontSize: 20,
        //                 fontWeight: FontWeight.w600,
        //                 color: Colors.white),
        //           ),
        //         ),
        //       ),
        //     ),
        //   ),
      ],
    );
