//lib/services/dashboard_service.dart
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/bolilla_stats.dart';
import '../models/par_stats.dart';
import '../models/trio_stats.dart';

class DashboardService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<Map<String, dynamic>> generarAnalisis() async {
    final snapshot = await _db.collection('registros').orderBy('sorte').get();

    final docs = snapshot.docs;

    final total = docs.length;

    final freqTotal = <int, int>{};
    final freq50 = <int, int>{};
    final freq100 = <int, int>{};
    final freq500 = <int, int>{};

    final ultimoSorteoBolilla = <int, int>{};

    final pares = <String, int>{};
    final trios = <String, int>{};

    for (int i = 1; i <= 35; i++) {
      freqTotal[i] = 0;
      freq50[i] = 0;
      freq100[i] = 0;
      freq500[i] = 0;
      ultimoSorteoBolilla[i] = 0;
    }

    for (int index = 0; index < docs.length; index++) {
      final doc = docs[index];

      final sorte = doc['sorte'];

      final nums = [
        doc['bolilla_uno'],
        doc['bolilla_dos'],
        doc['bolilla_tres'],
        doc['bolilla_cuatro'],
        doc['bolilla_cinco'],
      ];

      for (final n in nums) {
        freqTotal[n] = freqTotal[n]! + 1;
        ultimoSorteoBolilla[n] = sorte;
      }

      if (index >= total - 50) {
        for (final n in nums) {
          freq50[n] = freq50[n]! + 1;
        }
      }

      if (index >= total - 100) {
        for (final n in nums) {
          freq100[n] = freq100[n]! + 1;
        }
      }

      if (index >= total - 500) {
        for (final n in nums) {
          freq500[n] = freq500[n]! + 1;
        }
      }

      nums.sort();

      for (int i = 0; i < nums.length; i++) {
        for (int j = i + 1; j < nums.length; j++) {
          final clave = '${nums[i]}-${nums[j]}';

          pares[clave] = (pares[clave] ?? 0) + 1;
        }
      }

      for (int i = 0; i < nums.length; i++) {
        for (int j = i + 1; j < nums.length; j++) {
          for (int k = j + 1; k < nums.length; k++) {
            final clave = '${nums[i]}-${nums[j]}-${nums[k]}';

            trios[clave] = (trios[clave] ?? 0) + 1;
          }
        }
      }
    }

    final ultimoSorteo = docs.last['sorte'];

    final ranking = <BolillaStats>[];

    for (int i = 1; i <= 35; i++) {
      final atraso = ultimoSorteo - ultimoSorteoBolilla[i]!;

      final score =
          (freq500[i]! * 0.40) +
          (freq100[i]! * 0.25) +
          (freq50[i]! * 0.15) +
          (atraso * 0.20);

      ranking.add(
        BolillaStats(
          numero: i,
          frecuenciaTotal: freqTotal[i]!,
          frecuencia50: freq50[i]!,
          frecuencia100: freq100[i]!,
          frecuencia500: freq500[i]!,
          atraso: atraso,
          score: score,
        ),
      );
    }

    ranking.sort((a, b) => b.score.compareTo(a.score));

    final topPares =
        pares.entries
            .map((e) => ParStats(clave: e.key, frecuencia: e.value))
            .toList()
          ..sort((a, b) => b.frecuencia.compareTo(a.frecuencia));

    final topTrios =
        trios.entries
            .map((e) => TrioStats(clave: e.key, frecuencia: e.value))
            .toList()
          ..sort((a, b) => b.frecuencia.compareTo(a.frecuencia));

    return {
      "totalSorteos": total,
      "ultimoSorteo": ultimoSorteo,
      "ranking": ranking,
      "topPares": topPares.take(20).toList(),
      "topTrios": topTrios.take(20).toList(),
      "apuestas": generarApuestas(ranking),
    };
  }

  List<List<int>> generarApuestas(List<BolillaStats> ranking) {
    final rnd = Random();

    final top12 = ranking.take(12).map((e) => e.numero).toList();

    final apuestas = <List<int>>[];

    for (int i = 0; i < 10; i++) {
      final copia = [...top12];

      copia.shuffle(rnd);

      apuestas.add(copia.take(5).toList()..sort());
    }

    return apuestas;
  }
}
