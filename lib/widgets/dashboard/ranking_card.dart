import 'package:flutter/material.dart';

class RankingCard extends StatelessWidget {
  final Map<String, dynamic> data;

  const RankingCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final ranking = data["ranking"];

    return Card(
      child: SizedBox(
        height: 600,
        child: ListView.builder(
          itemCount: ranking.length,
          itemBuilder: (_, i) {
            final item = ranking[i];

            return ListTile(
              leading: Text("#${i + 1}"),
              title: Text("Bolilla ${item.numero}"),
              trailing: Text(item.frecuencia.toString()),
            );
          },
        ),
      ),
    );
  }
}
