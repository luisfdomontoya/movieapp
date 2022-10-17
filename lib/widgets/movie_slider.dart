import 'package:flutter/material.dart';
import 'package:movieapp/models/models.dart';

class MovieSlider extends StatefulWidget {
  final List<Movie> movies;
  final String? title;
  //esta función se usa para indicarle al MovieSlider qué tipo
  //de información es la que va a mostrar, por ejemplo: podría
  //mostrar las películas populares, las películas nuevas, etc:
  final Function onNextPage;

  const MovieSlider({
    super.key,
    required this.movies,
    this.title,
    required this.onNextPage,
  });

  @override
  State<MovieSlider> createState() => _MovieSliderState();
}

class _MovieSliderState extends State<MovieSlider> {
  //el ScrollController me permite crear un Listener que escuchará
  //todo lo que pase en el widget con el cual lo vinculo. Este
  //widget (por lo general es un SingleChildScrollView, CustomScrollView
  //, ListView, Sliver, etc) tiene que permitir usar el scroll:
  final ScrollController scrollController = new ScrollController();

  //Esta función hace parte de los widgets stateful y se ejecuta
  //apenas carga o se renderiza por primera vez el widget:
  @override
  void initState() {
    super.initState();

    //agrego un listener al controller:
    scrollController.addListener(() {
      //scrollController.position.pixels: me dice el valor en pixeles
      //que se desplaza (de acuerdo a su main axis) el child en la
      //pantalla.
      //scrollController.position.maxScrollExtent: me dice el valor
      //MAXIMO en pixeles que se desplaza el child en la pantalla.
      //nota: observe que le resto 500 a maxScrollExtent, y esto se
      //hace para que antes de llegar al final del desplazamiento
      //se mande la petición:
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 500) {
        widget.onNextPage();
      }
    });
  }

  //Esta función hace parte de los widgets stateful y se ejecuta
  //cuando el widget va a ser destruido:
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      width: double.infinity,
      height: 290,
      //color: Colors.red, //Esta propiedad es una buena forma de ver
      //el espacio que ocupado el widget
      child: Column(
        //Se usa para alinear el contenido de la columna, en este
        //caso se alinea a la izquierda con CrossAxisAlignment.start:
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.title != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Text(
                widget.title!,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          Expanded(
            child: ListView.builder(
              //el argumento controller me permite enlazar el widget con
              //el ScrollController, este será el widget que escuchará:
              controller: scrollController,
              //Cambio la dirección en que se muestran los items del
              //ListView. Por defecto es vertical y aquí lo cambiamos a
              //horizontal:
              scrollDirection: Axis.horizontal,
              itemCount: widget.movies.length,
              itemBuilder: (BuildContext context, int index) =>
                  _MoviePoster(widget.movies[index]),
            ),
          ),
        ],
      ),
    );
  }
}

class _MoviePoster extends StatelessWidget {
  final Movie movie;

  const _MoviePoster(
    this.movie,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      height: 190,
      //color: Colors.green, //Esta propiedad es una buena forma de ver
      //el espacio que ocupado el widget
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          GestureDetector(
            onTap: () =>
                Navigator.pushNamed(context, 'details', arguments: movie),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                placeholder: const AssetImage('assets/no-image.jpg'),
                image: NetworkImage(movie.fullPosterImg),
                width: 130,
                height: 190,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            movie.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
