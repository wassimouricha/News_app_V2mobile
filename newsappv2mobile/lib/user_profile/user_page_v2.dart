import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:newsappv2mobile/login.dart';
import 'package:newsappv2mobile/user_profile/appbar_widget.dart';
import 'package:newsappv2mobile/user_profile/user_pref.dart';
import 'profile_widget.dart';
import 'numbers_widget.dart';


class UserPageV2 extends StatefulWidget {
  const UserPageV2({Key? key}) : super(key: key);

  @override
  State<UserPageV2> createState() => _UserPageV2State();
}

class _UserPageV2State extends State<UserPageV2> {
  get user => FirebaseAuth.instance.currentUser;
  final usered = UserPreferences.myUser;
  @override
  Widget build(BuildContext context) => Scaffold(
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
                return Scaffold(
                  appBar: buildAppBar(context),
                  backgroundColor: Colors.white,
                  body: Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 14),
                    child: ListView(
                      physics: const BouncingScrollPhysics(),
                      children: [
                        ProfileWidget(
                          imagePath: usered.imagePath,
                      
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        
                        Column(children: [
                          Text(
                            user.email,
                            style: GoogleFonts.poppins(
                                fontSize: 17,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          // Text(
                          //   user.email, //mettre le nom plus tard
                          //   style: GoogleFonts.poppins(
                          //     color: Colors.grey,
                          //   ),
                          // ), mettre le display name plus tard
                        ]),
                        const SizedBox(
                          height: 24,
                        ),
                        ElevatedButton(
                            onPressed: () => FirebaseAuth.instance
                                .signOut(), //la fonction signOut
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
                                  "Se déconnecter",
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              ],
                            )),
                        const SizedBox(
                          height: 24,
                        ),
                        const NumbersWidget(),
                        const SizedBox(
                          height: 48,
                        ),
                        buildAbout(),
                      ],
                    ),
                  ),
                );
              } else {
                return Scaffold(
                  appBar: buildAppBar(context),
                  body: Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 14),
                    child: ListView(
                      physics: const BouncingScrollPhysics(),
                      children: [
                        ProfileWidget(
                          imagePath: usered.imagePath,
                       
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        Column(children: [
                          Text(
                            "non connecté",
                            style: GoogleFonts.poppins(
                                fontSize: 17,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          // Text(
                          //   "non connecté",
                          //   style: GoogleFonts.poppins(
                          //     color: Colors.grey,
                          //   ),
                          // ), mettre le display.name
                        ]),
                        const SizedBox(
                          height: 24,
                        ),
                        ElevatedButton(
                            onPressed: () => Navigator.of(context)
                                .pushReplacement(MaterialPageRoute(
                                    builder: (context) => const loginaid())),
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
                                  "Se Connecter",
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              ],
                            )),
                        const SizedBox(
                          height: 24,
                        ),
                        const NumbersWidget(),
                        const SizedBox(
                          height: 48,
                        ),
                        buildAbout(),
                      ],
                    ),
                  ),
                );
              }
            }),
      );

  Widget buildAbout() => Container(
        padding: const EdgeInsets.symmetric(horizontal: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              "A propos",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 2,
            ),
            Text(
              "Changez de description lorsque vous vous connecter a votre profil !",
              style: TextStyle(fontSize: 10, color: Colors.grey),
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              "Lorem ipsum ititit is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout The point of using Lorem Ipsum  that it has a moreorless normal distribution of letters  opposed to using Content here ",
              style: TextStyle(fontSize: 16, height: 1.4),
            ),
          ],
        ),
      );
}
