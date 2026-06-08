//lib/services/dashboard_state.dart
import 'package:flutter/material.dart';

import '../models/dashboard_filtro.dart';

class DashboardState extends ChangeNotifier {
  DashboardFiltro? filtro;

  void actualizarFiltro(DashboardFiltro nuevoFiltro) {
    filtro = nuevoFiltro;
    notifyListeners();
  }
}
