import 'package:flutter/material.dart';
import 'package:movieapp/models/models.dart';
import 'package:movieapp/providers/movies_provider.dart';
import 'package:provider/provider.dart';

class MovieSearchDelegate extends SearchDelegate {
  //Este método sobre-escribe el label que viene en el
  //input searh, por lo tanto, yo le puedo mandar cualquier
  //string. En este caso le estoy mandando 'Searching
  //Movies...':
  @override
  // TODO: implement searchFieldLabel
  String? get searchFieldLabel => 'Searching Movies...';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () => query = '',
        icon: const Icon(Icons.clear),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return (IconButton(
      onPressed: () {
        //el método close viene gracias al SearchDelegate. El
        //dato importante aquí es el argumento que recibe close.
        //Por un lado recibe el context y por otra lado recibe
        //otro argumento que se convertirá en el valor de
        //retorno de la llamada a showSearch (que lo usamos en
        //el HomeScreen). En este caso le pasamos null porque no
        //queremos que haga nada, así que simplemente me devuelve
        //a la pantalla de HomeScreen:
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    ));
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Text('buildResults');
  }

  Widget _emptyContainer() {
    return Container(
      child: const Center(
        child: Icon(
          Icons.movie_creation_outlined,
          color: Colors.black38,
          size: 140,
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    //tenga en cuenta que la palabra reservada 'query' viene
    //del SearchDelegate, por eso la puedo usar aquí. Y lo
    //que almacena query es el texto que yo pongo en el input
    //del search:
    if (query.isEmpty) {
      return _emptyContainer();
    }

    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);

    return FutureBuilder(
      future: moviesProvider.searchMovies(query),
      builder: (context, AsyncSnapshot<List<Movie>> snapshot) {
        if (!snapshot.hasData) return _emptyContainer();

        return;
      },
    );
  }
}