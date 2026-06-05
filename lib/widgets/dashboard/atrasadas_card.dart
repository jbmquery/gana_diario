//lib/widgets/dashboard/atrasadas_card.dart
import 'package:flutter/material.dart';

class AtrasadasCard extends StatelessWidget {
  final Map<String, dynamic> data;

  const AtrasadasCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final ranking = [...data["ranking"]];

    ranking.sort((a, b) => b.atraso.compareTo(a.atraso));

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const Text("⌛ Más atrasadas"),
            ...ranking
                .take(10)
                .map(
                  (e) => ListTile(
                    title: Text("Bolilla ${e.numero}"),
                    trailing: Text("${e.atraso} sorteos"),
                  ),
                ),
          ],
        ),
      ),
    );
  }
}
