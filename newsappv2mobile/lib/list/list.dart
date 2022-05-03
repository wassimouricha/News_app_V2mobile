import 'package:newsappv2mobile/list/detail.dart';
import 'package:newsappv2mobile/list/presta.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'constant.dart';

class ListPresta extends StatelessWidget {
  const ListPresta({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          const SizedBox(
            height: kDefaultPadding / 2,
          ),
          Expanded(
            child: Stack(children: <Widget>[
              Container(
                //l'arriere plan de la liste
                margin: const EdgeInsets.only(top: 70),
                decoration: const BoxDecoration(
                  color: kBackgroundColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
              ),
              ListView.builder(
                itemCount: prestation
                    .length, //voir presta.dart si tu veux utiliser la list locale
                itemBuilder: (context, index) => BigContenu(
                  itemIndex: index,
                  presta: prestation[index],
                  press: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const DetailsScreen(),
                      ),
                    );
                  },
                ),
              )
            ]),
          ),
        ],
      ),
    );
  }
}

class BigContenu extends StatelessWidget {
  const BigContenu({
    Key? key,
    required this.itemIndex,
    required this.press,
    required this.presta,
  }) : super(key: key);

  final int itemIndex;
  final Presta presta;
  final Function press;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsets.symmetric(
          horizontal: kDefaultPadding, vertical: kDefaultPadding / 2),
      // color: Colors.blueAccent,
      height: 160,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const DetailsScreen(),
            ),
          );
        },
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            //nos background
            Container(
              height: 136,
              decoration: BoxDecoration(
                boxShadow: const [kDefaultShadow],
                borderRadius: BorderRadius.circular(22),
                color: itemIndex.isEven ? kBlackColor : kSecondaryColor,
              ),
              child: Container(
                margin: const EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(22),
                ),
              ),
            ),
            // nos images de prestations
            Positioned(
              top: 10,
              right: 0,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                height: 160,
                width: 200,
                child: Image.asset(
                  presta.image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // nom de la prestation , date , client et prix
            Positioned(
              bottom: 0,
              left: 0,
              child: SizedBox(
                height: 136,
                // l'image prend 200 en largeur , c'est pourquoi nous mettons la largeur total - 200
                width: size.width - 200,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: kDefaultPadding,
                      ),
                      child: Text(
                        "Titre : " + presta.titre,
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultPadding),
                      child: Text(
                        "Catégorie : " + presta.categorie,
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultPadding),
                      child: Text(
                        "Date : " + presta.rdv,
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                        ),
                      ),
                    ),
                    //occupe l'espace disponible
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: kDefaultPadding * 1.5, //30 padding
                        vertical: kDefaultPadding / 4,
                      ),
                      decoration: const BoxDecoration(
                        color: kSecondaryColor,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(22),
                          topRight: Radius.circular(22),
                        ),
                      ),
                      child: Text(
                        "\$${presta.price}",
                        style: Theme.of(context).textTheme.button,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
