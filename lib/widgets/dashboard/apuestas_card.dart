import 'package:flutter/material.dart';

class ApuestasCard extends StatelessWidget {
  final Map<String, dynamic> data;

  const ApuestasCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final apuestas = data["apuestas"];

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "🎰 Apuestas",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            ...apuestas.take(10).toList().asMap().entries.map((entry) {
              final index = entry.key;
              final apuesta = entry.value;

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Row(
                  children: [
                    ...apuesta.map<Widget>(
                      (numero) => Padding(
                        padding: const EdgeInsets.only(right: 4),
                        child: _bolilla(numero.toString()),
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
      width: 24,
      height: 24,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [Color(0xff00F260), Color(0xff0575E6)],
        ),
      ),
      child: Text(
        numero,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
