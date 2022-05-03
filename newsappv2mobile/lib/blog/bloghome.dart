import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsappv2mobile/blog/blog.dart';
import 'package:newsappv2mobile/home_screen.dart';
import 'package:newsappv2mobile/user_profile/user_pref.dart';

class BlogHome extends StatefulWidget {
  const BlogHome({Key? key}) : super(key: key);

  @override
  State<BlogHome> createState() => _BlogHomeState();
}

class _BlogHomeState extends State<BlogHome> {
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
                                onPressed: () => Navigator.of(context)
                                    .pushReplacement(MaterialPageRoute(
                                        builder: (context) =>
                                            const HomeScreen())),
                                icon: const Icon(
                                  Icons.arrow_back_ios,
                                  color: Color.fromARGB(255, 57, 130, 173),
                                ),
                              ),
                            ),
                            Text("Wassim News App v2",
                                style: GoogleFonts.poppins(
                                    fontSize: 15, color: Colors.black)),
                          ],
                        )),
                    titleSpacing: 0,
                  ),
                  backgroundColor: Colors.white,
                  body: const ListBlog(),
                );
              } else {
                return Scaffold(
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
                                icon: const Icon(
                                  Icons.arrow_back_ios,
                                  color: Color.fromARGB(255, 57, 130, 173),
                                ),
                                onPressed: () => Navigator.of(context)
                                    .pushReplacement(MaterialPageRoute(
                                        builder: (context) =>
                                            const HomeScreen())),
                              ),
                            ),
                            Text("NewsApp v2",
                                style: GoogleFonts.poppins(
                                    fontSize: 15, color: Colors.black)),
                          ],
                        )),
                    titleSpacing: 0,
                  ),
                  body: const ListBlog(),
                );
              }
            }),
      );
}
