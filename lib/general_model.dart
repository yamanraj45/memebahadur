class FruitsCategory {
  final String name;
  final String image;

  FruitsCategory({this.name, this.image});
}

class Popular {
  final String name;
  final String image;
  final String desc;
  final String price;
  final String rating;

  Popular({this.name, this.image, this.desc, this.price, this.rating});
}

class Homes {
  final String image;
  final String name;

  Homes({this.image, this.name});
}

class GeneralModelList {
  final List<FruitsCategory> fruitsCategory;
  final List<Popular> popular;
  final List<Homes> homes;

  GeneralModelList({this.fruitsCategory, this.popular, this.homes});
}

final GeneralModelList fruitsCategoryList =
    new GeneralModelList(fruitsCategory: [
  FruitsCategory(name: "TV Shows", image: "assets/images/tvshows.png"),
  FruitsCategory(name: "Movies", image: "assets/images/tvshows.png"),
  FruitsCategory(name: "Real Life", image: "assets/images/tvshows.png"),
  FruitsCategory(name: "Extra", image: "assets/images/tvshows.png")
], popular: [
  Popular(
      name: "Movies",
      desc: "Hera Pheri",
      image: "assets/images/herapheri.jpg",
      price: "\$1800 per night",
      rating: "984"),
  Popular(
      name: "movies",
      desc: "Pashupati Prasad",
      image: "assets/images/pashupatiprasad.jpg",
      price: "About \$30 per person",
      rating: "688"),
  Popular(
      name: "Miamo-Amazing view in Imerolivi",
      desc: "The Curious Palace Town",
      image: "assets/images/pashupatiprasad.jpg",
      price: "\$1300 per night",
      rating: "900"),
], homes: [
  Homes(image: "assets/images/tvshows.png", name: "Entire House- 2 bed"),
  Homes(image: "assets/images/tvshows.png", name: "Entire House- 3 bed"),
  Homes(image: "assets/images/tvshows.png", name: "Entire House- 4 bed"),
]);
