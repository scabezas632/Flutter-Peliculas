class Peliculas {
  // Crear lista de peliculas
  List<Pelicula> items = new List();

  // Constructor
  Peliculas();

  // Funcion para formatear la estructura de peliculas
  Peliculas.fromJsonList(List<dynamic> jsonList) {
    // Si es vacio, no hace nada
    if (jsonList == null) return;

    for (var item in jsonList) {
      // Se formatea la respuesta al modelo 'Pelicula'
      final pelicula = new Pelicula.fromJsonMap(item);
      // Se añade a la lista de peliculas
      items.add(pelicula);
    }
  }
}

class Pelicula {

  String uniqueId;

  int voteCount;
  int id;
  bool video;
  double voteAverage;
  String title;
  double popularity;
  String posterPath;
  String originalLanguage;
  String originalTitle;
  List<int> genreIds;
  String backdropPath;
  bool adult;
  String overview;
  String releaseDate;

  Pelicula({
    this.voteCount,
    this.id,
    this.video,
    this.voteAverage,
    this.title,
    this.popularity,
    this.posterPath,
    this.originalLanguage,
    this.originalTitle,
    this.genreIds,
    this.backdropPath,
    this.adult,
    this.overview,
    this.releaseDate,
  });

  Pelicula.fromJsonMap(Map<String, dynamic> json) {
    voteCount = json['vote_count'];
    id = json['id'];
    video = json['video'];
    voteAverage = json['vote_average'] / 1; // Para transformar int a double
    title = json['title'];
    popularity = json['popularity'] / 1; // Para transformar int a double
    posterPath = json['poster_path'];
    originalLanguage = json['original_language'];
    originalTitle = json['original_title'];
    genreIds = json['genre_ids'].cast<int>(); // Para castear a int
    backdropPath = json['backdrop_path'];
    adult = json['adult'];
    overview = json['overview'];
    releaseDate = json['release_date'];
  }

  getPosterImg() {
    if (posterPath == null) {
      return 'https://cdn11.bigcommerce.com/s-auu4kfi2d9/stencil/59606710-d544-0136-1d6e-61fd63e82e44/e/0fa64ac0-0314-0137-cf43-1554cd16a871/icons/icon-no-image.svg';
    } else {
      return 'https://image.tmdb.org/t/p/w500/$posterPath';
    }
  }

  getBackgroundImg() {
    if (posterPath == null) {
      return 'https://cdn11.bigcommerce.com/s-auu4kfi2d9/stencil/59606710-d544-0136-1d6e-61fd63e82e44/e/0fa64ac0-0314-0137-cf43-1554cd16a871/icons/icon-no-image.svg';
    } else {
      return 'https://image.tmdb.org/t/p/w500/$backdropPath';
    }
  }
}
