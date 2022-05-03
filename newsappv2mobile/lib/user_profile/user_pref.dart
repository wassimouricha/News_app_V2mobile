import 'package:newsappv2mobile/user_profile/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserPreferences {
  get user => FirebaseAuth.instance.currentUser;

  static const myUser = Usered(
    imagePath: "https://cdn-icons-png.flaticon.com/512/16/16363.png",
    about:
        "Lorem ipsum ititit is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout The point of using Lorem Ipsum  that it has a moreorless normal distribution of letters  opposed to using Content here",
    isDarkMode: false,
  );
}
