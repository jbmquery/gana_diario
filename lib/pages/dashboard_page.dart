//lib/pages/dashboard_page.dart

import 'package:flutter/material.dart';

import '../services/dashboard_service.dart';

import '../widgets/app_navbar.dart';

import '../widgets/dashboard/selector_fecha.dart';

import '../widgets/dashboard/stats_cards.dart';
import '../widgets/dashboard/calientes_card.dart';
import '../widgets/dashboard/frias_card.dart';

import '../widgets/dashboard/atrasadas_card.dart';
import '../widgets/dashboard/pares_card.dart';
import '../widgets/dashboard/trios_card.dart';
import '../widgets/dashboard/apuestas_card.dart';
import '../widgets/dashboard/frecuencia_50_card.dart';
import '../widgets/dashboard/frecuencia_100_card.dart';
import '../widgets/dashboard/frecuencia_500_card.dart';

import '../widgets/dashboard/premium_card.dart';
import '../widgets/dashboard/ranking_score_card.dart';

import '../widgets/dashboard/coocurrencia_card.dart';

import '../widgets/dashboard/top_relacional_card.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  DateTime? fechaSeleccionada;

  List<int> bolillasSeleccionadas = [];

  Future<Map<String, dynamic>>? futureAnalisis;

  @override
  void initState() {
    super.initState();

    futureAnalisis = DashboardService().generarAnalisis(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    print("BUILD DASHBOARD");

    return Scaffold(
      appBar: const AppNavbar(currentPage: "dashboard"),

      body: Column(
        children: [
          //=========================================
          // SELECTOR FIJO
          //=========================================
          SelectorFecha(
            key: const ValueKey('selector_fecha'),
            onFechaChanged: (fecha, bolillas) {
              print("FECHA RECIBIDA => $fecha");

              if (fechaSeleccionada == fecha &&
                  bolillasSeleccionadas.toString() == bolillas.toString()) {
                return;
              }

              setState(() {
                print("SETSTATE DASHBOARD");

                fechaSeleccionada = fecha;

                bolillasSeleccionadas = bolillas;

                futureAnalisis = DashboardService().generarAnalisis(fecha);
              });
            },
          ),

          //=========================================
          // CONTENIDO DEL DASHBOARD
          //=========================================
          Expanded(
            child: FutureBuilder<Map<String, dynamic>>(
              future: futureAnalisis,
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
                      StatsCards(data: data),

                      const SizedBox(height: 10),

                      PremiumCard(data: data),

                      const SizedBox(height: 10),

                      TopRelacionalCard(data: data),

                      const SizedBox(height: 10),

                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(child: Frecuencia50Card(data: data)),

                          const SizedBox(width: 5),

                          Expanded(child: Frecuencia100Card(data: data)),

                          const SizedBox(width: 5),

                          Expanded(child: Frecuencia500Card(data: data)),
                        ],
                      ),

                      const SizedBox(height: 10),

                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(child: CalientesCard(data: data)),

                          const SizedBox(width: 5),

                          Expanded(child: FriasCard(data: data)),
                        ],
                      ),

                      const SizedBox(height: 10),

                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(child: ParesCard(data: data)),

                          const SizedBox(width: 5),

                          Expanded(child: TriosCard(data: data)),
                        ],
                      ),

                      const SizedBox(height: 10),

                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(child: AtrasadasCard(data: data)),

                          const SizedBox(width: 5),

                          Expanded(child: ApuestasCard(data: data)),
                        ],
                      ),

                      const SizedBox(height: 10),

                      RankingScoreCard(data: data),

                      const SizedBox(height: 10),

                      CoocurrenciaCard(data: data),

                      const SizedBox(height: 20),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
