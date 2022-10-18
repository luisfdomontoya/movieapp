import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
import 'package:movieapp/models/models.dart';
import 'package:movieapp/providers/movies_provider.dart';
import 'package:provider/provider.dart';

class CastingCards extends StatelessWidget {
  final int movieId;

  const CastingCards(this.movieId, {super.key});

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);

    //Este widget se construye basado en un Future, es decir, depende de
    //la respuesta (en este caso) de moviesProvider.getMoviesCast(movieId)
    //para renderizarse:
    return FutureBuilder(
      future: moviesProvider.getMoviesCast(movieId),
      builder: (BuildContext context, AsyncSnapshot<List<Cast>> snapshot) {
        if (!snapshot.hasData) {
          return Container(
            constraints: const BoxConstraints(maxWidth: 150),
            height: 180,
            child: const CupertinoActivityIndicator(),
          );
        }

        final List<Cast> cast = snapshot.data!;

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          width: double.infinity,
          height: 200,
          child: ListView.builder(
            itemCount: 10,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => _CastCard(cast[index]),
          ),
        );
      },
    );
  }
}

class _CastCard extends StatelessWidget {
  final Cast actor;

  const _CastCard(this.actor);

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
      // margin: const EdgeInsets.all(22),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      width: 110,
      height: 100,
      //color: Colors.green, //es como usar el border: 1px solid red de css
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              placeholder: const AssetImage('assets/loading.gif'),
              image: NetworkImage(actor.fullProfilePath),
              width: 110,
              height: 140,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            actor.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
