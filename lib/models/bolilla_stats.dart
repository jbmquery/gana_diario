//lib/models/bolilla_stats.dart
class BolillaStats {
  final int numero;

  final int frecuenciaTotal;
  final int frecuencia50;
  final int frecuencia100;
  final int frecuencia500;

  final int atraso;

  final double score;

  BolillaStats({
    required this.numero,
    required this.frecuenciaTotal,
    required this.frecuencia50,
    required this.frecuencia100,
    required this.frecuencia500,
    required this.atraso,
    required this.score,
  });
}
