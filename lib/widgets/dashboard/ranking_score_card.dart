//lib/widgets/dashboard/ranking_score_card.dart

import 'package:flutter/material.dart';

class RankingScoreCard extends StatelessWidget {
  final Map<String, dynamic> data;

  const RankingScoreCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final ranking = data["ranking"];

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: const Color(0xff1A1D29),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: const LinearGradient(
                  colors: [Color(0xff8E2DE2), Color(0xff4A00E0)],
                ),
              ),
              child: const Text(
                "🧠 Ranking Inteligente",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),

            const SizedBox(height: 10),

            SizedBox(
              height: 380,
              child: ListView.builder(
                itemCount: ranking.length,
                itemBuilder: (_, index) {
                  final item = ranking[index];

                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 3),

                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 6,
                    ),

                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.04),
                      borderRadius: BorderRadius.circular(12),

                      border: Border.all(
                        color: index < 5
                            ? const Color(0xffFFD700)
                            : Colors.white12,
                      ),
                    ),

                    child: Row(
                      children: [
                        Container(
                          width: 28,
                          height: 28,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: index < 5
                                ? const LinearGradient(
                                    colors: [
                                      Color(0xffFFD700),
                                      Color(0xffFF8C00),
                                    ],
                                  )
                                : const LinearGradient(
                                    colors: [
                                      Color(0xff8E2DE2),
                                      Color(0xff4A00E0),
                                    ],
                                  ),
                          ),
                          child: Text(
                            "${index + 1}",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        const SizedBox(width: 10),

                        Container(
                          width: 32,
                          height: 32,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              colors: [Color(0xff00C6FF), Color(0xff0072FF)],
                            ),
                          ),
                          child: Text(
                            item.numero.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        const SizedBox(width: 10),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Bolilla ${item.numero}",
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              Text(
                                "50:${item.frecuencia50} | "
                                "100:${item.frecuencia100} | "
                                "500:${item.frecuencia500}",
                                style: const TextStyle(
                                  fontSize: 10,
                                  color: Colors.white70,
                                ),
                              ),
                            ],
                          ),
                        ),

                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            gradient: const LinearGradient(
                              colors: [Color(0xff00F260), Color(0xff0575E6)],
                            ),
                          ),
                          child: Text(
                            item.score.toStringAsFixed(1),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
