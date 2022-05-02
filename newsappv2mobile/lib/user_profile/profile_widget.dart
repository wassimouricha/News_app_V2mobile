import 'package:flutter/material.dart';
import 'editing_profile.dart';

class ProfileWidget extends StatelessWidget {
  final String imagePath;
    final bool isEdit;
 


  const ProfileWidget({
    Key? key,
    required this.imagePath,
    this.isEdit = false,
 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Stack(
      children: [
        GestureDetector(child: buildImage(),
         onTap:  () 
         => Navigator.of(context).push( MaterialPageRoute(builder: (context) => const EditProfilePage()),)
        ),
        Positioned(
            bottom: 0,
            right: 4,
            child: buildEditIcon(context)), //bouton d'édition
      ],
    ));
  }

  Widget buildImage() {
    final image = NetworkImage(imagePath);

    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: Ink.image(
          image: image,
          fit: BoxFit.cover,
          width: 128,
          height: 128,
          
        ),
      ),
    );
  }

  Widget buildEditIcon(BuildContext context) => buildCircle(
        color: Colors.white,
        all: 3,
        child: buildCircle(
          color: Colors.black,
          all: 8,
          child: GestureDetector(
            child:  Icon(
            isEdit ? Icons.add_a_photo :  Icons.edit,
              color: Colors.white,
              size: 20,
            ),
            onTap: () => Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                    builder: (context) => const EditProfilePage())),
          ),
        ),
      );

  Widget buildCircle({
    required Widget child,
    required double all,
    required Color color,
  }) =>
      ClipOval(
        child: Container(
          padding: EdgeInsets.all(all),
          color: color,
          child: child,
        ),
      );
}
