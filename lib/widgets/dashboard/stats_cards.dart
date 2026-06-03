import 'package:flutter/material.dart';

class StatsCards extends StatelessWidget {
  final Map<String, dynamic> data;

  const StatsCards({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final ranking = data["ranking"];

    return Wrap(
      spacing: 12,
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
      width: 180,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xff1B1F2A),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Text(titulo),
          const SizedBox(height: 10),
          Text(
            valor,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
