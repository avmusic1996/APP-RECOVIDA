import 'package:flutter/cupertino.dart';

class Usuario {
  Text nombre;
  Text fecha_hora;
  int dias_ano;
  Text continente;
  Text pais;
  Text ciudad;
  Text barrio;
  Text presidente;
  Text gobernador;
  Text celebramos;
  Usuario({
    required this.nombre,
    required this.fecha_hora,
    required this.dias_ano,
    required this.continente,
    required this.pais,
    required this.ciudad,
    required this.barrio,
    required this.presidente,
    required this.gobernador,
    required this.celebramos,
  });

  factory Usuario.fromJson(Map json) {
    return Usuario(
        nombre: json["nombre"],
        fecha_hora: json["fecha_hora"],
        dias_ano: json["dias_ano"],
        continente: json["continente"],
        pais: json["pais"],
        ciudad: json["ciudad"],
        barrio: json["barrio"],
        presidente: json["presidente"],
        gobernador: json["gobernador"],
        celebramos: json["celebramos"]);
  }
}
