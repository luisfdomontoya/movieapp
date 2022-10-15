import 'package:flutter/material.dart';

import '../providers/movies_provider.dart';
import '../widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context);

    print(moviesProvider.onDisplayMovies);

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
              const MovieSlider(),
            ],
          ),
        ));
  }
}
