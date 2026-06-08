//lib/widgets/dashboard/selector_fecha.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SelectorFecha extends StatefulWidget {
  final Function(DateTime fecha, List<int> bolillas)? onFechaChanged;

  const SelectorFecha({super.key, this.onFechaChanged});

  @override
  State<SelectorFecha> createState() => _SelectorFechaState();
}

class _SelectorFechaState extends State<SelectorFecha> {
  @override
  void dispose() {
    print("DISPOSE SELECTOR FECHA #$contadorInit");
    super.dispose();
  }

  final FirebaseFirestore db = FirebaseFirestore.instance;

  DateTime? fechaActual;

  List<int> bolillas = [];

  bool loading = true;

  @override
  void initState() {
    super.initState();
    contadorInit++;

    print("INIT SELECTOR FECHA #$contadorInit");
    cargarUltimoRegistro();
  }

  static int contadorInit = 0;

  Future<void> cargarUltimoRegistro() async {
    final snap = await db
        .collection('registros')
        .orderBy('fecha', descending: true)
        .limit(1)
        .get();

    if (snap.docs.isEmpty) return;

    final doc = snap.docs.first;

    fechaActual = (doc['fecha'] as Timestamp).toDate();

    print("ULTIMO REGISTRO => $fechaActual");

    bolillas = [
      doc['bolilla_uno'],
      doc['bolilla_dos'],
      doc['bolilla_tres'],
      doc['bolilla_cuatro'],
      doc['bolilla_cinco'],
    ];

    setState(() {
      loading = false;
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onFechaChanged?.call(fechaActual!, bolillas);
    });
  }

  Future<void> cargarPorFecha(DateTime fecha) async {
    setState(() {
      loading = true;
    });

    final inicio = DateTime(fecha.year, fecha.month, fecha.day);

    final fin = inicio.add(const Duration(days: 1));

    final snap = await db
        .collection('registros')
        .where('fecha', isGreaterThanOrEqualTo: Timestamp.fromDate(inicio))
        .where('fecha', isLessThan: Timestamp.fromDate(fin))
        .limit(1)
        .get();

    if (snap.docs.isEmpty) {
      setState(() {
        loading = false;
      });

      return;
    }

    final doc = snap.docs.first;

    fechaActual = (doc['fecha'] as Timestamp).toDate();

    print("FECHA CARGADA => $fechaActual");

    bolillas = [
      doc['bolilla_uno'],
      doc['bolilla_dos'],
      doc['bolilla_tres'],
      doc['bolilla_cuatro'],
      doc['bolilla_cinco'],
    ];

    setState(() {
      loading = false;
    });

    widget.onFechaChanged?.call(fechaActual!, bolillas);
  }

  Future<void> seleccionarFecha() async {
    if (fechaActual == null) return;

    final fecha = await showDatePicker(
      context: context,
      initialDate: fechaActual!,
      firstDate: DateTime(2010),
      lastDate: DateTime.now(),
    );

    if (fecha != null) {
      await cargarPorFecha(fecha);
    }
  }

  Future<void> moverDias(int dias) async {
    if (fechaActual == null) return;

    final nuevaFecha = fechaActual!.add(Duration(days: dias));

    await cargarPorFecha(nuevaFecha);
  }

  @override
  Widget build(BuildContext context) {
    print("BUILD SELECTOR FECHA");
    if (loading) {
      return const SizedBox(
        height: 90,
        child: Center(child: CircularProgressIndicator()),
      );
    }

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: const LinearGradient(
          colors: [Color(0xff141824), Color(0xff1D2233)],
        ),
        boxShadow: const [
          BoxShadow(color: Color(0x337B2FFF), blurRadius: 12, spreadRadius: 1),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              _botonNavegacion(Icons.chevron_left, () => moverDias(-1)),

              Expanded(
                child: GestureDetector(
                  onTap: seleccionarFecha,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: const Color(0xff23293B),
                    ),
                    child: Text(
                      DateFormat('dd/MM/yyyy').format(fechaActual!),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Color(0xff00F5FF),
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),

              _botonNavegacion(Icons.chevron_right, () => moverDias(1)),
            ],
          ),

          const SizedBox(height: 10),

          Wrap(
            spacing: 6,
            runSpacing: 6,
            alignment: WrapAlignment.center,
            children: bolillas
                .map(
                  (n) => Container(
                    width: 42,
                    height: 42,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [Color(0xff00F5FF), Color(0xff7B2FFF)],
                      ),
                      boxShadow: [
                        BoxShadow(color: Color(0x5500F5FF), blurRadius: 8),
                      ],
                    ),
                    child: Text(
                      n.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _botonNavegacion(IconData icon, VoidCallback onPressed) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: const LinearGradient(
          colors: [Color(0xff23293B), Color(0xff23293B)],
        ),
      ),
      child: IconButton(
        padding: EdgeInsets.zero,
        onPressed: onPressed,
        icon: Icon(icon, color: Colors.white, size: 20),
      ),
    );
  }
}
