import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/bolilla_stats.dart';

class DashboardService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<Map<String, dynamic>> generarAnalisis() async {
    final snapshot = await _db.collection('registros').orderBy('sorte').get();

    final docs = snapshot.docs;

    final frecuencia = <int, int>{};

    final ultimoSorteoBolilla = <int, int>{};

    for (int i = 1; i <= 35; i++) {
      frecuencia[i] = 0;
      ultimoSorteoBolilla[i] = 0;
    }

    for (var doc in docs) {
      final sorte = doc['sorte'];

      final numeros = [
        doc['bolilla_uno'],
        doc['bolilla_dos'],
        doc['bolilla_tres'],
        doc['bolilla_cuatro'],
        doc['bolilla_cinco'],
      ];

      for (final n in numeros) {
        frecuencia[n] = frecuencia[n]! + 1;
        ultimoSorteoBolilla[n] = sorte;
      }
    }

    final ultimoSorteo = docs.last['sorte'];

    final ranking = <BolillaStats>[];

    for (int i = 1; i <= 35; i++) {
      ranking.add(
        BolillaStats(
          numero: i,
          frecuencia: frecuencia[i]!,
          atraso: ultimoSorteo - ultimoSorteoBolilla[i]!,
        ),
      );
    }

    ranking.sort((a, b) => b.frecuencia.compareTo(a.frecuencia));

    return {
      "totalSorteos": docs.length,
      "ultimoSorteo": ultimoSorteo,
      "ranking": ranking,
    };
  }
}
