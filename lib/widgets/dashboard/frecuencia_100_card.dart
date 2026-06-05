import 'package:flutter/material.dart';

class Frecuencia100Card extends StatelessWidget {
  final Map<String, dynamic> data;

  const Frecuencia100Card({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final ranking = [...data["ranking"]];

    ranking.sort((a, b) => b.frecuencia100.compareTo(a.frecuencia100));

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "📊 Últimos 100",
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
                    _bolilla(e.numero.toString()),

                    const SizedBox(width: 8),

                    const Spacer(),

                    Text(
                      "${e.frecuencia100} veces",
                      style: const TextStyle(fontSize: 10),
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
          colors: [Color(0xff11998E), Color(0xff38EF7D)],
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
