//lib/widgets/dashboard/calientes_card.dart
import 'package:flutter/material.dart';

class CalientesCard extends StatelessWidget {
  final Map<String, dynamic> data;

  const CalientesCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final ranking = data["ranking"];

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "🔥 Top 10 Calientes",
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
                          colors: [Color(0xffFF512F), Color(0xffF09819)],
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
                          fontWeight: index < 5
                              ? FontWeight.normal
                              : FontWeight.normal,
                          color: index < 5 ? const Color(0xffFFD700) : null,
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
