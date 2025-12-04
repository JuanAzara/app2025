import 'package:flutter/material.dart';
import 'package:vecinosreina/screens/actividad.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vecinosreina/screens/crearActividad.dart';
import 'package:vecinosreina/screens/inicio.dart';

class TallerPinturaScreen extends StatefulWidget {
  const TallerPinturaScreen({Key? key}) : super(key: key);

  @override
  State<TallerPinturaScreen> createState() => _TallerPinturaScreenState();
}

class _TallerPinturaScreenState extends State<TallerPinturaScreen> {
int _currentIndex = 1;


  void _onTabTapped(int index) {
     if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const InicioScreen()),
      );
    }
    if (index == 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const ActividadScreen()),
      );
    }
    if (index == 2) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const crearActividadScreen()),
      );
    }
  }



  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _rutController = TextEditingController();
  final TextEditingController _numeroVecinalController = TextEditingController();
  String? _tipoPublico;

  bool get _isFormValid =>
      _nombreController.text.trim().isNotEmpty &&
      _rutController.text.trim().isNotEmpty &&
      _numeroVecinalController.text.trim().isNotEmpty &&
      _tipoPublico != null;

  void _onConfirmPressed() {
    showDialog(
      context: context,
      builder: (context) => _DialogPagoActividad(
        nombre: _nombreController.text.trim(),
        rut: _rutController.text.trim(),
        numeroVecinal: _numeroVecinalController.text.trim(),
        tipoPublico: _tipoPublico!,
        onConfirmPago: () async {
  await FirebaseFirestore.instance.collection('inscripciones').add({
    'nombre': _nombreController.text.trim(),
    'rut': _rutController.text.trim(),
    'numeroVecinal': _numeroVecinalController.text.trim(),
    'tipoPublico': _tipoPublico,
    'actividad': 'Taller de Pintura',
    'fecha': '28 de Mayo - 18:30 PM',
    'monto': 7000,
    'metodoPago': 'Crédito',
    'lugar': 'Centro Cultural Vicente Bianchi - Santa Rita 1153',
    'timestamp': FieldValue.serverTimestamp(),
  });

  Navigator.of(context).pop(); 
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => const ConfirmacionInscripcionScreen(),
    ),
  );
},

      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _nombreController.addListener(() => setState(() {}));
    _rutController.addListener(() => setState(() {}));
    _numeroVecinalController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _rutController.dispose();
    _numeroVecinalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    

    return Scaffold(
      appBar: AppBar(
        title: const Text('Proceso de compra', style: TextStyle(color:Colors.white)),
        backgroundColor: cs.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Taller de pintura:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              const Text(
                'Verifique su información personal, modificar si es incorrecta.',
                style: TextStyle(fontSize: 15),
              ),
              const SizedBox(height: 32),
              TextField(
                controller: _nombreController,
                decoration: const InputDecoration(
                  labelText: 'Nombre',
                  border: UnderlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _rutController,
                decoration: const InputDecoration(
                  labelText: 'Rut',
                  border: UnderlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: _tipoPublico,
                decoration: const InputDecoration(
                  labelText: 'Tipo de público',
                  border: UnderlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(value: 'Vecino', child: Text('Vecino')),
                  DropdownMenuItem(value: 'Estudiante', child: Text('Estudiante')),
                  DropdownMenuItem(value: 'Adulto Mayor', child: Text('Adulto Mayor')),
                ],
                onChanged: (v) => setState(() => _tipoPublico = v),
                hint: const Text('Seleccionar'),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _numeroVecinalController,
                decoration: const InputDecoration(
                  labelText: 'Número Vecinal',
                  border: UnderlineInputBorder(),
                ),
              ),
              const SizedBox(height: 40),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isFormValid ? _onConfirmPressed : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        _isFormValid ? const Color(0xFF197C89) : Colors.grey.shade400,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text('Confirmar'),
                ),
              ),
            ],
          ),
        ),
      ),

       bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        selectedItemColor: Colors.grey,
        unselectedItemColor: Colors.white,
        backgroundColor: cs.primary,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color:Colors.white),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today, color:Colors.white),
            label: 'Calendario',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add, color:Colors.white),
            label: 'Crear actividades',
          ),
        ],
      ),
    );
  }
}

class _DialogPagoActividad extends StatelessWidget {
  final String nombre;
  final String rut;
  final String numeroVecinal;
  final String tipoPublico;
  final VoidCallback onConfirmPago;

  const _DialogPagoActividad({
    required this.nombre,
    required this.rut,
    required this.numeroVecinal,
    required this.tipoPublico,
    required this.onConfirmPago,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      insetPadding: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Taller de pintura:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,)),
              const SizedBox(height: 8),
              const Text('Resumen:',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const Divider(),
              const Text('Información personal:',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Text(nombre),
              Text(rut),
              Text(numeroVecinal),
              Text(tipoPublico),
              const SizedBox(height: 8),
              const Divider(),
              const Text('Taller de Pintura:',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const Text('28 de Mayo - 18:30 PM'),
              const Text('\$7.000'),
              const Text('Centro Cultural Vicente Bianchi'),
              const Divider(),
              const Text('Método de pago:',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const ListTile(
                leading: Icon(Icons.credit_card, color: Colors.red),
                title: Text('1234 56****** 6789'),
              ),
              const Divider(),
              const Text('Resumen de compra:',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text('Total'),
                  Text('\$7.000'),
                ],
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: onConfirmPago,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF197C89),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text('Confirmar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ConfirmacionInscripcionScreen extends StatelessWidget {
  const ConfirmacionInscripcionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inscripción confirmada'),
        backgroundColor: const Color(0xFF197C89),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 30),
            const Icon(Icons.check_circle, color: Colors.green, size: 120),
            const SizedBox(height: 16),
            const Text(
              '¡Ya estás inscrito!',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            const Text(
              '¡Recuerda llevar tus pinceles y acuarelas!',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
              ),
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('Taller de Pintura:',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 4),
                  Text('28 de Mayo - 18:30 PM'),
                  Text('\$7.000 - Crédito'),
                  Text('Centro Cultural Vicente Bianchi'),
                ],
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4DB6AC),
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 45),
              ),
              child: const Text('Descargar Comprobante'),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const ActividadScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF197C89),
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 45),
              ),
              child: const Text('Continuar a Mis Actividades'),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}


class PlaceholderScreen extends StatelessWidget {
  const PlaceholderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Pantalla "Otros" aún no implementada')),
    );
  }
}