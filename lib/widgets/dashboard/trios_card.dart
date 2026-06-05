//lib/widgets/dashboard/trios_card.dart
import 'package:flutter/material.dart';

class TriosCard extends StatelessWidget {
  final Map<String, dynamic> data;

  const TriosCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final trios = data["topTrios"];

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "🎯 Top Tríos",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            ...trios.take(10).toList().asMap().entries.map((entry) {
              final index = entry.key;
              final e = entry.value;

              final numeros = e.clave.toString().split('-');

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Row(
                  children: [
                    _bolilla(numeros[0]),

                    const SizedBox(width: 4),

                    _bolilla(numeros[1]),

                    const SizedBox(width: 4),

                    _bolilla(numeros[2]),

                    const Spacer(),

                    Text(
                      e.frecuencia.toString(),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
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

  Widget _bolilla(String numero) {
    return Container(
      width: 28,
      height: 28,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [Color(0xff8E2DE2), Color(0xff4A00E0)],
        ),
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
