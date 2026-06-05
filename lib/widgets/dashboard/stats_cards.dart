//lib/widgets/dashboard/stats_cards.dart
import 'package:flutter/material.dart';

class StatsCards extends StatelessWidget {
  final Map<String, dynamic> data;

  const StatsCards({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final ranking = data["ranking"];

    return Wrap(
      spacing: 8,
      runSpacing: 12,
      children: [
        _card("Sorteos", data["totalSorteos"].toString()),
        _card("Último", "#${data["ultimoSorteo"]}"),
        _card("Más fuerte", ranking.first.numero.toString()),
        _card("Más fría", ranking.last.numero.toString()),
      ],
    );
  }

  Widget _card(String titulo, String valor) {
    return Container(
      width: 80,
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xff1B1F2A),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Text(titulo, style: const TextStyle(fontSize: 11)),

          const SizedBox(height: 4),

          Text(
            valor,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
