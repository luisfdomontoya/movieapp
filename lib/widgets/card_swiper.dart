//Paquete que contiene el SWIPER:
import 'package:card_swiper/card_swiper.dart';

import 'package:flutter/material.dart';

class CardSwiper extends StatelessWidget {
  const CardSwiper({super.key});

  @override
  Widget build(BuildContext context) {
    //MediaQuery me permite saber cuáles son las dimensiones
    //de mi dispositivo donde corre nuestra app:
    final size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity, //esta línea le dice que tome todo
      //el ancho posible basado en el contenedor padre.
      height: size.height * 0.5,
      //Child se usa para indicar que dentro del widget Container
      //(en este caso) irá otro widget, en este caso, el widget
      //Swiper:
      child: Swiper(
        //indica el número de tarjetas que tendráel swiper:
        itemCount: 10,
        layout: SwiperLayout.STACK,
        //itemWidth e itemHeight establecen el tamaño de cada carta
        //del swiper
        itemWidth: size.width * 0.6,
        itemHeight: size.height * 0.4,
        //recuerde que todo lo que diga BUILDER será algo que se
        //construirá de manera dinámica o cuando se necesite:
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            //GestureDetector me permite agregar un onTap que me
            //permitirá agregar una ruta al momento de hacer tap
            onTap: () => Navigator.pushNamed(
              context,
              'details',
              arguments: 'movie-instance',
            ),
            child: ClipRRect(
              //ClicpRRect me permite ponerle bordes al FadeInImage.
              //Esto lo hace con su propiedad borderRadius:
              borderRadius: BorderRadius.circular(20),
              child: const FadeInImage(
                placeholder: AssetImage('assets/no-image.jpg'),
                image: NetworkImage('https://via.placeholder.com/300x400'),
                //Le digo al FadeInImage que ocupe todo el espacio
                //disponible:
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}
