//lib/services/registros_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/registro_model.dart';

class RegistrosService {
  static final _db = FirebaseFirestore.instance;

  static CollectionReference<Map<String, dynamic>> get collection =>
      _db.collection('registros');

  static Stream<List<RegistroModel>> streamRegistros() {
    return collection
        .orderBy('fecha', descending: true)
        .limit(20)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => RegistroModel.fromFirestore(doc))
              .toList(),
        );
  }

  static Stream<List<RegistroModel>> streamRegistrosPorFecha(DateTime fecha) {
    final inicio = DateTime(fecha.year, fecha.month, fecha.day);

    final fin = inicio.add(const Duration(days: 1));

    return collection
        .where('fecha', isGreaterThanOrEqualTo: Timestamp.fromDate(inicio))
        .where('fecha', isLessThan: Timestamp.fromDate(fin))
        .orderBy('fecha', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => RegistroModel.fromFirestore(doc))
              .toList(),
        );
  }

  static Stream<List<RegistroModel>> streamRegistroPorSorte(int sorte) {
    return collection
        .where('sorte', isEqualTo: sorte)
        .limit(1)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => RegistroModel.fromFirestore(doc))
              .toList(),
        );
  }

  static Future<void> crearRegistro(RegistroModel registro) async {
    final existe = await collection
        .where('sorte', isEqualTo: registro.sorte)
        .limit(1)
        .get();

    if (existe.docs.isNotEmpty) {
      throw Exception('Ya existe un registro con el sorteo ${registro.sorte}');
    }

    await collection.add(registro.toMap());
  }

  static Future<void> actualizarRegistro(RegistroModel registro) async {
    if (registro.id == null) return;

    final repetido = await collection
        .where('sorte', isEqualTo: registro.sorte)
        .get();

    for (final doc in repetido.docs) {
      if (doc.id != registro.id) {
        throw Exception(
          'Ya existe un registro con el sorteo ${registro.sorte}',
        );
      }
    }

    await collection.doc(registro.id).update(registro.toMap());
  }

  static Future<void> eliminarRegistro(String id) async {
    await collection.doc(id).delete();
  }

  static Future<DocumentSnapshot<Map<String, dynamic>>?> buscarPorSorte(
    int sorte,
  ) async {
    final resultado = await collection
        .where('sorte', isEqualTo: sorte)
        .limit(1)
        .get();

    if (resultado.docs.isEmpty) {
      return null;
    }

    return resultado.docs.first;
  }

  static Future<void> upsertRegistro({
    required Timestamp fecha,
    required int sorte,
    required int bolillaUno,
    required int bolillaDos,
    required int bolillaTres,
    required int bolillaCuatro,
    required int bolillaCinco,
  }) async {
    final existente = await buscarPorSorte(sorte);

    final data = {
      'fecha': fecha,
      'sorte': sorte,
      'bolilla_uno': bolillaUno,
      'bolilla_dos': bolillaDos,
      'bolilla_tres': bolillaTres,
      'bolilla_cuatro': bolillaCuatro,
      'bolilla_cinco': bolillaCinco,
    };

    if (existente == null) {
      await collection.add(data);
    } else {
      await collection.doc(existente.id).update(data);
    }
  }
}
