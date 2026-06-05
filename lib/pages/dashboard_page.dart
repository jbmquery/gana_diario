//lib/pages/dashboard_page.dart
import 'package:flutter/material.dart';

import '../services/dashboard_service.dart';

import '../widgets/app_navbar.dart';

import '../widgets/dashboard/stats_cards.dart';
import '../widgets/dashboard/calientes_card.dart';
import '../widgets/dashboard/frias_card.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppNavbar(currentPage: "dashboard"),
      body: FutureBuilder(
        future: DashboardService().generarAnalisis(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final data = snapshot.data!;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                StatsCards(data: data),

                const SizedBox(height: 5),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: CalientesCard(data: data)),

                    const SizedBox(width: 5),

                    Expanded(child: FriasCard(data: data)),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
