//lib/widgets/dashboard/pares_card.dart
import 'package:flutter/material.dart';

class ParesCard extends StatelessWidget {
  final Map<String, dynamic> data;

  const ParesCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final pares = data["topPares"];

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const Text("👥 Top Pares"),
            ...pares
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
