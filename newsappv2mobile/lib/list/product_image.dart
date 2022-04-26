import 'package:newsappv2mobile/list/constant.dart';
import 'package:flutter/material.dart';


class ProductPoster extends StatelessWidget {
  const ProductPoster({
    Key? key,
    required this.size, required this.image,
  }) : super(key: key);

  final Size size;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: kDefaultPadding),
      // la hauteur de ce container est  de 80% de la largeur
      height: size.width * 0.8,

      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          Container(
            height: size.width * 0.7,
            width: size.width * 0.7,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
          ),
          Image.asset(
           image,
            height: size.width * 0.75,
            width: size.width * 0.75,
            fit: BoxFit.cover,
          )
        ],
      ),
    );
  }
}
