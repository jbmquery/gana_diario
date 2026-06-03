import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../models/registro_model.dart';
import '../../services/registros_service.dart';

class RegistroDialog extends StatefulWidget {
  final RegistroModel? registro;

  const RegistroDialog({super.key, this.registro});

  @override
  State<RegistroDialog> createState() => _RegistroDialogState();
}

class _RegistroDialogState extends State<RegistroDialog> {
  final sorteCtrl = TextEditingController();
  final n1Ctrl = TextEditingController();
  final n2Ctrl = TextEditingController();
  final n3Ctrl = TextEditingController();
  final n4Ctrl = TextEditingController();
  final n5Ctrl = TextEditingController();

  DateTime fecha = DateTime.now();

  bool loading = false;

  @override
  void initState() {
    super.initState();

    final r = widget.registro;

    if (r != null) {
      fecha = r.fecha.toDate();

      sorteCtrl.text = r.sorte.toString();

      n1Ctrl.text = r.bolillaUno.toString();
      n2Ctrl.text = r.bolillaDos.toString();
      n3Ctrl.text = r.bolillaTres.toString();
      n4Ctrl.text = r.bolillaCuatro.toString();
      n5Ctrl.text = r.bolillaCinco.toString();
    }
  }

  Future<void> guardar() async {
    try {
      setState(() => loading = true);

      final registro = RegistroModel(
        id: widget.registro?.id,
        fecha: Timestamp.fromDate(fecha),
        sorte: int.parse(sorteCtrl.text),
        bolillaUno: int.parse(n1Ctrl.text),
        bolillaDos: int.parse(n2Ctrl.text),
        bolillaTres: int.parse(n3Ctrl.text),
        bolillaCuatro: int.parse(n4Ctrl.text),
        bolillaCinco: int.parse(n5Ctrl.text),
      );

      if (widget.registro == null) {
        await RegistrosService.crearRegistro(registro);
      } else {
        await RegistrosService.actualizarRegistro(registro);
      }

      if (mounted) {
        Navigator.pop(context);
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }

    setState(() => loading = false);
  }

  Widget numeroField(TextEditingController controller, String label) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(labelText: label),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        widget.registro == null ? 'Nuevo Registro' : 'Editar Registro',
      ),
      content: SizedBox(
        width: 500,
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: sorteCtrl,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Sorte'),
              ),

              const SizedBox(height: 10),

              numeroField(n1Ctrl, 'N°1'),
              numeroField(n2Ctrl, 'N°2'),
              numeroField(n3Ctrl, 'N°3'),
              numeroField(n4Ctrl, 'N°4'),
              numeroField(n5Ctrl, 'N°5'),

              const SizedBox(height: 15),

              ListTile(
                title: Text('${fecha.day}/${fecha.month}/${fecha.year}'),
                trailing: const Icon(Icons.calendar_month),
                onTap: () async {
                  final seleccionada = await showDatePicker(
                    context: context,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                    initialDate: fecha,
                  );

                  if (seleccionada != null) {
                    setState(() {
                      fecha = seleccionada;
                    });
                  }
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: loading ? null : guardar,
          child: const Text('Guardar'),
        ),
      ],
    );
  }
}
