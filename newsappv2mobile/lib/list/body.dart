import 'package:newsappv2mobile/list/constant.dart';
import 'package:newsappv2mobile/list/product_image.dart';
import 'package:flutter/material.dart';


class BodyDetail extends StatelessWidget {
  const BodyDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ça permet de fournir la hauteur et largeur total
    Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          decoration: const BoxDecoration(
            color: kBackgroundColor,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(50),
              bottomRight: Radius.circular(50),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: ProductPoster(size: size, image: 'image/kyrie.png',
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: kDefaultPadding / 2 ),
                child: Text("Titre : " " Les nets sont sweepé" , style: Theme.of(context).textTheme.headline6,
                ),

              ),
               Padding(
                padding: const EdgeInsets.symmetric(vertical: kDefaultPadding / 2 ),
                child: Text("Catégorie : " " Sport" , style: Theme.of(context).textTheme.headline6,
                ),

              ),
                Padding(
                padding: const EdgeInsets.symmetric(vertical: kDefaultPadding / 2 ),
                child: Text("Description : " "Les brooklyn nets se sont fait sweepé 4-0 contre les boston celtics durant ce premier tour des playoffs NBA" , style: Theme.of(context).textTheme.headline6,
                ),

              ),
              const Text("\$45" , style: TextStyle(fontSize: 18,
              fontWeight: FontWeight.w600,
              color: kSecondaryColor,
              ),
              ),
              const Padding(padding: EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
              child: Text("date", style: TextStyle(color: kTextColor),
              ),
              ),
              const SizedBox(height: kDefaultPadding,),
             
            ],
          ),
        ),
        //  Container(
        //    margin: const EdgeInsets.all( kDefaultPadding),
             
        //       decoration:  BoxDecoration(color: Colors.transparent,
        //       borderRadius: BorderRadius.circular(30),
        //       ),
        //       child: Row(
        //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //         children: <Widget>[
        //               // ElevatedButton(
        //               //       onPressed: () {},
        //               //       style: ElevatedButton.styleFrom(
        //               //         shape: const StadiumBorder(),
        //               //         primary: const Color.fromARGB(255, 21, 161, 8),
        //               //         padding: const EdgeInsets.all(14),
        //               //       ),
        //               //       child: Row(
        //               //         mainAxisAlignment: MainAxisAlignment.center,
        //               //         children: [
        //               //           const SizedBox(width: 10),
        //               //           Text(
        //               //             "Accepter",
        //               //             style: GoogleFonts.poppins(
        //               //               color: Colors.white,
        //               //               fontSize: 16,
        //               //               fontWeight: FontWeight.w500,
        //               //             ),
        //               //           )
        //               //         ],
        //               //       )),
        //               //       const SizedBox(width: 10,),
        //               //        ElevatedButton(
        //               //       onPressed: () {},
        //               //       style: ElevatedButton.styleFrom(
        //               //         shape: const StadiumBorder(),
        //               //         primary: const Color.fromARGB(255, 217, 0, 0),
        //               //         padding: const EdgeInsets.all(14),
        //               //       ),
        //               //       child: Row(
        //               //         mainAxisAlignment: MainAxisAlignment.center,
        //               //         children: [
        //               //           const SizedBox(width: 10),
        //               //           Text(
        //               //             "Refuser",
        //               //             style: GoogleFonts.poppins(
        //               //               color: Colors.white,
        //               //               fontSize: 16,
        //               //               fontWeight: FontWeight.w500,
        //               //             ),
        //               //           )
        //               //         ],
        //               //       )),
        //         ],
        //       ),
        //       ),
      ],
    );
  }
}
