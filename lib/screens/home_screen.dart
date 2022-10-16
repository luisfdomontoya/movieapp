import 'package:flutter/material.dart';
import 'package:movieapp/providers/movies_provider.dart';
import 'package:movieapp/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //En esta linea estoy diciendo: "necesito que se vaya al
    //árbol de widgets (por eso el context) y me traiga la primera
    //instancia que encuentre sobre MoviesProvider y colócala en
    //mi atributo moviesProvider"
    //Sino encuentra ninguna instancia la creará, siempre y cuando
    //en el MultiProvider esté definido el provider MoviesProvider:
    final moviesProvider = Provider.of<MoviesProvider>(context);

    //la propiedad listen le dice al widget Provider que se re-dibuje
    //cuando haya alguna modificación en alguna de las propiedades
    //del provider (en este caso MoviesProvider), es decir, cuando se
    //llamada notifyListeners éste verifica si el widget tiene alguna
    //dependencia y si es así lo re-dibuja:

    // final moviesProvider = Provider.of<MoviesProvider>(
    //   context,
    //   listen: true,
    // );
    //Por defecto el valor de listen es true. Se pone en false si
    //no queremos que el widget se re-dibuje.

    return Scaffold(
        appBar: AppBar(
          title: const Text('Movies at theater'),
          centerTitle: true,
          elevation: 0,
          actions: [
            IconButton(
              onPressed: () {
                //por ahora esta función no hará nada, pero
                //posteriormente sí lo hará
              },
              icon: const Icon(Icons.search_outlined),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              //Main Cards
              CardSwiper(movies: moviesProvider.onDisplayMovies),

              //Sliders of movies
              MovieSlider(
                movies: moviesProvider.popularMovies,
                title: 'Populars',
              ),
            ],
          ),
        ));
  }
}
