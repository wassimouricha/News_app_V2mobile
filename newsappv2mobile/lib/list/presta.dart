class Presta {
  final int? id, price ;
  final String categorie, description, image, titre, rdv ;

  Presta({required this.id, required this.price, required this.categorie, required this.description, required this.image, required this.titre, required this.rdv});
}

// list au cas où tu veux l'utiliser sinon  faut faire le back pour la listview


//liste des prestations

List<Presta> prestation = [
  
  
  Presta(id: 1,
  titre:"Nouveau micro",
  price: 20,
  rdv: "16 juin 2022",
  categorie: "Musique",
  image: "image/micro.png",
  description: "Les nouveaux micros Sony bla bla bla...",
  
  ),

   Presta(id: 1,
   titre:"Les nets Out !",
   rdv: "24 avril 2022",
  price: 33,
  categorie: "Sport",
  image: "image/kyrie.png",
  description: "Les brooklyn nets se sont fait sweepé 4-0 contre les boston celtics durant ce premier tour des playoffs NBA",
    
  ),

     Presta(id: 1,
     titre:"Nouvel Tesla",
     rdv: "12 decembre 2022",
  price: 45,
  categorie: "Automobile",
  image: "image/tesla.png",
  description: "Elon Musk à crée une nouvelle version de sa tesla model 3",
    
  ),
       Presta(id: 1,
     titre:"Le retour du communisme",
     rdv: "22 novembre 1954",
  price: 84,
  categorie: "Politique",
  image: "image/list4.png",
  description: "Lissage bresilien bien lissant + champoing",
    
  ),

       Presta(id: 1,
     titre:"Batman brises les records",
     rdv: "23 septembre 2022",
  price: 65,
  categorie: "Cinema",
  image: "image/cinema.png",
  description: "Lissage bresilien bien lissant + champoing",
    
  ),





  
  ];
