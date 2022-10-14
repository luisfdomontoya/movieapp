import 'package:flutter/material.dart';

import '../widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
            children: const [
              //Main Cards
              CardSwiper(),

              //Sliders of movies
              MovieSlider(),
            ],
          ),
        ));
  }
}
