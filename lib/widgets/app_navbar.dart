import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../pages/dashboard_page.dart';
import '../pages/registros_page.dart';

class AppNavbar extends StatelessWidget implements PreferredSizeWidget {
  final String currentPage;

  const AppNavbar({super.key, required this.currentPage});

  Future<void> _logout(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();

      print("SESION CERRADA");
    } catch (e) {
      print("ERROR AL CERRAR SESION: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleSpacing: 20,
      title: const Text('''Gana Diario
Analytics''', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),

      actions: [
        IconButton(
          tooltip: "Dashboard",
          icon: Icon(
            Icons.dashboard,
            color: currentPage == "dashboard"
                ? Colors.cyanAccent
                : Colors.white,
          ),
          onPressed: () {
            if (currentPage == "dashboard") return;

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const DashboardPage()),
            );
          },
        ),

        IconButton(
          tooltip: "Registros",
          icon: Icon(
            Icons.list_alt,
            color: currentPage == "registros"
                ? Colors.purpleAccent
                : Colors.white,
          ),
          onPressed: () {
            if (currentPage == "registros") return;

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const RegistrosPage()),
            );
          },
        ),

        IconButton(
          tooltip: "Salir",
          icon: const Icon(Icons.logout),
          onPressed: () async {
            print("CLICK EN SALIR");

            await _logout(context);
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
