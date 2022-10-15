import 'package:flutter/material.dart';

//Importante: nuestra clase provider (MoviesProvier) debe
//extender de la lcase ChangeNotifier para que sea realemente
//un provider:
class MoviesProvider extends ChangeNotifier {
  MoviesProvider() {
    print('MoviesProvider initializing');

    //recuerde que el uso de this es opcional en dart. Sin embargo,
    //aveces es conveniente usarlo para que quede claro a cuál
    //método o variable hacemos referencia:
    this.getOnDisplayMovies();
  }

  getOnDisplayMovies() async {
    print('getOnDisplayMovies');
  }
}
