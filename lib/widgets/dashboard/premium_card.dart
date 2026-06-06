//lib/widgets/dashboard/premium_card.dart

import 'package:flutter/material.dart';

class PremiumCard extends StatelessWidget {
  final Map<String, dynamic> data;

  const PremiumCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final ranking = data["ranking"];

    final maxScore = ranking.first.score;

    return Card(
      elevation: 6,
      color: const Color(0xff1A1D29),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "🏆 Top 10 Premium",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            ...ranking.take(10).toList().asMap().entries.map((entry) {
              final index = entry.key;
              final e = entry.value;

              final porcentaje = e.score / maxScore;

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  children: [
                    _bolilla(e.numero.toString(), index),

                    const SizedBox(width: 8),

                    Expanded(
                      child: Stack(
                        children: [
                          Container(
                            height: 10,
                            decoration: BoxDecoration(
                              color: Colors.white10,
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),

                          FractionallySizedBox(
                            widthFactor: porcentaje,
                            child: Container(
                              height: 10,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                gradient: LinearGradient(
                                  colors: index < 5
                                      ? [
                                          const Color(0xffFFD700),
                                          const Color(0xffFF8C00),
                                        ]
                                      : [
                                          const Color(0xff00F260),
                                          const Color(0xff0575E6),
                                        ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(width: 8),

                    SizedBox(
                      width: 40,
                      child: Text(
                        e.score.toStringAsFixed(1),
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: index < 5
                              ? FontWeight.bold
                              : FontWeight.normal,
                          color: index < 5
                              ? const Color(0xffFFD700)
                              : Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _bolilla(String numero, int posicion) {
    return Container(
      width: 30,
      height: 30,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: posicion < 5
              ? [
                  const Color.fromARGB(255, 251, 0, 255),
                  const Color.fromARGB(255, 208, 67, 135),
                ]
              : [const Color(0xff8E2DE2), const Color(0xff4A00E0)],
        ),
        boxShadow: [
          BoxShadow(
            color: posicion < 5
                ? const Color.fromARGB(255, 255, 7, 234).withValues(alpha: 0.5)
                : Colors.deepPurple.withValues(alpha: 0.4),
            blurRadius: 8,
          ),
        ],
      ),
      child: Text(
        numero,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 11,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
