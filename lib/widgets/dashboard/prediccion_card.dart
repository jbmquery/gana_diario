import 'package:flutter/material.dart';

class PrediccionCard extends StatelessWidget {
  final Map<String, dynamic> data;

  const PrediccionCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final ranking = data["ranking"];

    final sugeridas = ranking.take(5).toList();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text("Predicción sugerida", style: TextStyle(fontSize: 20)),
            const SizedBox(height: 20),
            Wrap(
              spacing: 10,
              children: sugeridas
                  .map((e) => Chip(label: Text(e.numero.toString())))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
