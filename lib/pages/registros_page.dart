//lib/pages/registros_page.dart
import 'package:flutter/material.dart';

import '../models/registro_model.dart';
import '../services/registros_service.dart';

import '../widgets/app_navbar.dart';

import '../widgets/registros/registro_dialog.dart';
import '../widgets/registros/registros_toolbar.dart';
import '../widgets/registros/registros_list.dart';
import '../services/excel_service.dart';
import 'package:open_filex/open_filex.dart';

class RegistrosPage extends StatefulWidget {
  const RegistrosPage({super.key});

  @override
  State<RegistrosPage> createState() => _RegistrosPageState();
}

class _RegistrosPageState extends State<RegistrosPage> {
  final sorteController = TextEditingController();

  DateTime? fechaFiltro;

  Future<void> seleccionarFecha() async {
    final fecha = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2010),
      lastDate: DateTime(2100),
    );

    if (fecha != null) {
      setState(() {
        fechaFiltro = fecha;
      });
    }
  }

  void abrirNuevoRegistro() {
    showDialog(context: context, builder: (_) => const RegistroDialog());
  }

  void editarRegistro(RegistroModel registro) {
    showDialog(
      context: context,
      builder: (_) => RegistroDialog(registro: registro),
    );
  }

  Future<List<RegistroModel>> cargarRegistros() {
    final texto = sorteController.text.trim();

    if (texto.isNotEmpty) {
      final sorte = int.tryParse(texto);

      if (sorte == null) {
        return Future.value([]);
      }

      return RegistrosService.obtenerRegistroPorSorte(sorte);
    }

    if (fechaFiltro != null) {
      return RegistrosService.obtenerRegistrosPorFecha(fechaFiltro!);
    }

    return RegistrosService.obtenerRegistros();
  }

  Future<void> importarExcel() async {
    try {
      final resultado = await ExcelService.importarArchivo();

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Insertados: ${resultado['insertados']} | '
            'Actualizados: ${resultado['actualizados']}',
          ),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  Future<void> descargarPlantilla() async {
    final path = await ExcelService.descargarPlantilla();

    if (!mounted) return;

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Plantilla guardada en:\n$path')));
  }

  Future<void> exportarTodosLosRegistros() async {
    try {
      final path = await ExcelService.exportarTodosLosRegistros();

      await OpenFilex.open(path);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Excel generado correctamente')),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  bool coincideFecha(RegistroModel registro) {
    if (fechaFiltro == null) {
      return true;
    }

    final fecha = registro.fecha.toDate();

    return fecha.day == fechaFiltro!.day &&
        fecha.month == fechaFiltro!.month &&
        fecha.year == fechaFiltro!.year;
  }

  bool coincideSorte(RegistroModel registro) {
    if (sorteController.text.trim().isEmpty) {
      return true;
    }

    return registro.sorte.toString().contains(sorteController.text.trim());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppNavbar(currentPage: "registros"),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            RegistrosToolbar(
              sorteController: sorteController,

              onBuscar: (_) {
                setState(() {});
              },

              fechaFiltro: fechaFiltro,

              onNuevoRegistro: abrirNuevoRegistro,
              onExportarExcel: exportarTodosLosRegistros,

              onImportarExcel: importarExcel,

              onDescargarPlantilla: descargarPlantilla,

              onSeleccionarFecha: seleccionarFecha,
            ),

            const SizedBox(height: 20),

            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white10,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Row(
                children: [
                  SizedBox(width: 80, child: Text('Fecha')),

                  Expanded(child: Text('Sorte')),

                  Expanded(child: Text('N°1')),

                  Expanded(child: Text('N°2')),

                  Expanded(child: Text('N°3')),

                  Expanded(child: Text('N°4')),

                  Expanded(child: Text('N°5')),
                ],
              ),
            ),

            const SizedBox(height: 10),
            Expanded(
              child: FutureBuilder<List<RegistroModel>>(
                future: cargarRegistros(),

                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(child: Text(snapshot.error.toString()));
                  }

                  final registros = snapshot.data ?? [];

                  return RegistrosList(
                    registros: registros,
                    onTap: editarRegistro,
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
