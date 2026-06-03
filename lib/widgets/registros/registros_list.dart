//lib/widgets/registros/registros_list.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/registro_model.dart';

class RegistrosList extends StatelessWidget {
  final List<RegistroModel> registros;
  final Function(RegistroModel) onTap;

  const RegistrosList({
    super.key,
    required this.registros,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    if (registros.isEmpty) {
      return const Center(child: Text("No existen registros"));
    }

    return ListView.builder(
      itemCount: registros.length,
      itemBuilder: (context, index) {
        final registro = registros[index];

        return Card(
          margin: const EdgeInsets.symmetric(vertical: 2),
          child: InkWell(
            onTap: () => onTap(registro),

            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),

              child: Row(
                children: [
                  SizedBox(
                    width: 90,
                    child: Text(
                      DateFormat('dd/MM/yyyy').format(registro.fecha.toDate()),
                      style: const TextStyle(fontSize: 11),
                    ),
                  ),

                  Expanded(
                    child: Text(
                      registro.sorte.toString(),
                      style: const TextStyle(fontSize: 11),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      registro.bolillaUno.toString(),
                      style: const TextStyle(fontSize: 11),
                    ),
                  ),

                  Expanded(
                    child: Text(
                      registro.bolillaDos.toString(),
                      style: const TextStyle(fontSize: 11),
                    ),
                  ),

                  Expanded(
                    child: Text(
                      registro.bolillaTres.toString(),
                      style: const TextStyle(fontSize: 11),
                    ),
                  ),

                  Expanded(
                    child: Text(
                      registro.bolillaCuatro.toString(),
                      style: const TextStyle(fontSize: 11),
                    ),
                  ),

                  Expanded(
                    child: Text(
                      registro.bolillaCinco.toString(),
                      style: const TextStyle(fontSize: 11),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
