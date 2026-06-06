import 'package:flutter/material.dart';

class TopRelacionalCard extends StatelessWidget {
  final Map<String, dynamic> data;

  const TopRelacionalCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final ranking = data["ranking"];

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          colors: [Color(0xff161A25), Color(0xff1E2233)],
        ),
        boxShadow: const [
          BoxShadow(color: Color(0x338A2BE2), blurRadius: 12, spreadRadius: 1),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.psychology, color: Color(0xff00E5FF), size: 18),

                SizedBox(width: 6),

                Text(
                  "Top Relacional IA",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            ...ranking.take(10).toList().asMap().entries.map((entry) {
              final index = entry.key;
              final e = entry.value;

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 3),
                child: Row(
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: const LinearGradient(
                          colors: [Color(0xff8E2DE2), Color(0xff4A00E0)],
                        ),
                        boxShadow: const [
                          BoxShadow(color: Color(0x558E2DE2), blurRadius: 6),
                        ],
                      ),
                      child: Text(
                        "${index + 1}",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    const SizedBox(width: 8),

                    Container(
                      width: 28,
                      height: 28,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [Color(0xff00F260), Color(0xff0575E6)],
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

                    const SizedBox(width: 10),

                    Expanded(
                      child: Text(
                        "${e.probabilidad.toStringAsFixed(2)}%",
                        style: TextStyle(
                          fontSize: 12,
                          color: index < 5
                              ? const Color(0xff00E5FF)
                              : Colors.white70,
                          fontWeight: index < 5
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                    ),

                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: const Color(0x22FFD700),
                      ),
                      child: Text(
                        e.scoreRelacional.toStringAsFixed(1),
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: index < 5
                              ? const Color(0xffFFD700)
                              : Colors.white70,
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
