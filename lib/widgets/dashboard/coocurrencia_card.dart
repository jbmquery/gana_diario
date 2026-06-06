import 'package:flutter/material.dart';

class CoocurrenciaCard extends StatelessWidget {
  final Map<String, dynamic> data;

  const CoocurrenciaCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final lista = data["topCoocurrencias"];

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: const Color(0xff1A1D29),
        boxShadow: const [
          BoxShadow(
            color: Colors.black54,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.link, color: Color(0xffC471ED), size: 18),
                SizedBox(width: 6),
                Text(
                  "Coocurrencias",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            ...lista.take(10).toList().asMap().entries.map((entry) {
              final index = entry.key;
              final e = entry.value;

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 3),
                child: Row(
                  children: [
                    _bolilla(e.bolillaA.toString()),

                    const SizedBox(width: 4),

                    _bolilla(e.bolillaB.toString()),

                    const Spacer(),

                    Text(
                      e.frecuencia.toString(),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: index < 5
                            ? FontWeight.bold
                            : FontWeight.normal,
                        color: index < 5
                            ? const Color(0xffFFD700)
                            : Colors.white70,
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
          colors: [Color(0xffC471ED), Color(0xff12C2E9)],
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
