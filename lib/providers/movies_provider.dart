//Para poder usar json en nuestra petición
//debemos importar este paquete, aunque lo puedo autoimportar
//en el momento que uso json:
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movieapp/helpers/deboucer.dart';
import 'package:movieapp/models/models.dart';
import 'package:movieapp/models/search_response.dart';

//Importante: nuestra clase provider (MoviesProvier) debe
//extender de la lcase ChangeNotifier para que sea realemente
//un provider:
class MoviesProvider extends ChangeNotifier {
  final String _apiKey = '73fcf29ebbd77050307a4cc197f2dfe7';
  final String _baseUrl = 'api.themoviedb.org';
  final String _lenguage = 'en-US';

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];

  Map<int, List<Cast>> moviesCast = {};

  //este atributo se usará para listar las películas en el
  //ListView.builder del MovieSlider. La primera tanda empieza
  //en 0 y si quiero volver a pedirla aumentará 1:
  int _popularPage = 0;

  final deboucer = Debouncer(
    duration: const Duration(milliseconds: 500),
  );

  final StreamController<List<Movie>> _suggestionStreamController =
      new StreamController.broadcast();

  Stream<List<Movie>> get suggestionStream =>
      this._suggestionStreamController.stream;

  MoviesProvider() {
    //print('MoviesProvider initializing');

    //recuerde que el uso de this es opcional en dart. Sin embargo,
    //aveces es conveniente usarlo para que quede claro a cuál
    //método o variable hacemos referencia:
    this.getOnDisplayMovies();
    this.getPopularMovies();
  }

  Future<String> _getJsonData(String endpoint, [int page = 1]) async {
    final url = Uri.https(_baseUrl, endpoint, {
      'api_key': _apiKey,
      'language': _lenguage,
      'page': '$page',
    });
    final response = await http.get(url);
    return response.body;
  }

  getOnDisplayMovies() async {
    final jsonData = await _getJsonData('/3/movie/now_playing');
    final nowPlayingResponse = NowPlayingResponse.fromJson(jsonData);
    onDisplayMovies = nowPlayingResponse.results;
    notifyListeners();
  }

  getPopularMovies() async {
    _popularPage++;
    final jsonData = await _getJsonData('/3/movie/popular', _popularPage);
    final popularResponse = PopularResponse.fromJson(jsonData);
    popularMovies = [...popularMovies, ...popularResponse.results];
    notifyListeners();
  }

  Future<List<Cast>> getMoviesCast(int movieId) async {
    if (moviesCast.containsKey(movieId)) return moviesCast[movieId]!;

    final jsonData = await _getJsonData('3/movie/$movieId/credits');
    final creditsResponse = CreditsResponse.fromJson(jsonData);
    moviesCast[movieId] = creditsResponse.cast;
    return creditsResponse.cast;
  }

  Future<List<Movie>> searchMovies(String query) async {
    final url = Uri.https(_baseUrl, '3/search/movie', {
      'api_key': _apiKey,
      'language': _lenguage,
      'query': query,
    });

    final response = await http.get(url);
    final searchResponse = SearchResponse.fromJson(response.body);

    return searchResponse.results;
  }

  void getSuggestionByQuery(String searchTerm) {
    deboucer.value = '';
    deboucer.onValue = (value) async {
      print('el valor a buscar $value');
      final results = await this.searchMovies(value);
      this._suggestionStreamController.add(results);
    };

    final timer = Timer.periodic(const Duration(milliseconds: 300), (_) {
      deboucer.value = searchTerm;
    });

    Future.delayed(const Duration(milliseconds: 301)).then(
      (_) => timer.cancel(),
    );
  }
}
