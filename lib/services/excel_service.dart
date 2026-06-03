//lib/services/excel_service.dart
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'registros_service.dart';
import 'package:permission_handler/permission_handler.dart';

class ExcelService {
  static Future<String> descargarPlantilla() async {
    await Permission.storage.request();
    await Permission.manageExternalStorage.request();
    final excel = Excel.createExcel();

    final sheet = excel['Registros'];

    sheet.appendRow([
      TextCellValue('fecha'),
      TextCellValue('sorte'),
      TextCellValue('bolilla_uno'),
      TextCellValue('bolilla_dos'),
      TextCellValue('bolilla_tres'),
      TextCellValue('bolilla_cuatro'),
      TextCellValue('bolilla_cinco'),
    ]);

    sheet.appendRow([
      TextCellValue('2026-01-01'),
      IntCellValue(1001),
      IntCellValue(1),
      IntCellValue(2),
      IntCellValue(3),
      IntCellValue(4),
      IntCellValue(5),
    ]);

    final bytes = excel.save();

    final directory = await getApplicationDocumentsDirectory();

    final path = '${directory.path}/plantilla_registros.xlsx';

    final file = File(path);

    await file.writeAsBytes(bytes!, flush: true);

    return path;
  }

  static Future<Map<String, int>> importarArchivo() async {
    int insertados = 0;
    int actualizados = 0;

    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx'],
    );

    if (result == null) {
      return {'insertados': 0, 'actualizados': 0};
    }

    final file = File(result.files.single.path!);

    final bytes = await file.readAsBytes();

    final excel = Excel.decodeBytes(bytes);

    final sheet = excel.tables.values.first;

    if (sheet == null) {
      throw Exception('No se encontró ninguna hoja');
    }

    for (int i = 1; i < sheet.rows.length; i++) {
      final row = sheet.rows[i];

      if (row.length < 7) {
        continue;
      }

      final fecha = DateTime.parse(row[0]!.value.toString());

      final sorte = int.parse(row[1]!.value.toString());

      final existente = await RegistrosService.buscarPorSorte(sorte);

      await RegistrosService.upsertRegistro(
        fecha: Timestamp.fromDate(fecha),
        sorte: sorte,
        bolillaUno: int.parse(row[2]!.value.toString()),
        bolillaDos: int.parse(row[3]!.value.toString()),
        bolillaTres: int.parse(row[4]!.value.toString()),
        bolillaCuatro: int.parse(row[5]!.value.toString()),
        bolillaCinco: int.parse(row[6]!.value.toString()),
      );

      if (existente == null) {
        insertados++;
      } else {
        actualizados++;
      }
    }

    return {'insertados': insertados, 'actualizados': actualizados};
  }
}
