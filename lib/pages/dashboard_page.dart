//lib/pages/dashboard_page.dart
import 'package:flutter/material.dart';

import '../widgets/app_navbar.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppNavbar(currentPage: "dashboard"),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                gradient: const LinearGradient(
                  colors: [Color(0xFF00F5FF), Color(0xFF7B2FFF)],
                ),
              ),
              child: const Center(
                child: Text(
                  "Dashboard",
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
