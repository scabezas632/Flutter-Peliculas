
import 'package:http/http.dart' as http;

import 'dart:convert';
import 'dart:async';

import 'package:flutter_peliculas/src/models/pelicula_model.dart';
import 'package:flutter_peliculas/src/models/actores_model.dart';

class PeliculasProvider {
  String _apikey    = '62b1253a5e98a6668368d7e73316c9e0';
  String _url       = 'api.themoviedb.org';
  String _language  = 'es-ES';
  
  int _popularPage = 0;
  bool _isLoading = false;

  List<Pelicula> _populares = new List();

  final _popularesStreamController = StreamController<List<Pelicula>>.broadcast();

  Function(List<Pelicula>) get popularesSink => _popularesStreamController.sink.add; 

  Stream<List<Pelicula>> get popularesStream => _popularesStreamController.stream;

  void disposeStreams() {
    _popularesStreamController?.close();
  }

  Future<List<Pelicula>> _procesarRespuesta(Uri url) async {

    final resp = await http.get(url);

    final decodedData = json.decode(resp.body);

    final peliculas = new Peliculas.fromJsonList(decodedData['results']);

    return peliculas.items;

  }

  Future<List<Pelicula>> getEnCines() async {

    final url = Uri.https(_url, '3/movie/now_playing', {
      'api_key': _apikey,
      'language': _language
    });

    return await _procesarRespuesta(url);
  }

  Future<List<Pelicula>> getPopular() async {

    if (_isLoading) return [];

    _isLoading = true;

    _popularPage++;

    final url = Uri.https(_url, '3/movie/popular', {
      'api_key': _apikey,
      'language': _language,
      'page': _popularPage.toString()
    });

    final resp = await _procesarRespuesta(url);

    _populares.addAll(resp); 

    popularesSink(_populares);

    _isLoading = false;

    return resp;
  }

  Future<List<Actor>> getCast(String peliculaId) async {

    final url = Uri.https(_url, '3/movie/$peliculaId/credits', {
      'api_key': _apikey
    });

    final resp = await http.get(url);

    final decodedData = json.decode(resp.body);

    final actores = new Actores.fromJsonList(decodedData['cast']);

    return actores.actores;

  }

  Future<List<Pelicula>> buscarPelicula(String query) async {

    final url = Uri.https(_url, '3/search/movie', {
      'api_key': _apikey,
      'language': _language,
      'query': query
    });

    return await _procesarRespuesta(url);
  }

}