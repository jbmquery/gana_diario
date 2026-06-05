//lib/pages/dashboard_page.dart

import 'package:flutter/material.dart';

import '../services/dashboard_service.dart';

import '../widgets/app_navbar.dart';

import '../widgets/dashboard/stats_cards.dart';
import '../widgets/dashboard/calientes_card.dart';
import '../widgets/dashboard/frias_card.dart';

import '../widgets/dashboard/atrasadas_card.dart';
import '../widgets/dashboard/pares_card.dart';
import '../widgets/dashboard/trios_card.dart';
import '../widgets/dashboard/apuestas_card.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppNavbar(currentPage: "dashboard"),
      body: FutureBuilder<Map<String, dynamic>>(
        future: DashboardService().generarAnalisis(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          if (!snapshot.hasData) {
            return const Center(child: Text("Sin datos"));
          }

          final data = snapshot.data!;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // RESUMEN
                StatsCards(data: data),

                const SizedBox(height: 10),

                // CALIENTES Y FRIAS
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: CalientesCard(data: data)),

                    const SizedBox(width: 5),

                    Expanded(child: FriasCard(data: data)),
                  ],
                ),

                const SizedBox(height: 10),

                // PARES Y TRIOS
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: ParesCard(data: data)),

                    const SizedBox(width: 5),

                    Expanded(child: TriosCard(data: data)),
                  ],
                ),

                const SizedBox(height: 10),

                // ATRASADAS
                AtrasadasCard(data: data),

                const SizedBox(height: 10),

                // APUESTAS
                ApuestasCard(data: data),
              ],
            ),
          );
        },
      ),
    );
  }
}
