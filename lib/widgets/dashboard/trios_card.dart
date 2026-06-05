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
          children: [
            const Text("🎯 Top Tríos"),
            ...trios
                .take(10)
                .map(
                  (e) => ListTile(
                    title: Text(e.clave),
                    trailing: Text(e.frecuencia.toString()),
                  ),
                ),
          ],
        ),
      ),
    );
  }
}
