//lib/widgets/dashboard/frias_card.dart

import 'package:flutter/material.dart';

class FriasCard extends StatelessWidget {
  final Map<String, dynamic> data;

  const FriasCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final ranking = [...data["ranking"]];

    // Ordenar de menor frecuencia a mayor frecuencia
    ranking.sort((a, b) => a.frecuenciaTotal.compareTo(b.frecuenciaTotal));

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "❄️ Top 10 Frías",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            ...ranking.take(10).toList().asMap().entries.map((entry) {
              final index = entry.key;
              final e = entry.value;

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Row(
                  children: [
                    Container(
                      width: 28,
                      height: 28,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [Color(0xff396AFc), Color(0xff2948ff)],
                        ),
                      ),
                      child: Text(
                        e.numero.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    const SizedBox(width: 8),

                    Expanded(
                      child: Text(
                        "Salió ${e.frecuenciaTotal} veces",
                        style: TextStyle(
                          fontSize: 12,
                          color: index < 5 ? const Color(0xff00E5FF) : null,
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
}
