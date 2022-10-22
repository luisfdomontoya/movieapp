import 'dart:async';
// Creditos
// https://stackoverflow.com/a/52922130/7834829

class Debouncer<T> {
  Debouncer({required this.duration, this.onValue});

  //Es la cantidad de tiempo que voy a esperar antes de
  //enviar un valor (una petición):
  final Duration duration;

  //Es el método que voy a disparar apenas tenga un valor
  void Function(T value)? onValue;

  T? _value;
  Timer? _timer;

  T get value => _value!;

  set value(T val) {
    _value = val;
    //si recibimos un valor (val) cancelamos el timer:
    _timer?.cancel();
    //Si el timer cumple la duración que yo especifiqué
    //mando a llamar el método onValue:
    _timer = Timer(duration, () => onValue!(_value!));
  }
}
