import 'package:cloud_firestore/cloud_firestore.dart';

class RegistroModel {
  final String? id;
  final Timestamp fecha;
  final int sorte;
  final int bolillaUno;
  final int bolillaDos;
  final int bolillaTres;
  final int bolillaCuatro;
  final int bolillaCinco;

  RegistroModel({
    this.id,
    required this.fecha,
    required this.sorte,
    required this.bolillaUno,
    required this.bolillaDos,
    required this.bolillaTres,
    required this.bolillaCuatro,
    required this.bolillaCinco,
  });

  factory RegistroModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data()!;

    return RegistroModel(
      id: doc.id,
      fecha: data['fecha'],
      sorte: data['sorte'],
      bolillaUno: data['bolilla_uno'],
      bolillaDos: data['bolilla_dos'],
      bolillaTres: data['bolilla_tres'],
      bolillaCuatro: data['bolilla_cuatro'],
      bolillaCinco: data['bolilla_cinco'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'fecha': fecha,
      'sorte': sorte,
      'bolilla_uno': bolillaUno,
      'bolilla_dos': bolillaDos,
      'bolilla_tres': bolillaTres,
      'bolilla_cuatro': bolillaCuatro,
      'bolilla_cinco': bolillaCinco,
    };
  }
}
