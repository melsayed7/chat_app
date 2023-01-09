class Category {
  static const String sportsID = 'sports';
  static const String musicID = 'music';
  static const String moviesID = 'movies';

  String id;

  late String title;

  late String image;

  Category({
    required this.id,
    required this.title,
    required this.image,
  });

  Category.fromID(this.id) {
    if (id == sportsID) {
      title = 'Sports';
      image = 'asset/images/sports.png';
    } else if (id == musicID) {
      title = 'Music';
      image = 'asset/images/music.png';
    } else if (id == moviesID) {
      title = 'Movies';
      image = 'asset/images/movies.png';
    }
  }

  static List<Category> getCategory() {
    return [
      Category.fromID(sportsID),
      Category.fromID(musicID),
      Category.fromID(moviesID),
    ];
  }
}
