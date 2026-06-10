//lib/widgets/registros/registros_toolbar.dart
import 'package:flutter/material.dart';

class RegistrosToolbar extends StatelessWidget {
  final TextEditingController sorteController;

  final VoidCallback onNuevoRegistro;
  final VoidCallback onExportarExcel;
  final VoidCallback onImportarExcel;
  final VoidCallback onDescargarPlantilla;
  final VoidCallback onSeleccionarFecha;
  final ValueChanged<String> onBuscar;

  final DateTime? fechaFiltro;

  const RegistrosToolbar({
    super.key,
    required this.sorteController,
    required this.onNuevoRegistro,
    required this.onExportarExcel,
    required this.onImportarExcel,
    required this.onDescargarPlantilla,
    required this.onSeleccionarFecha,
    required this.onBuscar,
    required this.fechaFiltro,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Tooltip(
          message:
              "Cargar XLSX\n(Mantener presionado para descargar plantilla)",
          child: GestureDetector(
            onLongPress: onDescargarPlantilla,
            child: IconButton(
              onPressed: onImportarExcel,
              icon: const Icon(Icons.upload_file, size: 28),
            ),
          ),
        ),

        const SizedBox(width: 8),

        Expanded(
          child: InkWell(
            onTap: onSeleccionarFecha,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              height: 48,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white10,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.white24),
              ),
              child: Row(
                children: [
                  const Icon(Icons.calendar_month, size: 20),

                  const SizedBox(width: 8),

                  Expanded(
                    child: Text(
                      fechaFiltro == null
                          ? 'Fecha'
                          : '${fechaFiltro!.day}/${fechaFiltro!.month}/${fechaFiltro!.year}',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),

                  if (fechaFiltro != null)
                    GestureDetector(
                      onTap: () {},
                      child: const Icon(Icons.close, size: 18),
                    ),
                ],
              ),
            ),
          ),
        ),

        const SizedBox(width: 8),

        SizedBox(
          width: 120,
          child: TextField(
            controller: sorteController,
            onChanged: onBuscar,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              hintText: 'Sorte',
              prefixIcon: Icon(Icons.search),
              isDense: true,
            ),
          ),
        ),

        const SizedBox(width: 8),

        Tooltip(
          message: "Nuevo Registro\n(Mantener presionado para exportar Excel)",
          child: GestureDetector(
            onLongPress: onExportarExcel,
            child: IconButton(
              onPressed: onNuevoRegistro,
              icon: const Icon(Icons.add_circle, size: 30),
            ),
          ),
        ),
      ],
    );
  }
}
