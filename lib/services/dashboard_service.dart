//lib/services/dashboard_service.dart
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/bolilla_stats.dart';
import '../models/par_stats.dart';
import '../models/trio_stats.dart';
import '../models/coocurrencia_stats.dart';

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
    final matriz = <String, int>{};

    for (int i = 1; i <= 35; i++) {
      freqTotal[i] = 0;
      freq50[i] = 0;
      freq100[i] = 0;
      freq500[i] = 0;
      ultimoSorteoBolilla[i] = 0;
    }

    //-----------------------------------
    // RECORRER HISTORIAL
    //-----------------------------------

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

      // PARES
      for (int i = 0; i < nums.length; i++) {
        for (int j = i + 1; j < nums.length; j++) {
          final clave = '${nums[i]}-${nums[j]}';

          pares[clave] = (pares[clave] ?? 0) + 1;
          matriz[clave] = (matriz[clave] ?? 0) + 1;
        }
      }

      // TRIOS
      for (int i = 0; i < nums.length; i++) {
        for (int j = i + 1; j < nums.length; j++) {
          for (int k = j + 1; k < nums.length; k++) {
            final clave = '${nums[i]}-${nums[j]}-${nums[k]}';

            trios[clave] = (trios[clave] ?? 0) + 1;
          }
        }
      }
    }

    //-----------------------------------
    // COOCURRENCIAS
    //-----------------------------------

    final topCoocurrencias = matriz.entries.map((e) {
      final partes = e.key.split('-');

      return CoocurrenciaStats(
        bolillaA: int.parse(partes[0]),
        bolillaB: int.parse(partes[1]),
        frecuencia: e.value,
      );
    }).toList()..sort((a, b) => b.frecuencia.compareTo(a.frecuencia));

    //-----------------------------------
    // SCORE RELACIONAL
    //-----------------------------------

    final scoreRelacionalPorBolilla = <int, double>{};

    for (int i = 1; i <= 35; i++) {
      scoreRelacionalPorBolilla[i] = 0;
    }

    for (final item in topCoocurrencias.take(100)) {
      scoreRelacionalPorBolilla[item.bolillaA] =
          scoreRelacionalPorBolilla[item.bolillaA]! + item.frecuencia;

      scoreRelacionalPorBolilla[item.bolillaB] =
          scoreRelacionalPorBolilla[item.bolillaB]! + item.frecuencia;
    }

    //-----------------------------------
    // RANKING
    //-----------------------------------

    final ultimoSorteo = docs.last['sorte'];

    final ranking = <BolillaStats>[];

    double totalScoreRelacional = 0;

    for (int i = 1; i <= 35; i++) {
      final atraso = ultimoSorteo - ultimoSorteoBolilla[i]!;

      final scoreBase =
          (freq500[i]! * 0.40) +
          (freq100[i]! * 0.25) +
          (freq50[i]! * 0.15) +
          (atraso * 0.20);

      final scoreRelacional =
          scoreBase + (scoreRelacionalPorBolilla[i]! * 0.05);

      totalScoreRelacional += scoreRelacional;

      ranking.add(
        BolillaStats(
          numero: i,
          frecuenciaTotal: freqTotal[i]!,
          frecuencia50: freq50[i]!,
          frecuencia100: freq100[i]!,
          frecuencia500: freq500[i]!,
          atraso: atraso,
          score: scoreBase,
          scoreRelacional: scoreRelacional,
          probabilidad: 0,
        ),
      );
    }

    //-----------------------------------
    // PROBABILIDAD ESTIMADA
    //-----------------------------------

    final rankingFinal = ranking
        .map(
          (e) => BolillaStats(
            numero: e.numero,
            frecuenciaTotal: e.frecuenciaTotal,
            frecuencia50: e.frecuencia50,
            frecuencia100: e.frecuencia100,
            frecuencia500: e.frecuencia500,
            atraso: e.atraso,
            score: e.score,
            scoreRelacional: e.scoreRelacional,
            probabilidad: (e.scoreRelacional / totalScoreRelacional) * 100,
          ),
        )
        .toList();

    rankingFinal.sort((a, b) => b.scoreRelacional.compareTo(a.scoreRelacional));

    //-----------------------------------
    // PARES
    //-----------------------------------

    final topPares =
        pares.entries
            .map((e) => ParStats(clave: e.key, frecuencia: e.value))
            .toList()
          ..sort((a, b) => b.frecuencia.compareTo(a.frecuencia));

    //-----------------------------------
    // TRIOS
    //-----------------------------------

    final topTrios =
        trios.entries
            .map((e) => TrioStats(clave: e.key, frecuencia: e.value))
            .toList()
          ..sort((a, b) => b.frecuencia.compareTo(a.frecuencia));

    //-----------------------------------
    // RESULTADO
    //-----------------------------------

    return {
      "totalSorteos": total,
      "ultimoSorteo": ultimoSorteo,
      "ranking": rankingFinal,
      "topPares": topPares.take(20).toList(),
      "topTrios": topTrios.take(20).toList(),
      "topCoocurrencias": topCoocurrencias.take(50).toList(),
      "apuestas": generarApuestas(rankingFinal),
    };
  }

  //-----------------------------------
  // APUESTAS
  //-----------------------------------

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
