//Para poder usar json en nuestra petición
//debemos importar este paquete, aunque lo puedo autoimportar
//en el momento que uso json:
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/models.dart';

//Importante: nuestra clase provider (MoviesProvier) debe
//extender de la lcase ChangeNotifier para que sea realemente
//un provider:
class MoviesProvider extends ChangeNotifier {
  final String _apiKey = '73fcf29ebbd77050307a4cc197f2dfe7';
  final String _baseUrl = 'api.themoviedb.org';
  final String _lenguage = 'en-US';

  List<Movie> onDisplayMovies = [];

  MoviesProvider() {
    print('MoviesProvider initializing');

    //recuerde que el uso de this es opcional en dart. Sin embargo,
    //aveces es conveniente usarlo para que quede claro a cuál
    //método o variable hacemos referencia:
    this.getOnDisplayMovies();
  }

  getOnDisplayMovies() async {
    var url = Uri.https(_baseUrl, '/3/movie/now_playing', {
      'api_key': _apiKey,
      'language': _lenguage,
      'page': '1',
    });

    //1. Esperamos la respuesta de la petición http get
    final response = await http.get(url); //esto devuelve un json

    //2. Luego de obtener la respuesta necesitamos convertirla a algo
    //para poder usar esa información en nuestra aplicación. Una
    //forma de hacerlo es convertir la respuesta en un mapa. Para que
    //json.decode sepa que necesita convertir a un mapa le debo indicar
    //en el lado izquiero el tipo de dato que es decodedData, así:

    //final Map<String, dynamic> decodedData = json.decode(response.body);

    //3. El paso siguiente es mapear el mapa decodedData a una clase.
    //Este mapeo se puede hacer manual (lo cual tomaría mucho tiempo) o
    //podemos usar el sitio web quicktype.io. En este caso usan el sitio
    //web. Lo que hace quicktype es crear una clase que se adapte
    //exactamente al json que le pasemos.
    //Con la ayuda de la clase que me generó quicktype ya no necesito el
    //mapa decodedData, así que lo comento y en su lugar uso la siguiente:

    final nowPlayingResponse = NowPlayingResponse.fromJson(response.body);

    // print(nowPlayingResponse.results[0].title);
    onDisplayMovies = nowPlayingResponse.results;
    notifyListeners();
  }
}
