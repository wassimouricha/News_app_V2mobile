import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomeWidget extends StatelessWidget {
  const WelcomeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Bonjour et bienvenue sur NewsApp !",
          style: TextStyle(fontSize: 20),
        ),
        Text(
          "Informez vous en cliquant sur les articles dans la liste",
          style:  GoogleFonts.poppins(fontSize: 10,
          color: Colors.grey[700]),
        )
      ],
    );
  }
}
