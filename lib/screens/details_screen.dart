import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // ModalRoute.of(context)?.settings.arguments: me permite recibir el
    // argumento q le envié por el Navigator y se lo asigno a movie. Es
    // importante mencionar q arguments devuelve un objeto y para poder
    // usar este valor y asignarlo a movie (que es un string) debo
    // convertirlo a string usando el método toString
    final String movie =
        ModalRoute.of(context)?.settings.arguments.toString() ?? 'no-movie';

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _CustomAppBar(),
          SliverList(
            delegate: SliverChildListDelegate([
              const Text('hello worl'),
            ]),
          )
        ],
      ),
    );
  }
}

class _CustomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.indigo,
      expandedHeight: 200, //define la altura del widget SilverAppBar
      floating: false,
      pinned: true, //permite q llegue un punto que el SilverAppBar se deje
      //de reducir y quede fijo
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: const EdgeInsets.all(0),
        title: Container(
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          color: Colors.black12,
          child: const Text(
            'movie.title',
            style: TextStyle(fontSize: 24),
          ),
        ),
        background: const FadeInImage(
          placeholder: AssetImage('assets/loading.gif'),
          image: NetworkImage('https://via.placeholder.com/500x300'),
          //permite que la imagen se expanda sin deformarla
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
