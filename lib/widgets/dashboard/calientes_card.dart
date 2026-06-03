import 'package:flutter/material.dart';

class CalientesCard extends StatelessWidget {
  final Map<String, dynamic> data;

  const CalientesCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final ranking = data["ranking"];

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text("Top 10 Calientes"),
            const SizedBox(height: 12),
            ...ranking
                .take(10)
                .map(
                  (e) => ListTile(
                    leading: CircleAvatar(child: Text(e.numero.toString())),
                    title: Text("${e.frecuencia} apariciones"),
                  ),
                ),
          ],
        ),
      ),
    );
  }
}
