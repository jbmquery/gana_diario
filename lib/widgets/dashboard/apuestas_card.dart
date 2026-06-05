//lib/widgets/dashboard/apuestas_card.dart
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
          children: [
            const Text("🎰 100 apuestas sugeridas"),
            SizedBox(
              height: 300,
              child: ListView.builder(
                itemCount: apuestas.length,
                itemBuilder: (_, i) {
                  return ListTile(
                    dense: true,
                    title: Text(apuestas[i].join(" - ")),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
